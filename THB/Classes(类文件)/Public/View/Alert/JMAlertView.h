//
//  JMAlertView.h
//  RedPacket
//
//  Created by jimmy on 16/12/23.
//  Copyright © 2016年 jimmy. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import <UIKit/UIKit.h>
typedef enum: NSUInteger{
    AlertTypeAlert,
    AlertTypeList,
    AlertTypeActionSheet,
}AlertType;
typedef void(^ClickBlock)(NSInteger index);
@interface JMAlertView : UIView
@property (nonatomic, strong)UIButton* firstButton;
@property (nonatomic, strong)UIButton* secondButton;
@property (nonatomic, strong)UILabel* contentLabel;

@property (nonatomic, assign)AlertType type;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* content;
@property (nonatomic, copy)NSString * firstTitle;
@property (nonatomic, copy)NSString* secondTitle;

@property (nonatomic, copy)ClickBlock clickeblock;
+ (instancetype)alertWithTitle:(NSString *)title content:(NSString *)content firstTitle:(NSString *)firstTitle andSecondTitle:(NSString *)secondTitle alertType:(AlertType)type clickBlock:(void (^)(NSInteger index))clickblock;
- (void)showAlert;
@end
