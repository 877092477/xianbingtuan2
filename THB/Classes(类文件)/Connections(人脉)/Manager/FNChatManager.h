//
//  FNChatManager.h
//  THB
//
//  Created by Weller Zhao on 2019/1/30.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "FNChatModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNChatManager : NSObject

+(instancetype) shareInstance;

@property (nonatomic, strong) ProfileModel *user;

typedef void(^FNChatOfflineMessageBlock)(NSArray<FNChatModel*> *chats);
typedef void(^FNChatSendBlock)(FNChatModel* chat);
typedef void(^FNChatSendRedPackBlock)(FNChatModel* chat, NSString *msg);

/**
 注册
 */
- (void)enroll;

/**
 退出
 */
- (void)quit;

/**
 发送文本

 @param msg 文本内容
 @param uid 接收id
 @param target 目标类型
 @param block 回调
 */
- (void)sendMessage: (NSString*)msg toUid: (NSString*)uid withTarget: (NSString*)target block: (FNChatSendBlock)block;


/**
 发送图片

 @param image UIImage
 @param uid 接收目标id
 @param target 目标类型：发送人-ren 发送群-qun
 */
- (void)sendImage: (UIImage*)image toUid: (NSString*)uid withTarget: (NSString*)target block: (FNChatSendBlock)block;

/**
 发送语音

 @param audio NSURL文件路径
 @param uid 接收目标id
 @param target 目标类型：发送人-ren 发送群-qun
 */
- (void)sendAudio: (NSURL*)fileUrl toUid: (NSString*)uid withTarget: (NSString*)target block: (FNChatSendBlock)block;

/**
 发送视频

 @param asset 视频
 @param uid 接收目标id
 @param target 目标类型：发送人-ren 发送群-qun
 */
- (void)sendVideoWithAsset: (PHAsset*)asset toUid: (NSString*)uid withTarget: (NSString*)target block: (FNChatSendBlock)block;
- (void)sendVideoWithURLAsset:(AVURLAsset *)urlAsset toUid:(NSString *)uid withTarget:(NSString *)target block:(FNChatSendBlock)block;

/**
 人脉商品库分享商品操作
 @param msg 商品信息
 @param uid 接收目标id
 @param target 目标类型：发送人-ren 发送群-qun
 */
-(void)sendGoodsDictry:(NSDictionary *)msg toUid: (NSString*)uid withTarget: (NSString*)target block: (FNChatSendBlock)block;

/**
 发红包
 @param params 发红包信息
 @param pay_type 支付类型
 @param uid 接收目标id
 @param target 目标类型：发送人-ren 发送群-qun
 */

-(void)sendGiveRedEnvelopesDictry:(NSMutableDictionary*)params paymodel:(NSString*)pay_type toUid: (NSString*)uid withTarget: (NSString*)target redpackBlock:(FNChatSendRedPackBlock)block;
/**
 发送领红包记录
 @param status 红包类型 已领取 已领完 开红包
 @param hb_id  红包id
 @param uid 接收目标id
 @param target 目标类型：发送人-ren 发送群-qun
 */
- (void)sendOpenRedEnvelopes:(NSString*)status withhb_id:(NSString*)hb_id toUid:(NSString*)uid withTarget:(NSString*)target;

- (FNChatModel*)searchTopChat: (NSString*)roomID;
- (void) getOfflineMessageFromRoom: (NSString*)room byTarget: (NSString*)target afterID: (NSString*)msgID withBlock: (FNChatOfflineMessageBlock)block;


/**
 重发消息

 @param chat 消息
 */
- (void)reSend: (FNChatModel*)chat;

+ (NSString*) getVideoPathWithFileName: (NSString*)filename ;

@end

NS_ASSUME_NONNULL_END
