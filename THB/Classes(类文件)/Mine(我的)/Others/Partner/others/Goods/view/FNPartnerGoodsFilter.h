//
//  FNPartnerGoodsFilter.h
//  SuperMode
//
//  Created by jimmy on 2017/10/19.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMView.h"
#import "FNCombinedButton.h"

typedef enum : NSUInteger {
    PGFFilterTypeCategory = 0,//商品分类
    PGFFilterTypeRecommend,//每日必推
    PGFFilterTypeFilter,//筛选
} PGFFilterType;
@interface FNPartnerGoodsFilter : JMView
@property (nonatomic, strong)NSMutableArray<FNCombinedButton *>* btns;
@property (nonatomic, strong)NSArray* titles;
@property (nonatomic, strong)UISearchBar* searchbar;
@property (nonatomic, copy)void (^filterClicked)(PGFFilterType type,FNCombinedButton* btn);
@end
