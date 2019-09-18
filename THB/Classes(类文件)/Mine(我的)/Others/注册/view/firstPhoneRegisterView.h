//
//  firstPhoneRegisterView.h
//  THB
//
//  Created by zhongxueyu on 16/3/29.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BtnClickDelegate <NSObject>

-(void)OnClickBtn:(NSString *)url;

@end
@interface firstPhoneRegisterView : UIView

@property (nonatomic, weak) id<BtnClickDelegate> delegate;
@property (nonatomic,strong) UITextField *firstTF;
/** type 1是忘记密码，2是注册 */
@property(nonatomic,assign) NSNumber *type;

@property(nonatomic,assign) NSInteger is_forget; 

@property(nonatomic,strong) UIButton *confirmBtn;

@end
