//
//  FNFamilyViewModel.h
//  SuperMode
//
//  Created by jimmy on 2017/11/4.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMViewModel.h"
#import "FNPromotionalTeamModel.h"
#import "FNFamilyHeaderModel.h"

@interface FNFamilyViewModel : JMViewModel
@property (nonatomic, strong)NSMutableArray<PTMfan*>* members;
@property (nonatomic, strong)NSArray<FNFamilyHeaderModel*>* Header;
@property (nonatomic, strong)NSArray<FNFamilyHeaderModel*>* twoHeader;
@property (nonatomic, strong)FNPromotionalTeamModel* model;
@property (nonatomic, copy)NSString *index;//0 for first, 1 for second;
@property (nonatomic, copy)NSString *twoIndex;// 
@property (nonatomic, strong) RACSubject *refreshHeader;

@property (nonatomic, assign)NSInteger seletedState;

@end
