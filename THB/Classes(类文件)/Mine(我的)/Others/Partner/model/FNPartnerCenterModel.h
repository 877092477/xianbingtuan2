//
//  FNPartnerCenterModel.h
//  SuperMode
//
//  Created by jimmy on 2017/10/16.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNPartnerCenterModel : NSObject
/**
 *  头像
 */
@property (nonatomic, copy)NSString* head_img;
/**
 *  会员等级
 */
@property (nonatomic, copy)NSString* Vname;
/**
 *  昵称
 */
@property (nonatomic, copy)NSString* nickname;
/**
 *  家族成员
 */
@property (nonatomic, copy)NSString* count;
/**
 *  团队人数
 */
@property (nonatomic, copy)NSString* allcount;
/**
 *  学习教程url
 */
@property (nonatomic, copy)NSString* xxjc;
/**
 *  常见问题url
 */
@property (nonatomic, copy)NSString* question;

@end
