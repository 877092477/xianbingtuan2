//
//  FNMyVideoCardBuyModel.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/2.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNMyVideoCardBuyTypeModel : NSObject

@property (nonatomic, copy) NSString* ID;
@property (nonatomic, copy) NSString* cost_price;
@property (nonatomic, copy) NSString* price;
@property (nonatomic, copy) NSString* info;
@property (nonatomic, copy) NSString* content;
@property (nonatomic, copy) NSString* day;
@property (nonatomic, copy) NSString* sort;
@property (nonatomic, copy) NSString* lv;
@property (nonatomic, copy) NSString* is_check;
@property (nonatomic, copy) NSString* end_time;

@end

@interface FNMyVideoCardBuyModel : NSObject
    
@property (nonatomic, copy) NSString* top_title;
@property (nonatomic, copy) NSString* logo;
@property (nonatomic, copy) NSString* info;;
@property (nonatomic, copy) NSString* btn_img;
@property (nonatomic, copy) NSString* btn_color;
@property (nonatomic, copy) NSString* btn_str;
@property (nonatomic, copy) NSString* num;
@property (nonatomic, copy) NSString* money;
@property (nonatomic, copy) NSString* valid_str;
@property (nonatomic, strong) NSArray<FNMyVideoCardBuyTypeModel*>* card_type;
@end

NS_ASSUME_NONNULL_END
