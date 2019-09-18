//
//  FNPCFilterView.h
//  SuperMode
//
//  Created by jimmy on 2017/10/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMView.h"
#import "FNCombinedButton.h"
typedef enum : NSUInteger {
    PFFilterTypeTimeDescending = 1,
    PFFilterTypeTimeAscending,
    PFFilterTypeCommissionDescending,
    PFFilterTypeCommissionAscending,
} PFFilterType;
@interface FNPCFilterView : JMView
@property (nonatomic, strong)FNCombinedButton* timebtn;
@property (nonatomic, strong)FNCombinedButton* commissionbtn;
@property (nonatomic, copy)void (^filterBlock)(PFFilterType type);
@property (nonatomic, assign)PFFilterType filtertype;

@end
