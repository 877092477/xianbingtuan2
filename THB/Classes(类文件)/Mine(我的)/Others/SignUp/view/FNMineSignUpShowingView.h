//
//  FNMineSignUpShowingView.h
//  THB
//
//  Created by Jimmy on 2018/1/17.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MSS_CompeleteBlock)(id sender);
@interface FNMineSignUpShowingView : UIView
@property (nonatomic, copy)MSS_CompeleteBlock block;
+ (void)showSignUpViewWithBgImage:(UIImage *)bgImage content:(NSString*)content iconImage:(UIImage* )iconImage hightLightedValue:(NSString *)value block:(MSS_CompeleteBlock)block;
@end
