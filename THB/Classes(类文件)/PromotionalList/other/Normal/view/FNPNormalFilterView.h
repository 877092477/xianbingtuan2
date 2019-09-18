//
//  FNPNormalFilterView.h
//  SuperMode
//
//  Created by jimmy on 2017/6/12.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMView.h"

typedef enum : NSUInteger {
    FilterTypeComplex = 1,
    FilterTypeSale,
    FilterTypePrice,
    FilterTypeNew,
    FilterTypeCommission,
    FilterTyCoupon,
} FilterType;
@interface FNPNormalFilterView : JMView
@property (nonatomic, strong)NSArray* titles;
@property (nonatomic, strong)NSArray* images;
@property (nonatomic, strong)NSArray* selectedImage;
@property (nonatomic, assign)FilterType currentType;
@property (nonatomic, strong)void (^clickedWithType)(FilterType type);
- (void)changeName:(NSString *)name atIndex:(NSInteger)index;
- (void)selectedAtIndex:(NSInteger)index;
@end

