//
//  FNStoreGoodsSpecManagerModel.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/13.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNStoreGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNStoreGoodsSpecManagerModel : NSObject

@property (nonatomic, copy) NSString* id;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* type;
@property (nonatomic, strong) NSArray<FNStoreGoodsSpecDataModel*> *list;

@property (nonatomic, assign)BOOL isSelected;

@end

NS_ASSUME_NONNULL_END
