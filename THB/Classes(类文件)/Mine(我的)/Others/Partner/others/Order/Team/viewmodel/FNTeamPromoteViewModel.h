//
//  FNTeamPromoteViewModel.h
//  SuperMode
//
//  Created by jimmy on 2017/10/19.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMViewModel.h"
#import "FNPromotePublicModel.h"
@interface FNTeamPromoteViewModel : JMViewModel
@property (nonatomic, strong)FNPromotePublicModel* model;
@property (nonatomic, strong)NSArray* titles;
@property (nonatomic, strong)NSMutableArray* list;
/**
 *  type
 */
@property (nonatomic, assign)NSInteger type;

@property (nonatomic, copy)NSString *SkipUIIdentifier;

@end
