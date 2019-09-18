//
//  FNLeftclassifyModel.h
//  THB
//
//  Created by Jimmy on 2018/9/5.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNLeftclassifyModel : NSObject
@property(nonatomic, copy) NSString     *start_price;
@property(nonatomic, copy) NSString     *yhq_onoff;
@property(nonatomic, copy) NSString     *title;
@property(nonatomic, copy) NSString     *keyword;
@property(nonatomic, copy) NSString     *goodslist_str;
@property(nonatomic, copy) NSString     *banner_url;
@property(nonatomic, copy) NSString     *banner_img;
@property(nonatomic, strong) NSString     *catename;
@property(nonatomic, copy) NSString     *SkipUIIdentifier;
@property(nonatomic, copy) NSString     *name;
@property(nonatomic, copy) NSString     *goods_pd_onoff;
@property(nonatomic, copy) NSString     *dtk_goods_onoff;
@property(nonatomic, copy) NSString     *id;
@property(nonatomic, copy) NSString     *fnuo_id;
@property(nonatomic, copy) NSString     *end_price;
@property(nonatomic, copy) NSString     *commission;
@property(nonatomic, copy) NSString     *shop_type;
@property(nonatomic, copy) NSString     *goods_sales;
@property(nonatomic, copy) NSString     *view_type;
@property(nonatomic, copy) NSString     *goodslist_img;
@property(nonatomic, copy) NSArray      *goods_detail;
@property(nonatomic, copy) NSString     *is_need_login;
@property(nonatomic, copy) NSString     *show_type_str;
@property(nonatomic, copy) NSString     *goods_type_name;
@property(nonatomic, assign) NSInteger       select_type;

@property(nonatomic, copy) NSArray       *twocate;

@property(nonatomic, copy) NSString     *UIIdentifier;
@property(nonatomic, copy) NSString     *url;
@end

@interface FNRightclassifyModel : NSObject
@property(nonatomic, copy) NSString     *category_name;
@property(nonatomic, copy) NSString     *img;
@property(nonatomic, copy) NSString     *catename;
@property(nonatomic, copy) NSString     *keyword;

@property(nonatomic, copy) NSString     *id;

@end
