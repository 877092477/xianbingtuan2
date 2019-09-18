//
//  FNStoreLocationRedpackModel.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/23.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNStoreLocationRedpackModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *store_lat;
@property (nonatomic, copy) NSString *store_lng;
@property (nonatomic, copy) NSString *ico;

@end

@interface FNStoreLocationRedpackDetailModel : NSObject

@property (nonatomic, copy) NSString *bjimg;
@property (nonatomic, copy) NSString *store_img;
@property (nonatomic, copy) NSString *store_name;
@property (nonatomic, copy) NSString *store_id;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *is_receive;
@property (nonatomic, copy) NSString *lid;

@end

NS_ASSUME_NONNULL_END
