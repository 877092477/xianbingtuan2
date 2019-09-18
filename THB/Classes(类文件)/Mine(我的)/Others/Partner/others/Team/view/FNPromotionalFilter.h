//
//  FNPromotionalFilter.h
//  SuperMode
//
//  Created by jimmy on 2017/10/17.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMView.h"
#import "FNCombinedButton.h"
#import "FNPCFilterView.h"

@interface FNPromotionalFilter : JMView
@property (nonatomic, strong)UIView* cateView;
@property (nonatomic, strong)UIView* indicatorview;
@property (nonatomic, strong)NSMutableArray* btns;
@property (nonatomic, strong)NSArray* cates;

@property (nonatomic, strong)FNPCFilterView* filterView;



@property (nonatomic, copy)void (^catesBlock)(BOOL isfirst);
/**
 *  my partner count
 */
@property (nonatomic, copy)NSString* mpcount;
/**
 *  team count
 */
@property (nonatomic, copy)NSString* tcount;
@end
