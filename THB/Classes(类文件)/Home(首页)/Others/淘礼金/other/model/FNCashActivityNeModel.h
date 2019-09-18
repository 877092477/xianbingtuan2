//
//  FNCashActivityNeModel.h
//  THB
//
//  Created by Jimmy on 2018/10/23.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNCashActivityNeModel : NSObject

@property (nonatomic , copy) NSString              * id;

@property (nonatomic , copy) NSString              * limit;

@property (nonatomic , copy) NSString              * sort;

@property (nonatomic , copy) NSString              * str;

@property (nonatomic , copy) NSString              * title;

@property (nonatomic , copy) NSString              * type;

@property (nonatomic , copy) NSArray               * goods;

@property (nonatomic , copy) NSString              * tlj_goods_img4;

@property (nonatomic , copy) NSString              * tlj_goodsfont_color;

@property (nonatomic , copy) NSString              * tlj_goods_img1;

@property (nonatomic , copy) NSString              * tlj_goods_img2;

@property (nonatomic , copy) NSString              * tlj_goods_img3;

@end


@interface FNCashActivityItemNeModel : NSObject

@property (nonatomic , copy) NSString              * fnuo_id;

@property (nonatomic , copy) NSString              * goods_cost_price;

@property (nonatomic , copy) NSString              * goods_img;

@property (nonatomic , copy) NSString              * goods_price;

@property (nonatomic , copy) NSString              * goods_sales;

@property (nonatomic , copy) NSString              * goods_title;

@property (nonatomic , copy) NSString              * is_tlj;

@property (nonatomic , copy) NSString              * one_tlj_val;

@property (nonatomic , copy) NSString              * price_str2;

@property (nonatomic , copy) NSString              * shop_id;

@property (nonatomic , copy) NSString              * shop_type;

@property (nonatomic , copy) NSString              * str;

@property (nonatomic , copy) NSString              * type;

@property (nonatomic , copy) NSString              * yhq;

@property (nonatomic , copy) NSString              * yhq_price;

@property (nonatomic , copy) NSString              * tlj_num;

@property (nonatomic , copy) NSString              * price_str;

@property (nonatomic , copy) NSString              * is_join;

@property (nonatomic , copy) NSString              * share_img;

@property (nonatomic , copy) NSString              * act_share_url;

@property (nonatomic , copy) NSString              * tlj_goods_qg_img1;

@property (nonatomic , copy) NSString              * tlj_goods_qg_img2;

@property (nonatomic , copy) NSString              * tlj_goods_qg_img3;


@property (nonatomic, copy) NSString *getGoodsType; 
@property (nonatomic, copy) NSString *jd;

@end

@interface FNCashActivitySetModel : NSObject

@property (nonatomic , copy) NSString              * act_url;

@property (nonatomic , copy) NSString              * tlj_top_img;

@property (nonatomic , copy) NSString              * tlj_bj_color;

@property (nonatomic , copy) NSString              * tlj_font_color;
 

@property (nonatomic , copy) NSString              * tlj_today_img;

@end
