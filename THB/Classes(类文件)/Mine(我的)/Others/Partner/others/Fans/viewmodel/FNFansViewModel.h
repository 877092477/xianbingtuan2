//
//  FNFansViewModel.h
//  SuperMode
//
//  Created by jimmy on 2017/10/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMViewModel.h"
#import "FNPromotionalTeamModel.h"
@interface FNFansViewModel : JMViewModel
@property (nonatomic, strong)NSMutableArray* persons;
@property (nonatomic, strong)FNPromotionalTeamModel* model;
/**
 *  sort
 */
@property (nonatomic, strong)NSNumber* sort;
@end
