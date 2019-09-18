//
//  FNFreeProductDetailHeaderView.h
//  THB
//
//  Created by Weller on 2018/12/19.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView/SDCycleScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNFreeProductDetailHeaderView : UIView<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) UILabel       *lblCount;

@property (nonatomic, strong) UILabel       *lblPrice;
@property (nonatomic, strong) UILabel       *lblOriginalPrice;
@property (nonatomic, strong) UILabel       *lblDesc;

@property (nonatomic, strong) UILabel       *lblTitle;

- (void) setImages: (NSArray*) images;
- (void) setTime: (NSDate*) date ;
    
- (void)invalidate;

@end

NS_ASSUME_NONNULL_END
