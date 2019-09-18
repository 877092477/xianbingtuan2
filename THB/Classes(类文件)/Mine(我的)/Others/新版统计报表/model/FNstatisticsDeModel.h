//
//  FNstatisticsDeModel.h
//  THB
//
//  Created by Jimmy on 2018/12/27.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNstatisticsDeModel : NSObject

@property (nonatomic, copy)NSString* top_title;

@property (nonatomic, copy)NSDictionary* tx_list;
@property (nonatomic, copy)NSDictionary* sy_list;
@property (nonatomic, copy)NSArray* tab_list;
@end

@interface FNstatisticsTXModel : NSObject

@property (nonatomic, copy)NSString* money;
@property (nonatomic, copy)NSString* str;
@property (nonatomic, copy)NSString* bj_img;
@property (nonatomic, copy)NSString* str1;
@property (nonatomic, copy)NSString* color;
@property (nonatomic, copy)NSString* is_tx;
@property (nonatomic, copy)NSString* str3;
@end


@interface FNstatisticsSYModel : NSObject

@property (nonatomic, copy)NSString* str;
@property (nonatomic, copy)NSArray* commission_data;
@end


@interface FNstatisticsCommissionModel : NSObject

@property (nonatomic, copy)NSString* str;
@property (nonatomic, copy)NSString* str_color;
@property (nonatomic, copy)NSString* val;
@property (nonatomic, copy)NSString* val_color;
@property (nonatomic, copy)NSString* str2;
@property (nonatomic, copy)NSString* str2_color;
@property (nonatomic, copy)NSString* str3;
@property (nonatomic, assign)NSInteger  place;
@end


@interface FNstatisticsTABModel : NSObject

@property (nonatomic, copy)NSString* name;
@property (nonatomic, copy)NSString* type;
@property (nonatomic, copy)NSString* color;
@property (nonatomic, copy)NSString* check_color;

@end


//时间和订单类型数据

@interface FNstatisticsAnCateModel : NSObject

@property (nonatomic, copy)NSArray* day_list;
@property (nonatomic, copy)NSArray* ordertype_list;

@end

@interface FNstatisticsTimeModel : NSObject
@property (nonatomic, copy)NSString* name;
@property (nonatomic, copy)NSString* type;
@property (nonatomic, copy)NSString* color;
@property (nonatomic, copy)NSString* check_color;

@property (nonatomic, copy)NSString* bj_color;
@property (nonatomic, copy)NSString* checkbj_color;
@end

//财务报表底部数据
@interface FNstatisticsAnReportModel : NSObject

@property (nonatomic, copy)NSArray* sy_data;
@property (nonatomic, copy)NSArray* pic_data;
@property (nonatomic, copy)NSArray* time;

@end

@interface FNstatisticsReportItemModel : NSObject
@property (nonatomic, copy)NSString* str_color;
@property (nonatomic, copy)NSString* str;
@property (nonatomic, copy)NSString* color;
@property (nonatomic, copy)NSString* is_check;
@property (nonatomic, copy)NSString* val;
@property (nonatomic, copy)NSString* val_color;
@property (nonatomic, assign)NSInteger  place;


@end

@interface FNstatisticsItemTimeModel : NSObject
@property (nonatomic, copy)NSString* time;
@property (nonatomic, copy)NSString* val;
@property (nonatomic, copy)NSString* val1;
@property (nonatomic, copy)NSString* val_color;
@property (nonatomic, copy)NSString* val1_color;
@property (nonatomic, copy)NSString* name;
@property (nonatomic, copy)NSString* name1;
@end
NS_ASSUME_NONNULL_END
