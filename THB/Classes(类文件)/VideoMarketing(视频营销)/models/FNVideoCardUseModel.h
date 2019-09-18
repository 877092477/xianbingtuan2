//
//  FNVideoCardUseModel.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNVideoCardUseRuleModel : NSObject
@property (nonatomic, copy) NSString *code_rule_title;
@property (nonatomic, copy) NSString *code_rule_content;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;


@end

@interface FNVideoCardUseModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *right_title;
@property (nonatomic, copy) NSString *input_str;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, strong) NSArray<FNVideoCardUseRuleModel*> *rule;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *lock_img;
@property (nonatomic, copy) NSString *qrcode_img;
@property (nonatomic, copy) NSString *btn_img;
@property (nonatomic, copy) NSString *btn_str;
@property (nonatomic, copy) NSString *btn_color;

@end

NS_ASSUME_NONNULL_END
