//
//  FNpredictDeliveryTimeModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/26.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNpredictDeliveryTimeModel : NSObject
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* dateTitle;
@property (nonatomic, copy)NSString* leftHint;
@property (nonatomic, copy)NSString* rightHint;
@property (nonatomic, copy)NSString* rightValue;
@property (nonatomic, copy)NSString* islLeftHint;
@property (nonatomic, copy)NSString* type;
@property (nonatomic, copy)NSArray* list;
@end

@interface FNpredictSpecialTimeModel : NSObject
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* startDate;
@property (nonatomic, copy)NSString* endDate;
@property (nonatomic, copy)NSString* startDateHint;
@property (nonatomic, copy)NSString* endDateHint;
@property (nonatomic, copy)NSString* duration;
@property (nonatomic, copy)NSString* durationPlaceholder;
@property (nonatomic, copy)NSString* durationHint;


@property (nonatomic, copy)NSString* start_time;
@property (nonatomic, copy)NSString* end_time;
@property (nonatomic, copy)NSString* time;
@end

NS_ASSUME_NONNULL_END
