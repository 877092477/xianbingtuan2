//
//  FNgradeUeModel.h
//  THB
//
//  Created by 李显 on 2019/1/18.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNgradeUeModel : NSObject
@property (nonatomic, copy)NSString *login_time;
@property (nonatomic, copy)NSString *vip_logo;
@property (nonatomic, copy)NSString *Vname;
@property (nonatomic, copy)NSString *num;
@property (nonatomic, copy)NSString *phb_img;
@property (nonatomic, copy)NSString *head_img;
@property (nonatomic, copy)NSString *commission;
@property (nonatomic, copy)NSString *commission_str;
@property (nonatomic, copy)NSString *commission_color;
@property (nonatomic, copy)NSString *commission_unit;
@property (nonatomic, copy)NSString *lower_count;
@property (nonatomic, copy)NSString *lower_count_str;
@property (nonatomic, copy)NSString *lower_count_color;
@property (nonatomic, copy)NSString *lower_count_unit;
@property (nonatomic, copy)NSString *nickname;

@property (nonatomic, copy)NSString *id;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *uid;
@property (nonatomic, copy)NSString *time;
@property (nonatomic, copy)NSString *bs;
@end

@interface FNgradeHeadModel : NSObject 
@property (nonatomic, copy)NSString *update_time;
@property (nonatomic, copy)NSString *search_str;
@property (nonatomic, copy)NSString *bg_img;
@property (nonatomic, copy)NSString *sort_img;
@property (nonatomic, copy)NSString *sort_ascimg;
@property (nonatomic, copy)NSString *sort_descimg;
@property (nonatomic, copy)NSArray *list;
@end

@interface FNgradeSortItemModel : NSObject
@property (nonatomic, copy)NSString *str;
@property (nonatomic, copy)NSString *str_color;
@property (nonatomic, copy)NSString *is_up;
@property (nonatomic, copy)NSString *sort_asc;
@property (nonatomic, copy)NSString *sort_desc;
@end

NS_ASSUME_NONNULL_END
