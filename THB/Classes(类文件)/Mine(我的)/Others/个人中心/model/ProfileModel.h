//
//  ProfileModel.h
//  THB
//
//  Created by zhongxueyu on 16/4/13.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有 2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import <Foundation/Foundation.h>

@interface ProfileModel : NSObject


@property (nonatomic, copy) NSString *qq_au;

@property (nonatomic, copy) NSString *money;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *loginname;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *head_img;

@property (nonatomic, copy) NSString *checkTime;

@property (nonatomic, copy) NSString *like_count;

@property (nonatomic, copy) NSString *weixin_au;

@property (nonatomic, copy) NSString *realname;

@property (nonatomic, assign) NSString * hflower;

@property (nonatomic, assign) NSString * xflower;

@property (nonatomic, assign) NSString *flower;

@property (nonatomic, copy) NSString *sordernum;

@property (nonatomic, assign) NSString * lovenum;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *checkNum;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *growth;

@property (nonatomic, copy) NSString *fans;

@property (nonatomic, assign) NSString *people;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *taobao_au;

@property (nonatomic, copy) NSString *sina_au;

@property (nonatomic, copy) NSString *zfb_au;

@property (nonatomic, copy) NSString *vip;

@property (nonatomic, copy) NSString *qq;

@property (nonatomic, copy) NSString *integral;

@property (nonatomic, copy) NSString *returnmoney;

@property (nonatomic,copy) NSString *commission;

@property (nonatomic, copy) NSString *tid;

@property (nonatomic, copy) NSString *three_nickname;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *jifenbao;

@property (nonatomic, copy) NSString *chulinum;

@property (nonatomic, copy) NSString *gywm;

@property (nonatomic, copy) NSString *kfzx;
@property (nonatomic, copy) NSString *zztx;

@property (nonatomic, copy) NSString *lhbtx;

@property (nonatomic, copy) NSString *hbtx;
@property (nonatomic, copy) NSString *extend_id;
@property (nonatomic, copy) NSString *money2;

@property (nonatomic, copy) NSString *is_agent;
/**
 *  推广pid
 */
@property (nonatomic, copy)NSString* tg_pid;
/**
 *  	是否代理  	0否 1是
 */
@property (nonatomic, copy)NSString* is_sqdl;
/**
 * 代理审核状态  0=>审核中 1=>审核通过 2=>审核失败 3=>未申请
 */
@property (nonatomic, copy)NSString* dl_checks;
/**
 *  is_hhr
 */
@property (nonatomic, copy)NSString* is_hhr;
/**
 *  判断合伙人审核状态，0的时候，点击的时候提示，您的申请正在审核中；1.跳转到合伙人中心；2.您的申请审核失败，请重新提交，然后跳转到申请界面；3.跳转到申请界面
 */
@property (nonatomic, copy)NSString* hhr_checks;

/**
 是否已签到
 */
@property (nonatomic, copy)NSString* is_qiandao;
/**
 vip等级
 */
@property (nonatomic, copy)NSString* vip_name;

/**
 会员中心头部背景图片
 */
@property (nonatomic, copy)NSString* user_top_img;
/**
 是否关闭签到
 */
@property (nonatomic, copy)NSString* mem_qiaodao_onoff;

@property (nonatomic, copy)NSString* mem_font_color;
@property (nonatomic, copy)NSString* vip_btn_color;
@property (nonatomic, copy)NSString* vip_btn_fontcolor;
@property (nonatomic, copy)NSString* vip_btn_str;
@property (nonatomic, copy)NSString* vip_logo;

+ (ProfileModel *)profileInstance;
+ (void)saveProfile:(ProfileModel *)model;

@end
