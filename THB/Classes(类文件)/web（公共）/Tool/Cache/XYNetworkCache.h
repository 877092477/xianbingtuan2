//
//  XYNetworkCache.h
//  THB
//
//  Created by Weller Zhao on 2018/12/21.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYNetworkCache : NSObject

+(instancetype) shareInstance;
- (void)saveData: (NSDictionary*)data withUrl:(NSString *)url andParams: (NSDictionary *)parameter;
- (NSDictionary*)getDataWithUrl:(NSString *)url andParams: (NSDictionary *)parameter;
- (void)clearCache;

@end

NS_ASSUME_NONNULL_END
