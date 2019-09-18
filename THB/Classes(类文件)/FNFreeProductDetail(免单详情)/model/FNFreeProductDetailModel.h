//
//  FNFreeProductDetailModel.h
//  THB
//
//  Created by Weller on 2018/12/19.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNFreeProductDetailRuleModel : NSObject
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* content;
@end

@interface FNFreeProductDetailModel : FNBaseProductModel
@property (nonatomic, copy) NSString* fl_price;
@property (nonatomic, copy) NSString* pg_url;
@property (nonatomic, copy) NSString* tdj_data;
@property (nonatomic, copy) NSString* fl_bj_img;
@property (nonatomic, copy) NSString* is_rob;
@property (nonatomic, copy) NSString* pt_str;
@property (nonatomic, copy) NSString* invite_str;
@property (nonatomic, copy) NSString* act_str;
@property (nonatomic, copy) NSArray<FNFreeProductDetailRuleModel*>* act_rule;
@property (nonatomic, copy) NSString* tip_str;
@property (nonatomic, copy) NSString* share_title;
@property (nonatomic, copy) NSString* share_content;
@property (nonatomic, copy) NSString* btn_str;
@property (nonatomic, copy) NSString* btn_str1;
@property (nonatomic, copy) NSString* btn_left_str;
@property (nonatomic, copy) NSString* btn_right_str;
@property (nonatomic, copy) NSArray<NSString*>* imgArr;
@property (nonatomic, copy) NSString* is_tlj;
@property (nonatomic, copy) NSString* stock;


@property (nonatomic, copy) NSString* tb_pid;
@property (nonatomic, copy) NSString* APP_adzoneId;
@property (nonatomic, copy) NSString* APP_alliance_appkey;
@property (nonatomic, copy) NSString* is_dq_yhqurl;

@end

NS_ASSUME_NONNULL_END
