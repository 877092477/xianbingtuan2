//
//  ShopRebatesViewController.h
//  THB
//
//  Created by zhongxueyu on 16/3/24.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZDisplayViewController.h"
@interface ShopRebatesViewController : YZDisplayViewController
/** 是否从首页进入 */
@property (nonatomic, strong) NSNumber *type;

- (instancetype)initWithShopType:(NSString*)shopType withStr: (NSString*)show_type_str;
@end
