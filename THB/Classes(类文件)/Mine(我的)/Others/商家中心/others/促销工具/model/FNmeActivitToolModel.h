//
//  FNmeActivitToolModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/5.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNmeActivitToolModel : NSObject
@property (nonatomic, copy)NSString* type;
@property (nonatomic, copy)NSString* icon;
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* tips;
@property (nonatomic, copy)NSString* ongoing_icon;
@property (nonatomic, copy)NSString* ongoing_str;
@property (nonatomic, copy)NSString* nostart_icon;
@property (nonatomic, copy)NSString* nostart_str;
@property (nonatomic, copy)NSString* btn;
@end

NS_ASSUME_NONNULL_END
