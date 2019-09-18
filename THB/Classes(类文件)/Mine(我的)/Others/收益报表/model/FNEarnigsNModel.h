//
//  FNEarnigsNModel.h
//  THB
//
//  Created by 李显 on 2018/9/11.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNEarnigsNModel : NSObject

@property(nonatomic, copy) NSString     *back_color;
@property(nonatomic, copy) NSString     *back_img;
@property(nonatomic, copy) NSString     *lj_money;
@property(nonatomic, copy) NSString     *money;
@property(nonatomic, copy) NSString     *str;
@property(nonatomic, copy) NSString     *str1;
@property(nonatomic, copy) NSString     *str2;
@property(nonatomic, copy) NSString     *str3;
@property(nonatomic, copy) NSString     *str4;
@property(nonatomic, copy) NSString     *topColor;
@property(nonatomic, copy) NSString     *topTitle;
@property(nonatomic, copy) NSString     *topUrl;
@property(nonatomic, copy) NSString     *type;
@property(nonatomic, copy) NSString     *is_show;
@property(nonatomic, copy) NSString     *img_data;
@property(nonatomic, copy) NSString     *like_type;

@property(nonatomic, copy) NSArray     *lastList;
@property(nonatomic, copy) NSArray     *todayList;
@property(nonatomic, copy) NSArray     *yesList;
@end


@interface FNEarnigsItemNModel : NSObject

@property(nonatomic, copy) NSString     *is_show_point;
@property(nonatomic, copy) NSString     *is_show_rmb;
@property(nonatomic, copy) NSString     *point;
@property(nonatomic, copy) NSString     *str;
@property(nonatomic, copy) NSString     *str1;
@property(nonatomic, copy) NSString     *val;

@end
