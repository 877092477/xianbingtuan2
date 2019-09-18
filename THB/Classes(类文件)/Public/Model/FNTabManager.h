//
//  FNTabManager.h
//  导购物语
//
//  Created by Weller on 2019/6/6.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNTabModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNTabManager : NSObject

@property (nonatomic, strong)NSArray<FNTabModel *>* tabs;

+(instancetype) shareInstance ;

@end

NS_ASSUME_NONNULL_END
