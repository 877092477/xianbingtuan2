//
//  UIViewController+DefaultProperyMethod.h
//  THB
//
//  Created by Jimmy on 2018/1/29.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (DefaultProperyMethod)
/** 是否在首页 **/
@property (nonatomic,assign) BOOL isNotHome;
@property (nonatomic, copy)NSString* isPop;
@property (nonatomic, strong)id sparams;
//@property (nonatomic, copy,readonly)NSDictionary* vc_key_value;
+ (UIViewController *)getVCByClassName:(NSString *)name orIdentifier:(NSString*)identifier andParams:(id)params;

+(UIViewController *)currentViewController;
@end
