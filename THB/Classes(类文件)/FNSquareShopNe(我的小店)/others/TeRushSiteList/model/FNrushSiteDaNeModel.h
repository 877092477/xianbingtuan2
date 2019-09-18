//
//  FNrushSiteDaNeModel.h
//  69橙子
//
//  Created by Jimmy on 2018/12/6.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

@interface FNrushSiteDaNeModel : NSObject
@property(nonatomic, copy) NSString     *id;
@property(nonatomic, copy) NSString     *name;
@property(nonatomic, copy) NSString     *phone;
@property(nonatomic, copy) NSString     *is_check;

@property(nonatomic, copy) NSString     *long_address;
@property(nonatomic, copy) NSString     *address;
@property(nonatomic, assign) NSInteger     sex;
@property(nonatomic, copy) NSString     *lat;
@property(nonatomic, copy) NSString     *lng;
@property(nonatomic, copy) NSString     *is_peisong;


@end

//NS_ASSUME_NONNULL_END
