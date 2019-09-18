//
//  FNPromotionalTeamViewModel.h
//  SuperMode
//
//  Created by jimmy on 2017/10/17.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMViewModel.h"
#import "FNPromotionalTeamModel.h"

@interface FNPromotionalTeamViewModel : JMViewModel
/**
 *  is partner
 */
@property (nonatomic, assign)BOOL notPartner;
@property (nonatomic, strong)FNPromotionalTeamModel* model;

@property (nonatomic, strong)NSMutableArray*  persons;

/**
 *  sort
 */
@property (nonatomic, strong)NSNumber* sort;

@end
