//
//  OtherRebateModel.h
//  THB
//
//  Created by Fnuo-iOS on 2018/5/5.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OtherRebatetopListModel.h"
#import "FNTBRebateHotModel.h"
#import "XYTitleModel.h"

@interface OtherRebateModel : NSObject

@property(nonatomic,strong)NSArray<OtherRebatetopListModel *>* topList;

@property(nonatomic,strong)NSArray<FNTBRebateHotModel *>* keyword;

@property(nonatomic,strong)NSArray<XYTitleModel *>* cate;

@end
