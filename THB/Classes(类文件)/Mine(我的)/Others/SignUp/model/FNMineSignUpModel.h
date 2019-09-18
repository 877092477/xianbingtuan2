//
//  FNMineSignUpModel.h
//  THB
//
//  Created by Jimmy on 2018/1/17.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMNormalDataModel.h"
@interface FNMineSignUpModel : NSObject
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* str;
@property (nonatomic, copy)NSString* str1;
@property (nonatomic, copy)NSString* money;
@property (nonatomic, copy)NSString* is_qiandao;
@property (nonatomic, copy)NSString* tianshu;
@property (nonatomic, copy)NSString* img;
@property (nonatomic, copy)NSString* qiandao_yuan_img;
@property (nonatomic, copy)NSString* qiandao_guang_img;
@property (nonatomic, copy)NSString* mx_title;
@property (nonatomic, strong)NSArray<JMNormalDataModel *>* week;

@end
