//
//  FNmerLocationRedpackModel.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/30.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNmerLocationRedpackModel : NSObject

@property (nonatomic, copy) NSString* id;
@property (nonatomic, copy) NSString* store_id;
@property (nonatomic, copy) NSString* now_price;
@property (nonatomic, copy) NSString* now_counts;
@property (nonatomic, copy) NSString* start_time;
@property (nonatomic, copy) NSString* end_time;
@property (nonatomic, copy) NSString* kilometre;
@property (nonatomic, copy) NSString* is_advertising;
@property (nonatomic, copy) NSString* adv_img;
@property (nonatomic, copy) NSString* adv_url;
@property (nonatomic, copy) NSString* adv_seconds;

@end

NS_ASSUME_NONNULL_END
