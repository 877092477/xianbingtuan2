//
//  FNChatManager.m
//  THB
//
//  Created by Weller Zhao on 2019/1/30.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNChatManager.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "WKWebViewJavascriptBridge.h"
#import "FNChatModel.h"
#import "LKDBHelper/NSObject+LKDBHelper.h"
#import <WebKit/WebKit.h>
#import "FNWebVideoManager.h"
#import "FNWebVoiceManager.h"
#import "FNAudioRecordManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "JPUSHService.h"
#import "EBBannerView/EBBannerView.h"

#import "FNConnectionsHomeController.h"
#import "FNConnectionsChatController.h"
#import "NSString+Emoji.h"

@interface FNChatManager()<WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>

typedef void(^UploadBlock)(NSString* url);

@property (nonatomic, strong) NSMutableArray<FNChatModel*> *queue;

@property (nonatomic, strong) WKWebView *webview;
@property (nonatomic, strong) WKWebViewJavascriptBridge *bridge;
// 记录房间号是否已经获取过离线消息
@property (nonatomic, strong) NSMutableDictionary<NSString*, NSString*> *isUpdateOffineMessage;
@property (nonatomic, assign) int count;

@end

@implementation FNChatManager

#define UserID FNChatManager.shareInstance.user.id
#define UserHeadImage FNChatManager.shareInstance.user.head_img

static FNChatManager* _instance = nil;

- (NSMutableArray<FNChatModel*>*) queue {
    if (_queue == nil) {
        _queue = [[NSMutableArray alloc] init];
    }
    return _queue;
}

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    });
    
    return _instance ;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [FNChatManager shareInstance] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [FNChatManager shareInstance] ;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isUpdateOffineMessage = [[NSMutableDictionary alloc] init];
        _count = 0;
    }
    return self;
}

- (void)enroll {
    
    _count = 0;
    [self requestMine];
    
    [self quit];
    [_isUpdateOffineMessage removeAllObjects];
    
    //1、该对象提供了通过js向web view发送消息的途径
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    //添加在js中操作的对象名称，通过该对象来向web view发送消息
    [userContentController addScriptMessageHandler:self name:@"WebViewJavascriptBridge"];
    
    //2、
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    config.userContentController = userContentController;
    
    self.webview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenHeight) configuration:config];
    [FNKeyWindow insertSubview:self.webview atIndex:0];
    
    NSString *url =[NSString stringWithFormat:@"%@%@%@",IP,_api_showorder_WirteCache,UserAccessToken];
    NSURL *webUrl = [NSURL URLWithString:url];
    NSURLRequest *request =[NSURLRequest requestWithURL:webUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    
    [self.webview loadRequest:request];
    self.webview.UIDelegate = self;
    self.webview.navigationDelegate = self;
}

- (void)quit {
    [self.webview removeFromSuperview];
    self.webview.UIDelegate = nil;
    self.webview.navigationDelegate = nil;
    self.webview = nil;
}

#pragma mark - Web view delegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}
// 当内容开始到达时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSString *currentURL = webView.URL.absoluteString;
    if ([currentURL containsString:_api_showorder_WirteCache]) {
        NSLog(@"缓存写入成功");
        
        NSString *url = @"mod=appapi&act=lt&ctrl=html";
        NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        urlStr = [[NSMutableString stringWithString:IP] stringByAppendingFormat:@"%@",url];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                        [NSURL URLWithString: urlStr]];
        [self.webview loadRequest:request];
        
        return;
    }
    
    if ([currentURL containsString:@"mod=appapi&act=lt&ctrl=html"]) {
        self.bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webview];
        [self.bridge setWebViewDelegate:self];
        @weakify(self)
        [self.bridge registerHandler:@"WebViewJavascriptBridge" handler:^(id data, WVJBResponseCallback responseCallback) {
 
            
            NSString *identifier = [data objectForKey:@"identifier"];
            if ([identifier isEqualToString:@"liaotian"]) {
                id content = [data objectForKey:@"comFrom"];
                
                FNChatModel *chat = [FNChatModel mj_objectWithKeyValues: content];
                FNChatModel *top = [self_weak_ searchTopChat:chat.room];
                if ([chat.type isEqualToString:@"msg"]) {
                    chat.data = [chat.data emojiDecode];
                }
                NSLog(@"聊天消息:%@", data);
                
                //获取离线消息
                [self_weak_ getOfflineMessageFromRoom:chat.room byTarget:chat.target afterID:top.ID withBlock:^(NSArray<FNChatModel *> * _Nonnull chats) {

                    if (chats == nil || chats.count == 0) {
                        [self_weak_ saveOrUpdate:chat];
                    }
                    
                    [self_weak_ sendNotification: chat];
            
                    [FNNotificationCenter postNotificationName:@"onNewChatMessage" object:nil userInfo:@{@"chat": chat}];
                }];

            }
        }];
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"didFailProvisionalNavigation %@", error.localizedDescription);
    [webView reload];
}

- (void)saveOrUpdate: (FNChatModel*)chat {
    FNChatModel *model= nil;
    if ([chat.return_str kr_isNotEmpty])
        model = [FNChatModel searchWithWhere:[NSString stringWithFormat:@"return_str = '%@'", chat.return_str] orderBy:@"" offset:0 count:1].firstObject;
    if (model) {
        //用后台通知更新数据库中的数据
        chat.rowid = model.rowid;
        
        NSLog(@"update db at %ld with data: %@ timestamp: %@", model.rowid, chat.data, chat.return_str);
        chat.status = 0;
        [chat updateToDB];
    } else {
        [chat saveToDB];
    }
}

- (FNChatModel*)searchTopChat: (NSString*)roomID {
    NSString *condition = [NSString stringWithFormat:@"room = '%@'", roomID];
    return [FNChatModel searchWithWhere:condition orderBy:@"rowid DESC" offset:0 count:1].firstObject;
}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"didReceiveScriptMessage %@", message);
}

-(void)requestMine{
    if (_count >= 3)
        return;
    _count ++;
    @weakify(self)
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    [FNRequestTool requestWithParams:params api:_api_mine_getUserInfo respondType:(ResponseTypeModel) modelType:@"ProfileModel" success:^(id respondsObject) {
        @strongify(self)
        self.user = respondsObject;
        self.count = 0;
    } failure:^(NSString *error) {
        
        [self requestMine];
    } isHideTips:YES];
}


#pragma mark - Action

/**
 发送消息

 @param msg 内容
 @param uid 接收目标id
 @param type 消息类型：分享商品-share_goods 图片-image 文字-msg 语音-audio 视频-video 红包-hongbao 领红包记录-hongbao_record
 @param target 目标类型：发送人-ren 发送群-qun
 */
 
- (void)sendMessage: (FNChatModel*)chat {
    
    [self.queue addObject: chat];
    if (self.queue.count == 1)
        [self roll];
    
}

- (void) roll {
    if (self.queue.count <= 0)
        return;
    FNChatModel *chat = self.queue[0];
    chat.return_str = [NSString GetNowMillisecond];
    [chat updateToDB];
    @weakify(self)
    //两秒延迟，防止服务器并发处理错误
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSMutableString *str = [NSMutableString stringWithString:chat.data];
        NSString *data = [chat.data stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        data = [data stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        if ([chat.type isEqualToString:@"msg"]) {
            data = [data emojiEncode];
//            data = [data kr_encodeBase64];
        }
        NSString *jsFunctStr=[NSString stringWithFormat: @"app_send('%@','%@','%@','%@','%@')", chat.sendee_uid, chat.target, chat.type, data, chat.return_str];
        @strongify(self)
        @weakify(self)
        [self.webview evaluateJavaScript:jsFunctStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            @strongify(self)
            if (error) {
                NSLog(@"sendMessage error: %@", error);
            }
            [self.queue removeObjectAtIndex:0];
            [self roll];

        }];
    });
    
    
}

- (void)sendMessage: (NSString*)msg toUid: (NSString*)uid withTarget: (NSString*)target block: (FNChatSendBlock)block{
    FNChatModel *model = [[FNChatModel alloc] init];
    model.type = @"msg";
    model.data = msg;
    model.sendee_uid = uid;
    model.send_uid = UserID;
    model.head_img = UserHeadImage;
    model.return_str = [NSString GetNowMillisecond];
    model.lr = @"r";
    model.target = target;
    model.status = 1;
    [model saveToDB];
    
    block(model);
    
    [self sendMessage:model];
}
#pragma mark - 人脉商品库分享商品操作 
-(void)sendGoodsDictry:(NSDictionary *)dic toUid: (NSString*)uid withTarget: (NSString*)target block: (FNChatSendBlock)block {
    NSString *jointStr=[self dictryTransitionString:dic];
    NSString *dicString=[self removeSpaceAndNewline:jointStr];
    FNChatModel *model = [[FNChatModel alloc] init];
    model.type = @"share_goods";
    model.data = dicString;
    model.sendee_uid = uid;
    model.send_uid = UserID;
    model.head_img = UserHeadImage;
    model.return_str = [NSString GetNowMillisecond];
    model.lr = @"r";
    model.target = target;
    model.status = 1;
    [model saveToDB];
    block(model);
    @weakify(self)
    NSString *urlString=@"mod=appapi&act=appGoodsBankShare&ctrl=index";
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{}];
    params[@"data"]=dicString;
    params[@"time"]=[NSString GetNowTimes];
    params[@"token"]=UserAccessToken;
    [FNRequestTool requestWithParams:params api:urlString respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSDictionary*dictry = respondsObject;
        NSInteger success = [dictry[@"success"] integerValue];
        if (success == 1) {
            [self_weak_ sendMessage:model];
        }else {
            NSString *msgStr = dictry[@"msg"];
            [FNTipsView showTips:msgStr];
        }
    } failure:^(NSString *error) {
        [FNTipsView showTips:@"分享宝贝失败, 请稍候再试"];
    } isHideTips:NO];

}
#pragma mark - 发红包
-(void)sendGiveRedEnvelopesDictry:(NSMutableDictionary*)params paymodel:(NSString*)pay_type toUid: (NSString*)uid withTarget: (NSString*)target redpackBlock:(FNChatSendRedPackBlock)block {
    FNChatModel *model = [[FNChatModel alloc] init];
    model.type = @"hongbao";
    model.data = @"";
    model.sendee_uid = uid;
    model.send_uid = UserID;
    model.head_img = UserHeadImage;
    model.return_str = [NSString GetNowMillisecond];
    model.lr = @"r";
    model.target = target;
    model.is_own_send = @"1";
    model.status = 1;
    model.hb_info = params[@"info"];
    [model saveToDB];
    @weakify(self)
    NSString *urlString=@"mod=appapi&act=lt_hb&ctrl=create_hb";
    [FNRequestTool requestWithParams:params api:urlString respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSDictionary *dataDic=respondsObject[DataKey];
        NSString *hb_id=dataDic[@"hb_id"];
        NSString *code=dataDic[@"code"];
        NSInteger success = [respondsObject[@"success"] integerValue];
        if([pay_type isEqualToString:@"money"]){
            if([hb_id kr_isNotEmpty]){
                if (success == 1) {
                    model.data = hb_id;
                    model.hb_id = hb_id;
                    [model updateToDB];
                    [self_weak_ sendMessage:model];
                    block(model, @"成功");
                }else {
                    [model deleteToDB];
                    NSString *msgStr = dataDic[@"msg"];
                    [FNTipsView showTips:msgStr]; 
                }
            }
        }
        else if([pay_type isEqualToString:@"alipay"]){
            [[AlipaySDK defaultService] payOrder:code fromScheme:AlisdkSchemes callback:^(NSDictionary *resultDic) {
                XYLog(@"支付:%@",resultDic);
                if ([NSString checkIsSuccess:resultDic[@"resultStatus"] andElement:@"9000"] ) {
                    [FNTipsView showTips:ResultStatusDict[@"9000"]];
                    model.data = hb_id;
                    model.hb_id = hb_id;
                    [model updateToDB];
                    [self_weak_ sendMessage:model];
                    block(model, @"成功");
                }else{
                    [model deleteToDB];
                    NSString *result=ResultStatusDict[resultDic[@"resultStatus"] ];
                    [FNTipsView showTips:result withDuration:2.0];
                    block(nil, @"成功");
                }
            }];
        }
    } failure:^(NSString *error) {
        XYLog(@"红包Error:%@",error);
        [model deleteToDB];
        block(nil, error);
    } isHideTips:NO isCache:NO];
}
//点击红包
- (void)sendOpenRedEnvelopes:(NSString*)status withhb_id:(NSString*)hb_id toUid:(NSString*)uid withTarget:(NSString*)target{
    FNChatModel *model = [[FNChatModel alloc] init];
    model.type = @"hongbao_record";
    model.sendee_uid = uid;
    model.send_uid = UserID;
    model.head_img = UserHeadImage;
    model.return_str = [NSString GetNowMillisecond];
    model.lr = @"r";
    model.target = target;
    model.status = 1;
    model.hb_id = hb_id;
//    [model saveToDB];
//    block(model);
    [self sendMessage:model];
}

- (void)sendImage: (UIImage*)image toUid: (NSString*)uid withTarget: (NSString*)target block: (FNChatSendBlock)block{

    FNChatModel *model = [[FNChatModel alloc] init];
    model.type = @"image";
    
    model.sendee_uid = uid;
    model.send_uid = UserID;
    model.head_img = UserHeadImage;
    model.return_str = [NSString GetNowMillisecond];
    model.lr = @"r";
    model.target = target;
    model.status = 1;
    model.coverImage = image;
    model.size = image.size;
    [model saveToDB];
    block(model);
    
    @weakify(self)
    [self uploadImage:image block:^(NSString *url) {
        if (![url kr_isNotEmpty])
            return;
        model.data = url;
        [model updateToDB];
        [self_weak_ sendMessage:model];
        
    }];
}

/**
 上传图片

 @param image UIImage
 @param block 回掉
 */
- (void)uploadImage: (UIImage*)image block: (UploadBlock)block {
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    NSData *data= [UIImage scaleData:image toKb:MAX_IMAGE_SIZE];
    NSString * fileName = [NSString stringWithFormat:@"%@_image.jpg",[NSString GetNowMillisecond]];
    [FNRequestTool uploadDataWithParams:params api:@"mod=appapi&act=lt&ctrl=upload_image" data:data withKey:@"image" fileName:fileName success:^(id respondsObject) {
        NSDictionary*dictry = respondsObject;
        NSInteger success = [dictry[@"success"] integerValue];
        if (success == 1) {
            NSString *image = dictry[@"data"][@"image"];
            block (image);
        } else {
            NSString *msg = dictry[@"msg"];
            [FNTipsView showTips:msg];
            block (nil);
        }
        
    } failure:^(NSString *error) {
        [FNTipsView showTips:@"图片上传失败，请稍候再试"];
        block (nil);
    }];
}

- (void)sendAudio: (NSURL*)fileUrl toUid: (NSString*)uid withTarget: (NSString*)target block: (FNChatSendBlock)block{

    NSData *audio = [NSData dataWithContentsOfURL:fileUrl];
    FNChatModel *model = [[FNChatModel alloc] init];
    model.type = @"audio";
    model.sendee_uid = uid;
    model.send_uid = UserID;
    model.head_img = UserHeadImage;
    model.return_str = [NSString GetNowMillisecond];
    model.lr = @"r";
    model.target = target;
    model.status = 1;
//    model.uploadData = audio;
    model.fileName = fileUrl.lastPathComponent;
    model.length = [FNWebVoiceManager getVoiceLength:fileUrl];
    [model saveToDB];
    block(model);
    
    @weakify(self)
    @weakify(model)
    [self uploadAudio:audio block:^(NSString *url) {
        @strongify(model)
        @strongify(self)
        model.data = url;
        [model updateToDB];
        [self sendMessage: model];
    }];
}

- (void)uploadAudio: (NSData*)audio block: (UploadBlock)block {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    NSString * fileName = [NSString stringWithFormat:@"%@.wav",[NSString GetNowMillisecond]];
    [FNRequestTool uploadDataWithParams:params api:@"mod=appapi&act=lt&ctrl=upload_audio" data:audio withKey:@"audio" fileName:fileName success:^(id respondsObject) {
        NSDictionary*dictry = respondsObject;
        NSInteger success = [dictry[@"success"] integerValue];
        if (success == 1) {
            NSString *audio = dictry[@"data"][@"audio"];
            
            block(audio);
        } else {
            NSString *msg = dictry[@"msg"];
            [FNTipsView showTips:msg];
            block(nil);
        }
        
    } failure:^(NSString *error) {
        [FNTipsView showTips:@"语音发送失败，请稍候再试"];
        block(nil);
    }];
}

+ (NSString*) getVideoPathWithFileName: (NSString*)filename {
    NSString* path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
                      stringByAppendingPathComponent:filename];
    return path;
}

- (void)sendVideoWithURLAsset:(AVURLAsset *)urlAsset toUid:(NSString *)uid withTarget:(NSString *)target block:(FNChatSendBlock)block {
    
    NSLog(@"压缩前大小 %f MB",[self fileSize:urlAsset.URL]);
    // 创建AVAsset对象
    AVAsset* asset = [AVAsset assetWithURL:urlAsset.URL];
    AVAssetExportSession * session = [[AVAssetExportSession alloc]
                                      initWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
    //优化网络
    session.shouldOptimizeForNetworkUse = YES;
    //转换后的格式
    //拼接输出文件路径 为了防止同名 可以根据日期拼接名字 或者对名字进行MD5加密
    NSString* path = [FNChatManager getVideoPathWithFileName:[NSString stringWithFormat:@"hello_%@.mp4", [NSString GetNowTimes]]];
    //判断文件是否存在，如果已经存在删除
    [[NSFileManager defaultManager]removeItemAtPath:path error:nil];
    //设置输出路径
    session.outputURL = [NSURL fileURLWithPath:path];
    //设置输出类型 这里可以更改输出的类型 具体可以看文档描述
    session.outputFileType = AVFileTypeMPEG4;
    [session exportAsynchronouslyWithCompletionHandler:^{
        NSLog(@"%@",[NSThread currentThread]);
        //压缩完成
        if(session.status==AVAssetExportSessionStatusCompleted) {
            //在主线程中刷新UI界面，弹出控制器通知用户压缩完成
            NSLog(@"导出完成");
            NSURL *CompressURL = session.outputURL;
            NSLog(@"压缩完毕,压缩后大小 %f MB",[self fileSize:CompressURL]);
            FNChatModel *model = [[FNChatModel alloc] init];
            //                    NSData *data = [NSData dataWithContentsOfURL:CompressURL];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                model.type = @"video";
                model.sendee_uid = uid;
                model.send_uid = UserID;
                model.head_img = UserHeadImage;
                model.return_str = [NSString GetNowMillisecond];
                model.lr = @"r";
                model.target = target;
                model.status = 1;
                UIImage *coverImage = [FNWebVideoManager getImage:CompressURL];
                model.coverImage = coverImage;
                model.size = coverImage.size;
                //                        model.uploadData = data;
                model.fileName = CompressURL.lastPathComponent;
                [model saveToDB];
                block(model);
            });
            @weakify(self)
            @weakify(model)
            NSData *data = [NSData dataWithContentsOfURL: CompressURL];
            [self uploadVideo:data block:^(NSString *url) {
                @strongify(self)
                @strongify(model)
                model.data = url;
                [model updateToDB];
                [self sendMessage:model];
            }];
            
        }
    }];
    
}

- (void)sendVideoWithAsset: (PHAsset*)asset toUid: (NSString*)uid withTarget: (NSString*)target block: (FNChatSendBlock)block{
    
    PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
    options.version = PHVideoRequestOptionsVersionOriginal;
    [[PHImageManager defaultManager] requestAVAssetForVideo:asset options:options resultHandler:^(AVAsset *asset, AVAudioMix *audioMix, NSDictionary *info) {
        if ([asset isKindOfClass:[AVURLAsset class]]) {
            AVURLAsset* urlAsset = (AVURLAsset*)asset;
            
            [self sendVideoWithURLAsset:urlAsset toUid:uid withTarget:target block:block];
            
        }}];
}

- (void)uploadVideo: (NSData*)video block: (UploadBlock)block {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    
    NSString * fileName = [NSString stringWithFormat:@"%@_video.mp4",[NSString GetNowMillisecond]];
    [FNRequestTool uploadDataWithParams:params api:@"mod=appapi&act=lt&ctrl=upload_video" data:video withKey:@"video" fileName:fileName success:^(id respondsObject) {
        NSDictionary*dictry = respondsObject;
        NSInteger success = [dictry[@"success"] integerValue];
        if (success == 1) {
            NSString *video = dictry[@"data"][@"video"];
            block(video);
        } else {
            NSString *msg = dictry[@"msg"];
            [FNTipsView showTips:msg];
            block(nil);
        }
        
    } failure:^(NSString *error) {
        [FNTipsView showTips:@"视频发送失败，请稍候再试"];
        block(nil);
    }];
}


- (CGFloat)fileSize:(NSURL *)path
{
    return [[NSData dataWithContentsOfURL:path] length]/1024.00 /1024.00;
}

- (void) getOfflineMessageFromRoom: (NSString*)room byTarget: (NSString*)target afterID: (NSString*)msgID withBlock: (FNChatOfflineMessageBlock)block {
    
    if (![room kr_isNotEmpty]) {
        block(@[]);
        return;
    }

    NSString *record = _isUpdateOffineMessage[room];
    if ([record kr_isNotEmpty]) {
        block(@[]);
        return;
    }
    _isUpdateOffineMessage[room] = @"1";
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"room": room, @"target": target, @"type": @"2"}];
    if ([msgID kr_isNotEmpty]) {
        params[@"id"] = msgID;
    }
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=lt&ctrl=lt_jl" respondType:(ResponseTypeArray) modelType:@"FNChatModel" success:^(id respondsObject) {
        NSArray<FNChatModel*> *chats = respondsObject;
        for (FNChatModel *chat in chats) {
            if ([chat.type isEqualToString:@"msg"]) {
                chat.data = [chat.data emojiDecode];
            }
            [chat saveToDB];
        }
        block(chats);
    } failure:^(NSString *error) {
        //
    } isHideTips:YES];
}


#pragma mark - //字符串空格
- (NSString *)removeSpaceAndNewline:(NSString *)str{
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}
-(NSString *)dictryTransitionString:(NSDictionary*)dictry{
    NSData *data=[NSJSONSerialization dataWithJSONObject:dictry options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return jsonStr;
}

- (void)reSend: (FNChatModel*)chat {
    chat.return_str = [NSString GetNowMillisecond];
    [chat updateToDB];
    
    if ([chat.data kr_isNotEmpty]) {
        [self sendMessage:chat];
        return;
    }
    if ([chat.type isEqualToString:@"share_goods"]) {
        
    } else if ([chat.type isEqualToString:@"image"]) {
        @weakify(self)
        [self uploadImage:chat.coverImage block:^(NSString *url) {
            if (![url kr_isNotEmpty])
                return;
            chat.data = url;
            [chat updateToDB];
            [self_weak_ sendMessage:chat];
            
        }];
    } else if ([chat.type isEqualToString:@"msg"]) {
        [self sendMessage:chat];
    } else if ([chat.type isEqualToString:@"audio"]) {
        //未上传成功，重新上传并发送
        if (![chat.fileName kr_isNotEmpty])
            return;
        @weakify(self)
        NSData *data = [FNAudioRecordManager.shareInstance getDataWithFileName:chat.fileName];
        if (data == nil)
            return;
        [self uploadAudio:data block:^(NSString *url) {
            if (![url kr_isNotEmpty])
                return;
            chat.data = url;
            [chat updateToDB];
            [self_weak_ sendMessage:chat];
        }];
    } else if ([chat.type isEqualToString:@"video"]) {
        //未上传成功，重新上传并发送
        if (![chat.fileName kr_isNotEmpty])
            return;
        @weakify(self)
        NSData *data = [NSData dataWithContentsOfFile:[FNChatManager getVideoPathWithFileName:chat.fileName]];
        if (data == nil)
            return;
        [self uploadVideo:data block:^(NSString *url) {
            if (![url kr_isNotEmpty])
                return;
            chat.data = url;
            [chat updateToDB];
            [self_weak_ sendMessage:chat];
        }];
    } else if ([chat.type isEqualToString:@"hongbao"]) {
        
    } else if ([chat.type isEqualToString:@"hongbao_record"]) {
    }
}

#pragma mark - 推送
- (void)sendNotification: (FNChatModel*)chat {
    
    if ([chat.lr isEqualToString:@"r"]) {
        return;
    }
    
    UIViewController * currVC = nil;
    UIViewController * Rootvc = FNKeyWindow.rootViewController ;
    do {
        
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController * v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            for (UIViewController *vc in nav.viewControllers) {
                if ([vc isKindOfClass:[FNConnectionsHomeController class]] || [vc isKindOfClass: [FNConnectionsChatController class]]) {
                    return;
                }
            }
            continue;
        }else if([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        } else {
            break;
        }
    } while (Rootvc!=nil);
    
    NSString *msg = chat.data;
    if ([chat.type isEqualToString:@"share_goods"]) {
        msg = @"分享商品";
    } else if ([chat.type isEqualToString:@"image"]) {
        msg = @"【图片】";
    } else if ([chat.type isEqualToString:@"audio"]) {
        msg = @"【语音】";
    } else if ([chat.type isEqualToString:@"video"]) {
        msg = @"【视频】";
    } else if ([chat.type isEqualToString:@"hongbao"]) {
        msg = @"【红包】";
    }
    
    //https://juejin.im/post/5853b8998e450a006c556839
    EBBannerView *banner = [EBBannerView bannerWithBlock:^(EBBannerViewMaker *make) {
        make.style = EBBannerViewStyleiOS10;
        make.content = msg;
        make.object = chat;
    }];
    [banner show];
    
}


 
@end
