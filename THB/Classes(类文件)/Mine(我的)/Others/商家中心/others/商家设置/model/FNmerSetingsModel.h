//
//  FNmerSetingsModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNmerSetingsModel : NSObject
@property (nonatomic, copy)NSString* id;
@property (nonatomic, copy)NSString* img;
@property (nonatomic, copy)NSString* name;
@property (nonatomic, copy)NSString* address;
@property (nonatomic, copy)NSString* phone;
@property (nonatomic, copy)NSString* commission_str;
@property (nonatomic, copy)NSDictionary* postage_data;

@property (nonatomic, copy)NSString* btn;
@property (nonatomic, copy)NSString* btn_color;
@property (nonatomic, copy)NSString* btn_bj;

@property (nonatomic, copy)NSString* commission;//    float    赏金比例
@property (nonatomic, copy)NSString* box_price;//    float    餐盒费
@property (nonatomic, copy)NSString* ps_price;//    float    配送费
@property (nonatomic, copy)NSString* start_postage;//    float    起送费
@property (nonatomic, copy)NSString* start_time;//    string    配送开始时间
@property (nonatomic, copy)NSString* end_time;//    string    配送结束时间
@property (nonatomic, copy)NSString* max_km;//    string    最长配送距离
@property (nonatomic, copy)NSString* postage_km;//    int    超过xxkm
@property (nonatomic, copy)NSString* postage_eachkm;//    int    每xxkm
@property (nonatomic, copy)NSString* postage_add;//    int    增加xx配送费
@property (nonatomic, copy)NSDictionary* bussiness_hours;
//    array    营业时间的参数【bussiness_day 日期，start_time开始时间，end_time 结束时间】
@property (nonatomic, copy)NSString* bussiness_hours_str;//    stinrg    营业时间字符串【显示用】
@property (nonatomic, copy)NSString* ps_open;//    int    是否开启配送费    0否 1 是
@property (nonatomic, copy)NSString* is_open;//    int

@property (nonatomic, copy)NSString* lat;//
@property (nonatomic, copy)NSString* lng;//

@property (nonatomic, copy)NSDictionary* ps_time;


 
@end

@interface FNmerSetingsPostageModel : NSObject
@property (nonatomic, copy)NSString* postage;
@property (nonatomic, copy)NSString* postage_km;
@property (nonatomic, copy)NSString* postage_eachkm;
@property (nonatomic, copy)NSString* postage_add;

@property (nonatomic, copy)NSString* max_km;
@property (nonatomic, copy)NSString* end_time;
@property (nonatomic, copy)NSString* start_time;
@property (nonatomic, copy)NSString* start_postage;




@end 
@interface FNmerSetingsItemModel : NSObject
@property (nonatomic, copy)NSString* leftStr;
@property (nonatomic, copy)NSString* rightStr;
@property (nonatomic, copy)NSString* imageUrl;
@property (nonatomic, copy)NSString* rightColor;
@property (nonatomic, copy)NSString* bottomhint;
@property (nonatomic, assign)NSInteger  rightState;
@end


@interface FNmerSetingsPsTimeItemModel : NSObject
@property (nonatomic, copy)NSString* compute_duration;
@property (nonatomic, copy)NSString* ps_duration;
@property (nonatomic, copy)NSString* one_km_inc;
@property (nonatomic, copy)NSArray* special_duration;

@end
NS_ASSUME_NONNULL_END
