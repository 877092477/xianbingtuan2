//
//  FNdistrictConvertTypefeModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/5.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNdistrictConvertTypefeModel : NSObject
@property (nonatomic , copy) NSString              *color;
@property (nonatomic , copy) NSString              *title;
@property (nonatomic , copy) NSArray               *list;
@end

@interface FNConvertTypeItemfeModel : NSObject
@property (nonatomic , copy) NSString              *title;
@property (nonatomic , copy) NSString              *type;
@end

@interface FNConvertfeModel : NSObject

@property (nonatomic , copy) NSString              *top_title;
@property (nonatomic , copy) NSString              *top_qkb_count;
@property (nonatomic , copy) NSString              *btn_bg;
@property (nonatomic , copy) NSString              *btn_check_bg;
@property (nonatomic , copy) NSString              *btn_bg_fcolor;
@property (nonatomic , copy) NSString              *btn__check_bg_fcolor;
@property (nonatomic , copy) NSString              *middel_title;
@property (nonatomic , copy) NSString              *middel_tips;
@property (nonatomic , copy) NSString              *middel_btn;
@property (nonatomic , copy) NSString              *last_title;
@property (nonatomic , copy) NSString              *last_tips;
@property (nonatomic , copy) NSString              *last_btn;
@property (nonatomic , copy) NSString              *bili;
@property (nonatomic , copy) NSString              *top_tips;
@property (nonatomic , copy) NSString              *sxf_tips;
@property (nonatomic , copy) NSString              *sxf;
@property (nonatomic , copy) NSString              *price;
@property (nonatomic , copy) NSString              *btn_font;
@property (nonatomic , copy) NSString              *compute_type;
@property (nonatomic , copy) NSString              *max_count;
@end

@interface FNConvertEditItemfeModel : NSObject
@property (nonatomic , copy) NSString              *titleStr;
@property (nonatomic , copy) NSString              *msgStr;
@property (nonatomic , copy) NSString              *hintStr;
@property (nonatomic , copy) NSString              *valueStr;
@property (nonatomic , assign) NSInteger              moreShow;
@property (nonatomic , copy) NSString              *compute_type;
@end
NS_ASSUME_NONNULL_END
