//
//  FNNewFreeOrderModel.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNNewFreeOrderModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *is_fl;
@property (nonatomic, copy) NSString *is_full;
@property (nonatomic, copy) NSString *is_bind;
@property (nonatomic, copy) NSString *fnuo_id;
@property (nonatomic, copy) NSString *fl_price;
@property (nonatomic, copy) NSString *act_over_time;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *goods_img;
@property (nonatomic, copy) NSString *goods_title;
@property (nonatomic, copy) NSString *assistance_price;
@property (nonatomic, copy) NSString *leave_price;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *font_color;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *share_url;
@property (nonatomic, copy) NSString *list_str;
@property (nonatomic, copy) NSString *order_str;
@property (nonatomic, copy) NSString *tip_str;
@end

NS_ASSUME_NONNULL_END
