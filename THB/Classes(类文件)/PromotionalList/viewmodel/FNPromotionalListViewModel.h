//
//  FNPromotionalListViewModel.h
//  THB
//
//  Created by Jimmy on 2017/12/22.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMViewModel.h"

@interface FNPromotionalListViewModel : JMViewModel
/**
 普通商品样式，头部有分类，有筛选（view_type=0）,产品样式的（view_type=1）, 时间抢购类型的（view_type=2）
 */
@property (nonatomic, copy)NSString* view_type;
@property (nonatomic, copy)NSString* identifier;
@property (nonatomic, copy)NSString* time;
@property (nonatomic, copy)NSString* cid;
@property (nonatomic, copy)NSString* sort;
@property (nonatomic, copy)NSString* status;

@property (nonatomic, strong)NSMutableArray* products;
@end
