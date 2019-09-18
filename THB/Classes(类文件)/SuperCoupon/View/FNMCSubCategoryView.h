//
//  FNMCSubCategoryView.h
//  THB
//
//  Created by jimmy on 2017/10/31.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMTitleScrollView.h"
typedef enum : NSUInteger {
    SCFilterTypeComplex = 1,
    SCFilterTypeSale,
    SCFilterTypePriceDescending,
    SCFilterTypeNew,
    SCFilterTypeHot,
    SCFilterTypePriceAscending,
} SCFilterType;
@class XYTitleModel;

@interface FNMCSubCategoryView : UIView
@property (nonatomic, strong)JMTitleScrollView* titleView;
@property (nonatomic, strong)UICollectionView* collectionview;
@property (nonatomic, strong)UIView* filterview;
@property (nonatomic, strong)NSArray* cates;
@property (nonatomic, strong)NSArray<XYTitleModel *>* subcates;
@property (nonatomic, weak)id<JMTitleScrollViewDelegate> cateDelegate;
@property (nonatomic, assign)SCFilterType type;
@property (nonatomic, strong)void (^filterbtnClicked)(SCFilterType index);
@end
