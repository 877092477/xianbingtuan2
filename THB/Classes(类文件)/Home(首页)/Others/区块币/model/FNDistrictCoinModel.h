//
//  FNDistrictCoinModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNDistrictCoinModel : NSObject

@property (nonatomic , copy) NSString              *qkb_name;//": "区块币大厅",
@property (nonatomic , copy) NSString              *qkb_detail_btn;//": "规则",
@property (nonatomic , copy) NSString              *qkb_title_color;//": "333333",
@property (nonatomic , copy) NSString              *qkb_worth;//": "我的区块币价值（元）",
@property (nonatomic , copy) NSString              *qkb_worth_detail;//": "区块币价值(分)  =  今日区块币价格  x  区块币数",
@property (nonatomic , copy) NSString              *qkb_bt_color;//": "666666",
@property (nonatomic , copy) NSString              *qkb_bz_color;//": "333333",
@property (nonatomic , copy) NSString              *qkb_sm_color;//": "999999",
@property (nonatomic , copy) NSString              *qkb_jgzs;//": "区块币价格走势",
@property (nonatomic , copy) NSString              *qkb_jgzs_color;//": "333333",
@property (nonatomic , copy) NSString              *qkb_zrzf;//": "昨日涨幅",
@property (nonatomic , copy) NSString              *qkb_zrzf_color;//": "999999",
@property (nonatomic , copy) NSString              *qkb_zf_color;//": "FF603A",
@property (nonatomic , copy) NSString              *qkb_jymx;//": "交易明细",
@property (nonatomic , copy) NSString              *qkb_jymx_color;//": "333333",
@property (nonatomic , copy) NSString              *qkb_zrzf_icon;//": "http://192.168.0.130/fnuoos_qkb/Upload/qkb/1555935352_1_3.png",
@property (nonatomic , copy) NSString              *qkb_jf_bg;//": "http://192.168.0.130/fnuoos_qkb/Upload/qkb/1555987415_1_4.png",
@property (nonatomic , copy) NSString              *qkb_my_bg;//": "http://192.168.0.130/fnuoos_qkb/Upload/qkb/1555987415_1_5.png",
@property (nonatomic , copy) NSString              *explain_url;//": "http://192.168.0.130/fnuoos_qkb/?mod=appapi&act=qkb&ctrl=explain",
@property (nonatomic , copy) NSString              *qkb_zrzf_percent;//": "2.2901%",

@property (nonatomic , copy) NSString              *qkb_my_jiazhi;

@property (nonatomic , copy) NSArray               *qkb_worth_info;//": [{
@property (nonatomic , copy) NSArray               *wealth_list;
@property (nonatomic , copy) NSArray               *btn_list;
@property (nonatomic , copy) NSDictionary               *line_chart;
@property (nonatomic , copy) NSString              *qkb_title;

@end



@interface FNDistrictCoinWorthItemModel : NSObject
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * detail;
@end

@interface FNDistrictCoinWealthItemModel : NSObject
@property (nonatomic , copy) NSString              * counts;
@property (nonatomic , copy) NSString              * tip_words;
@property (nonatomic , copy) NSString              * exchange_btn;
@property (nonatomic , copy) NSString              * recharge_btn;

@end

@interface FNDistrictCoinBtnItemModel : NSObject
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , copy) NSString              * type;

@end

@interface FNDistrictCoinChartModel : NSObject
@property (nonatomic , copy) NSArray               *qkb_list;
@property (nonatomic , copy) NSString              *min;
@property (nonatomic , copy) NSString              *max;
@end

@interface FNDistrictCoinChartItemModel : NSObject
@property (nonatomic , copy) NSString              * qkb_wroth;
@property (nonatomic , copy) NSString              * time;
@end



NS_ASSUME_NONNULL_END
