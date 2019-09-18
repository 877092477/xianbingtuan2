//
//  FNStoreThendNeModel.h
//  69橙子
//
//  Created by Jimmy on 2018/11/22.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

@interface FNStoreThendNeModel : NSObject
@property(nonatomic, copy) NSString     *id;
@property(nonatomic, copy) NSString     *uid;
@property(nonatomic, copy) NSString     *name;
@property(nonatomic, copy) NSString     *img;
@property(nonatomic, copy) NSString     *phone;
@property(nonatomic, copy) NSString     *one_price;
@property(nonatomic, copy) NSString     *commission;
@property(nonatomic, copy) NSString     *lat;
@property(nonatomic, copy) NSString     *lng;
@property(nonatomic, copy) NSString     *address;
@property(nonatomic, copy) NSString     *label_id;
@property(nonatomic, copy) NSString     *distance;
@property(nonatomic, copy) NSString     *str;
@property(nonatomic, copy) NSString     *str2; 
@property(nonatomic, strong) NSArray    *banner;
@property(nonatomic, strong) NSArray    *label;

@property(nonatomic, copy) NSString     *district_id;
@property(nonatomic, copy) NSString     *bussiness_hours;
@property(nonatomic, copy) NSString     *is_open;
@property(nonatomic, copy) NSString     *bili;
@property(nonatomic, copy) NSString     *distance1;
@property(nonatomic, copy) NSString     *distance2;
@property(nonatomic, copy) NSString     *end_commission;
@property(nonatomic, copy) NSString     *comment_counts;
@property(nonatomic, copy) NSString     *comment_counts_str;
@property(nonatomic, copy) NSString     *average_star;
@property(nonatomic, copy) NSString     *good_star;
@property(nonatomic, copy) NSString     *bad_star;
@property(nonatomic, copy) NSString     *district_str;
@property(nonatomic, copy) NSString     *open_time_str;
@property(nonatomic, copy) NSString     *visitor;
@property(nonatomic, copy) NSString     *open_time_color;
@property(nonatomic, copy) NSString     *open_time_icon;

@end

//NS_ASSUME_NONNULL_END


@interface FNStoreThendTypeNeModel : NSObject
@property(nonatomic, copy) NSString     *id;
@property(nonatomic, copy) NSString     *img;
@property(nonatomic, copy) NSString     *catename;

@end
