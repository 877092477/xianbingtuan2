//
//  FirstEmailRegisterView.h
//  THB
//
//  Created by zhongxueyu on 16/3/29.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EmailBtnClickDelegate <NSObject>
-(void)OnClickEmailBtn:(NSString *)sender;
@end
@interface FirstEmailRegisterView : UIView

@property (nonatomic, weak) id<EmailBtnClickDelegate> delegate;

/** type 1是忘记密码，2是注册 */
@property(nonatomic,assign) NSNumber *type;
@end
