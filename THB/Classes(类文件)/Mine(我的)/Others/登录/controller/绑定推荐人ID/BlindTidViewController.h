//
//  BlindTidViewController.h
//  THB
//
//  Created by zhongxueyu on 16/5/24.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "SuperViewController.h"

@interface BlindTidViewController : SuperViewController
/** type 1是忘记密码，2是注册 */
@property(nonatomic,assign) NSNumber *type;
@property (nonatomic,assign) BOOL isConfirm;
@property (nonatomic,copy) NSString *token;
@property (nonatomic, copy) NSString* source_type;

@end
