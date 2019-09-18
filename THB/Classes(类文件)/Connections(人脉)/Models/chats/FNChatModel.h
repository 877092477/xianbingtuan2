//
//  FNChatModel.h
//  THB
//
//  Created by Weller Zhao on 2019/2/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNChatModel : NSObject

@property (nonatomic, copy) NSString* ID;

/**
 发送人-ren
 发送群-qun
 */
@property (nonatomic, copy) NSString* target;
@property (nonatomic, copy) NSString* send_uid;
@property (nonatomic, copy) NSString* sendee_uid;
@property (nonatomic, copy) NSString* room;

/**
 分享商品-share_goods
 图片-image
 文字-msg
 语音-audio
 视频-video
 红包-hongbao
 领红包记录-hongbao_record
 */
@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* data;
@property (nonatomic, copy) NSString* lr;
@property (nonatomic, copy) NSString* nickname;
@property (nonatomic, copy) NSString* head_img;

@property (nonatomic, copy) NSString* hb_info;
@property (nonatomic, copy) NSString* hb_end;//已领完
@property (nonatomic, copy) NSString* hb_receive;//已领取
@property (nonatomic, copy) NSString* is_own_send;//自己发送
@property (nonatomic, copy) NSString* hb_id;
@property (nonatomic, assign) BOOL is_Expire;//已过期

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) BOOL isRead;
@property (nonatomic, strong) UIImage *coverImage;
@property (nonatomic, assign) float length;
//@property (nonatomic, strong) NSData *uploadData;
@property (nonatomic, copy) NSString *fileName;

@property (nonatomic, copy) NSString* return_str;
// 1-正在发送 2-发送失败 其他-成功
@property (nonatomic, assign) int status;
@end

@interface FNChatGoodsModel : NSObject
@property (nonatomic, copy) NSString* shop_img;
@property (nonatomic, copy) NSString* goods_img;
@property (nonatomic, copy) NSString* goods_title;
@property (nonatomic, copy) NSString* goods_price;
@property (nonatomic, copy) NSString* pdd;
@property (nonatomic, copy) NSString* jd;
@property (nonatomic, copy) NSString* shop_id;
@property (nonatomic, copy) NSString* goods_cost_price;
@property (nonatomic, copy) NSString* goods_sales;
@property (nonatomic, copy) NSString* fcommission_str;
@property (nonatomic, copy) NSString* goodsbank_quan_img;
@property (nonatomic, copy) NSString* quan_str;
@property (nonatomic, copy) NSString* yhq_price;
@property (nonatomic, copy) NSString* quan_color;
@property (nonatomic, copy) NSString* yhq;

@property (nonatomic, copy) NSString* fnuo_id;
@property (nonatomic, copy) NSString* fnuo_url;
@property (nonatomic, copy) NSString* commission;
@end

@interface FNChatSettingModel : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* SkipUIIdentifier;

@end

NS_ASSUME_NONNULL_END
