//
//  FNJDFeaturedListController.h
//  THB
//
//  Created by jimmy on 2017/5/24.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "SuperViewController.h"

typedef enum : NSUInteger {
    FLVCTypeHighRebate = 0,
    FLVCTypeNine,
    FLVCTypeJD,
} FLVCType;
@interface FNJDFeaturedListController : SuperViewController
@property (nonatomic, assign)FLVCType type;
@property (nonatomic, copy)NSString* cateID;

@property (nonatomic, copy)NSString* searchTitle;
@property (nonatomic, copy)NSNumber* sort;
@property (nonatomic, copy)NSString* price1;
@property (nonatomic, copy)NSString* price2;
@end
