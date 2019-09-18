//
//  FNShareCodeAlert.h
//  SuperMode
//
//  Created by jimmy on 2017/10/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickBlock)(NSInteger index);
@interface FNShareCodeAlert : UIView
@property (nonatomic, copy)clickBlock block;
+ (void)showAlertWithContent:(NSString *)content withClickeBlock:(clickBlock)block;
@end
