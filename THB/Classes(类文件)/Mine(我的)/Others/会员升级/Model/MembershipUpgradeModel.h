//
//  MembershipUpgradeModel.h
//  嗨如意
//
//  Created by Fnuo-iOS on 2018/4/20.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MembershipUpgradeZIModel.h"

@class MembershipUpgradeZIModel;

@interface MembershipUpgradeModel : NSObject

@property (nonatomic, copy)NSString *bjImg;

@property (nonatomic, copy)NSString *btnImg1;

@property (nonatomic, copy)NSString *btnImg2;

@property (nonatomic, copy)NSString *conImg;

@property (nonatomic, copy)NSString *head_img;

@property (nonatomic, copy)NSString *is_hhr;

@property (nonatomic, copy)NSString *rule;

@property (nonatomic, copy)NSString *ruleImg;

@property (nonatomic, copy)NSString *ruleStr;

@property (nonatomic, copy)NSString *tqImg;

@property (nonatomic, strong)NSArray<MembershipUpgradeZIModel *> *font;

@end
