//
//  FNcandiesGrowModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNcandiesGrowModel : NSObject
@property (nonatomic, copy)NSString* dwqkb_grow_name;
@property (nonatomic, copy)NSString* dwqkb_grow_title;
@property (nonatomic, copy)NSString* dwqkb_grow_return_btn;
@property (nonatomic, copy)NSString* dwqkb_grow_top_bj;
@property (nonatomic, copy)NSString* dwqkb_grow_top_color;
@property (nonatomic, copy)NSString* dwqkb_grow_progress_scolor;
@property (nonatomic, copy)NSString* dwqkb_grow_progress_ecolor;
@property (nonatomic, copy)NSString* dwqkb_grow_lv_color;
@property (nonatomic, copy)NSString* dwqkb_grow_upgrade_detial;
@property (nonatomic, copy)NSString* dwqkb_grow_frozen_bj;
@property (nonatomic, copy)NSString* dwqkb_grow_frozen_tips;
@property (nonatomic, copy)NSString* dwqkb_grow_frozen_tips_color;
@property (nonatomic, copy)NSString* dwqkb_grow_lv_detail;
@property (nonatomic, copy)NSString* now_experie_str;
@property (nonatomic, copy)NSString* sxf;
@property (nonatomic, copy)NSString* lv_explain_str;
@property (nonatomic, copy)NSString* see_detail;





@property (nonatomic, copy)NSString* dwqkb_grow_upgrade_detial_color;
@property (nonatomic, copy)NSString* dwqkb_grow_frozen_color;
@property (nonatomic, copy)NSString* head_img;
@property (nonatomic, copy)NSString* nickname;

@property (nonatomic, copy)NSString* now_lv;
@property (nonatomic, copy)NSString* sup_lv;
@property (nonatomic, copy)NSString* frozen_value;

@end

@interface FNcandiesGrowGardeItemModel : NSObject
@property (nonatomic, assign)NSInteger  presentInt;//当前等级
@property (nonatomic, assign)NSInteger  gardeInt;//改变颜色色值
@property (nonatomic, assign)NSInteger  valLGarde;
@property (nonatomic, assign)NSInteger  valRGarde;
@property (nonatomic, assign)NSInteger  valRDGarde;//最高 的等级显示右边1
@property (nonatomic, copy)NSString* img;
@property (nonatomic, copy)NSString* imgGarde;
@property (nonatomic, copy)NSString* gradeValue;
@property (nonatomic, copy)NSString* gradeRiValue;
@property (nonatomic, copy)NSString* colour1str;
@property (nonatomic, copy)NSString* colour2str;
@property (nonatomic, copy)NSString* colourText;

@property (nonatomic, assign)NSInteger maxVal;
@property (nonatomic, assign)NSInteger presentVal;
@property (nonatomic, assign)NSInteger bufferState;
@end
@interface FNcandiesGrowGardeDetailModel : NSObject

@property (nonatomic, copy)NSString* img;
@property (nonatomic, copy)NSString* imgGarde;

@property (nonatomic, copy)NSString* date;
@property (nonatomic, copy)NSString* detail;
@property (nonatomic, copy)NSString* counts_str;
@property (nonatomic, copy)NSString* counts_color;
@property (nonatomic, copy)NSString* icon;

@end
NS_ASSUME_NONNULL_END
