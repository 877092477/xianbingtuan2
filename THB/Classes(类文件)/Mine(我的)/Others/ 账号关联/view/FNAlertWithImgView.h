//
//  FNAlertWithImgView.h
//  THB
//
//  Created by Jimmy on 2018/2/28.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "JMView.h"
typedef void(^AIClickBlock)(NSInteger index);
@interface FNAlertWithImgView : JMView
@property (nonatomic, strong)UIButton* firstButton;
@property (nonatomic, strong)UIButton* secondButton;
@property (nonatomic, strong)UILabel* contentLabel;

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* content;
@property (nonatomic, copy)NSString * firstTitle;
@property (nonatomic, copy)NSString* secondTitle;
/**
 img
 */
@property (nonatomic, strong)id img;
@property (nonatomic, copy)AIClickBlock clickeblock;
+ (instancetype)alertWithTitle:(NSString *)title content:(NSString *)content firstTitle:(NSString *)firstTitle andSecondTitle:(NSString *)secondTitle topImg:(id)img  clickBlock:(AIClickBlock)clickblock;
- (void)showAlert;
@end
