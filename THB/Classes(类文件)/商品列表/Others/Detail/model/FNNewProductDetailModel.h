//
//  FNNewProductDetailModel.h
//  THB
//
//  Created by Jimmy on 2017/12/16.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNBaseProductModel.h"
@interface JM_NPD_fs:NSObject

@property (nonatomic, copy)NSString* score;
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* img;

@end

@interface JM_NPD_dpArr:NSObject

@property (nonatomic, copy)NSString* name;
@property (nonatomic, copy)NSString* logo;
@property (nonatomic, copy)NSString* shop_type_img;
@property (nonatomic, copy)NSString* seller_id;
@property (nonatomic, copy)NSString* seller_nick;
@property (nonatomic, copy)NSString* shop_img;
@property (nonatomic, copy)NSString* shop_title;
@property (nonatomic, copy)NSString* shop_type;
@property (nonatomic, copy)NSString* shop_url;
@property (nonatomic, strong)NSArray<JM_NPD_fs *>* fs;

@property (nonatomic, copy)NSString* btn_str;
@property (nonatomic, copy)NSString* btn_fontcolor;
@property (nonatomic, copy)NSString* btn_img;

@end

@interface FNNewProductCommentDataModel : NSObject

@property (nonatomic, copy)NSString* content;
@property (nonatomic, copy)NSString* userName;
@property (nonatomic, copy)NSString* headPic;
@property (nonatomic, copy)NSString* dateTime;
@property (nonatomic, strong)NSArray<NSString*>* images;

@end


@interface FNNewProductCommentModel : NSObject

@property (nonatomic, copy)NSString* totalCount;
@property (nonatomic, strong)FNNewProductCommentDataModel* rateList;
@property (nonatomic, copy)NSString* url;

@end

@interface FNNewProductDetailCouponeModel : NSObject

@property (nonatomic, copy)NSString* coupon_exchange_bjimg;
@property (nonatomic, copy)NSString* coupon_exchange_btn_img;
@property (nonatomic, copy)NSString* coupon_exchange_ico;
@property (nonatomic, copy)NSString* coupon_exchange_moneyico;
@property (nonatomic, copy)NSString* coupon_money;
@property (nonatomic, copy)NSString* coupon_money_color;
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* title_color;
@property (nonatomic, copy)NSString* title1;
@property (nonatomic, copy)NSString* title1_color;
@property (nonatomic, copy)NSString* info;
@property (nonatomic, copy)NSString* info_color;
@property (nonatomic, copy)NSString* exchange_price;
@property (nonatomic, copy)NSString* exchange_price_color;
@property (nonatomic, copy)NSString* left_btn_str;
@property (nonatomic, copy)NSString* left_btn_color;
@property (nonatomic, copy)NSString* right_btn_str;
@property (nonatomic, copy)NSString* right_btn_color;
@property (nonatomic, copy)NSString* SkipUIIdentifier;

@end

@interface FNNewProductDetailModel : FNBaseProductModel

@property (nonatomic, copy)NSString* cjtime;
@property (nonatomic, copy)NSString* yhq_end_time;
@property (nonatomic, copy)NSString* yhq_use_time;

@property (nonatomic, copy)NSString* pt_url;
@property (nonatomic, copy)NSString* yhq_type;
@property (nonatomic, copy)NSString* tdj_data;
@property (nonatomic, copy)NSString* is_store;
@property (nonatomic, copy)NSString* is_tlj;

@property (nonatomic, strong)NSArray* detailArr;
@property (nonatomic, strong)NSMutableArray* images;
@property (nonatomic, assign)CGFloat imgH;
@property (nonatomic, strong)NSArray* imgArr;
@property (nonatomic, strong)JM_NPD_dpArr* dpArr;
@property (nonatomic, strong)NSArray<FNBaseProductModel *>* xggoodsArr;


@property (nonatomic, copy) NSString* goods_description;

@property (nonatomic, copy) NSString* doc_str;
@property (nonatomic, copy) NSString* doc_color;
@property (nonatomic, copy) NSString* doc_copy_str;
@property (nonatomic, copy) NSString* doc_copy_color;
@property (nonatomic, copy) NSString* doc_copy_btncolor;

@property (nonatomic, strong) FNNewProductCommentModel *comment;
@property (nonatomic, copy) NSString* html_detail_img_url;

@property (nonatomic, assign) int is_need_exchange;
@property (nonatomic, strong) FNNewProductDetailCouponeModel *coupon_exchange;

@end


