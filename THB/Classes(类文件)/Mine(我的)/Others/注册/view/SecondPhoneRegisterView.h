//
//  SecondPhoneRegisterView.h
//  THB
//
//  Created by zhongxueyu on 16/3/29.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RegisterBtnClickDelegate <NSObject>
-(void)OnClickRegisterBtn:(NSInteger)sender;
@end
@interface SecondPhoneRegisterView : UIView
@property (nonatomic, weak) id<RegisterBtnClickDelegate> delegate;
/** type 1是手机，2是邮箱 */
@property(nonatomic,assign) NSNumber *type;

@property(nonatomic,assign) NSString *userName;
@end
