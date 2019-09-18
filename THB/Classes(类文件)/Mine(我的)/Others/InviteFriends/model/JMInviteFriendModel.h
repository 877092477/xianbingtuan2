//
//  JMInviteFriendModel.h
//  THB
//
//  Created by jimmy on 2017/4/17.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JMInviteFriendRankingModel;
@interface JMInviteFriendModel : NSObject
/**
 *  文字（按钮下面的）,被邀请好友可得1元新人红包
 */
@property (nonatomic, copy)NSString* str4;
@property (nonatomic, copy)NSString* xr_hb;
@property (nonatomic, copy)NSString* tgid;
/**
 *  	邀请的url
 */
@property (nonatomic, copy)NSString* tgurl;

/**
 *  	分享显示的图片
 */
@property (nonatomic, copy)NSString *shareImg;
/**
 *  红包的url
 */
@property (nonatomic, copy)NSString* hburl;
/**
 *  邀请规则图片
 */
@property (nonatomic, copy)NSString* yqImg;
/**
 *  页面上方的背景
 */
@property (nonatomic, copy)NSString* invite_bj;
@property (nonatomic, copy)NSString* next_invite_bj;

@property (nonatomic, copy)NSString* mon_str;

/**
 分享内容
 */
@property (nonatomic, copy)NSString* shareInfo;
@property (nonatomic, copy)NSString* zq_url;
@property (nonatomic, copy)NSString* ml_shareInfo_two;
@property (nonatomic, copy)NSString* invite_model_onoff;//0=>图文模式 2=>纯图模式
@property (nonatomic, copy)NSString* hc_img;//纯图模式时用

@property (nonatomic, copy)NSString* intvite_get_btn;
@property (nonatomic, copy)NSString* intvite_get_btn1;

/**
 *  我的奖励的图片
 */
@property (nonatomic, copy)NSString* jl_bj;
/**
 *  邀请规则
 */
@property (nonatomic, copy)NSString* yqrule	;
/**
 *  	邀请战绩中的邀请好友数量
 */
@property (nonatomic, copy)NSString* yqcount;
/**
 *  	邀请战绩中的返利
 */
@property (nonatomic, copy)NSString* flmoney;
/**
 *  邀请战绩中的红包次数
 */
@property (nonatomic, copy)NSString* hbcount;
@property (nonatomic, copy)NSString* str5;
/**
 *  排行榜数组
 */
@property (nonatomic, strong)NSArray<JMInviteFriendRankingModel *>* phb;


@end

@interface JMInviteFriendRankingModel : NSObject
/**
 *  logo
 */
@property (nonatomic, copy)NSString* logo;
/**
 *  头像
 */
@property (nonatomic, copy)NSString* head_img;
/**
 *  	昵称
 */
@property (nonatomic, copy)NSString* nickname;
/**
 *  	数字
 */
@property (nonatomic, copy)NSString* num;
/**
 *  返利金额
 */
@property (nonatomic, copy)NSString* commission_sum;
@property (nonatomic, copy)NSString* yqfl_mxwz;

@end
