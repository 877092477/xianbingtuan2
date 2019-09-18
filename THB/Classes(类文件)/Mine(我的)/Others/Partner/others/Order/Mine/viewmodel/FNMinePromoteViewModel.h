//
//  FNMinePromoteViewModel.h
//  SuperMode
//
//  Created by jimmy on 2017/10/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMViewModel.h"
#import "FNPromotePublicModel.h"
@interface FNMinePromoteViewModel : JMViewModel
/**
 *  list
 */
@property (nonatomic, strong)NSMutableArray* list;
/**
 *  index
 */
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *SkipUIIdentifier;

@property (nonatomic, strong)FNPromotePublicModel* model;
@property (nonatomic, strong)NSArray* titles;

@end
