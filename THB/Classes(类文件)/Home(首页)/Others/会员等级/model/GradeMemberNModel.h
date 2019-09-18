//
//  GradeMemberNModel.h
//  THB
//
//  Created by Jimmy on 2018/9/7.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
//会员等级
@interface GradeMemberNModel : NSObject

@property (nonatomic , copy) NSString              * memlv_bj_color;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * str1;
@property (nonatomic , copy) NSString              * str;
@property (nonatomic , copy) NSString              * tgid;
@property (nonatomic , copy) NSString              * unit;
@property (nonatomic , copy) NSString               * url;
@property (nonatomic , copy) NSString              * bj_img;
@property (nonatomic , copy) NSArray               * guanggao;
@property (nonatomic , copy) NSArray               * hb_count;
@property (nonatomic , copy) NSArray               * sy;

@end


@interface GradeHbNModel : NSObject

@property (nonatomic , copy) NSString               * name;
@property (nonatomic , copy) NSString              * unit;
@property (nonatomic , copy) NSString              * val;

@end

@interface GradeAdvertisingNModel : NSObject

@property (nonatomic , copy) NSArray               * start_price;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , copy) NSString              * keyword;
@property (nonatomic , copy) NSString              * goodslist_str;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , copy) NSArray               * SkipUIIdentifier;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * fnuo_id;
@property (nonatomic , copy) NSString              * end_price;
@property (nonatomic , copy) NSString              * goods_sales;
@property (nonatomic , copy) NSString              * shop_type;
@property (nonatomic , copy) NSArray               * ktype;
@property (nonatomic , copy) NSString              * view_type;
@property (nonatomic , copy) NSString              * goodslist_img;
@property (nonatomic , copy) NSArray               * goods_detail;
@property (nonatomic , copy) NSString              * UIIdentifier;
@property (nonatomic , copy) NSString              * is_need_login;
@property (nonatomic , copy) NSString              * ix_img;

@end

//等级攻略
@interface GradeStrategyModel : NSObject

@property (nonatomic , copy) NSArray               * tiaojian;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , copy) NSString              * lv;
@property (nonatomic , copy) NSString              * num;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * is_thislv;

@end

//等级攻略item
@interface StrategyItemModel : NSObject

@property (nonatomic , copy) NSString              * sum;
@property (nonatomic , copy) NSString              * val;
@property (nonatomic , copy) NSString              * unit;
@property (nonatomic , copy) NSString              * str;


@end

