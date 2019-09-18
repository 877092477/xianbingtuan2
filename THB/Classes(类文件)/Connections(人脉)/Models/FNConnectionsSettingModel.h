//
//  FNConnectionsSettingModel.h
//  THB
//
//  Created by Weller Zhao on 2019/3/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNConnectionsGroupModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNConnectionsSettingModel : NSObject

@property (nonatomic, copy) NSString *str;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *affiche;//公告
@property (nonatomic, copy) NSString *is_settop;
@property (nonatomic, copy) NSString *is_grouper;
@property (nonatomic, strong) NSArray<FNConnectionsGroupModel*> *list;

@end

NS_ASSUME_NONNULL_END
