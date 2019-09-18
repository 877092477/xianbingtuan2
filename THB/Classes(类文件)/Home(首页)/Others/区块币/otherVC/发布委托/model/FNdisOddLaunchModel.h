//
//  FNdisOddLaunchModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNdisOddLaunchModel : NSObject
@property (nonatomic , copy) NSString              *mode_tips;
@property (nonatomic , copy) NSString              *qkb_worth_tips;
@property (nonatomic , copy) NSString              *my_qkb_tips;
@property (nonatomic , copy) NSString              *djfs_tips;
@property (nonatomic , copy) NSString              *djfs;
@property (nonatomic , copy) NSString              *yjjg_tips;
@property (nonatomic , copy) NSString              *yjjg;
@property (nonatomic , copy) NSString              *number_tips;
@property (nonatomic , copy) NSString              *user_integral;
@property (nonatomic , copy) NSString              *user_money;
@property (nonatomic , copy) NSString              *qkb_count;
@property (nonatomic , copy) NSString              *btn_font;
@property (nonatomic , copy) NSString              *qkb_jyqr_btn;
@property (nonatomic , copy) NSString              *qkb_jyqr_check_btn;
@property (nonatomic , copy) NSString              *qkb_qr_fcolor;
@property (nonatomic , copy) NSString              *qkb_qr_check_fcolor;
@property (nonatomic , copy) NSString              *page_color;
@property (nonatomic , copy) NSString              *number;
@property (nonatomic , copy) NSArray               *mode;
@property (nonatomic , copy) NSString              *sell_min;
@property (nonatomic , copy) NSString              *sell_max;
@property (nonatomic , copy) NSString              *sell_min_price;
@property (nonatomic , copy) NSString              *sell_max_price;
@property (nonatomic , copy) NSString              *deduct_qkb;
@property (nonatomic , copy) NSString              *sxf_tips;
@property (nonatomic , copy) NSString              *qkb_sxf;
@end

@interface FNdisOddLaunchMoItemModel : NSObject
@property (nonatomic , copy) NSString              *title;
@property (nonatomic , copy) NSString              *type;
@property (nonatomic , copy) NSString              *sxf_tips;
@property (nonatomic , copy) NSString              *sxf;
@property (nonatomic , copy) NSString              *price_tips;
@property (nonatomic , copy) NSString              *bili;
@property (nonatomic , assign) NSInteger              stateInt;
@property (nonatomic , assign) NSInteger              stateID;
@end

@interface FNdisOddLaunchTypeModel : NSObject
@property (nonatomic , copy) NSString              *color;
@property (nonatomic , copy) NSString              *title;
@property (nonatomic , copy) NSArray               *list;
@end
@interface FNdisOddLaunchTypeItemModel : NSObject
@property (nonatomic , copy) NSString              *title;
@property (nonatomic , copy) NSString              *type;
@end

NS_ASSUME_NONNULL_END
