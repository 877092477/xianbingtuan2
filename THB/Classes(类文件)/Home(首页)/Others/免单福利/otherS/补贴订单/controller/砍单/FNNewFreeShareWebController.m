//
//  FNNewFreeShareWebController.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/27.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNNewFreeShareWebController.h"
#import "WebViewJavascriptBridge.h"
#import "FNNewFreeProductDetailModel.h"
#import "FNNewFreeProductShareAlertView.h"

@interface FNNewFreeShareWebController ()<UIWebViewDelegate>

@property(nonatomic,strong)WebViewJavascriptBridge *bridge;
@property(nonatomic,strong)NSArray<FNNewFreeProductDetailShareModel*> *shareList;

@end

@implementation FNNewFreeShareWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.bridge setWebViewDelegate:self];
    [self.bridge registerHandler:@"WebViewJavascriptBridge" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"js call ObjC, data from js is :%@", data);
        
        NSString *identifier = [data objectForKey:@"identifier"];
        NSString *typeTwo = [data objectForKey:@"identifier2"];
        if([typeTwo kr_isNotEmpty]){
            identifier=typeTwo;
        }
        // 根据不同的标识跳转
        [self jumpToActionFromWebJSMethod:identifier data:data];
    }];
}

-(void)jumpToActionFromWebJSMethod:(NSString *)identifier data:(id)data{
    if ([identifier isEqualToString:@"app_share"]) {
        
        NSString *string = data[@"comFrom"];
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        id dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (dict == nil || error) {
            NSLog(@"%@", error.localizedDescription);
            return;
        }
        NSString *share_title = dict[@"share_title"];
        NSString *share_content = dict[@"share_content"];
        NSString *share_img = dict[@"share_img"];
        NSString *share_url = dict[@"share_url"];
        @weakify(self)
        [self apiRequestShareList:^{
            @strongify(self)
            [self shareProduct:share_title withImage:share_img withContent:share_content andUrl:share_url];
        }];
        
    }
}

- (FNRequestTool *)apiRequestShareList: (void(^)()) block{
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey: UserAccessToken}];
    
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=bargainList&ctrl=share_ico" respondType:(ResponseTypeArray) modelType:@"FNNewFreeProductDetailShareModel" success:^(id respondsObject) {
        @strongify(self);
        self.shareList = respondsObject;
        block();
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:NO];
}

- (void) shareProduct: (NSString*)share_title withImage: (NSString*)share_img withContent: (NSString*)share_content andUrl: (NSString*)share_url {
    NSMutableArray *images = [[NSMutableArray alloc] init];
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (FNNewFreeProductDetailShareModel *share in self.shareList) {
        [images addObject:share.img];
        [titles addObject:share.name];
    }
    @weakify(self)
    [FNNewFreeProductShareAlertView showImages:images withTitles:titles bottomOffset:0 onClick:^(NSInteger index) {
        @strongify(self)

        [FNNewFreeProductShareAlertView dismiss];
        FNNewFreeProductDetailShareModel *share = self.shareList[index];

        UMSocialPlatformType type = 0;
        if ([share.type isEqualToString:@"wechat"]) {
            type = UMSocialPlatformType_WechatSession;
        } else if ([share.type isEqualToString:@"friendcircle"]) {
            type = UMSocialPlatformType_WechatTimeLine;
        } else if ([share.type isEqualToString:@"qq"]) {
            type = UMSocialPlatformType_QQ;
        } else if ([share.type isEqualToString:@"microblog"]) {
            type = UMSocialPlatformType_Sina;
        }

        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建网页内容对象
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:share_title descr:share_content thumImage:share_img];
        //设置网页地址
        shareObject.webpageUrl = share_url;
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            if (error) {
                NSLog(@"************Share fail with error %@*********",error);
            }else{
                NSLog(@"response data is %@",data);
            }
        }];

    }];
}

@end
