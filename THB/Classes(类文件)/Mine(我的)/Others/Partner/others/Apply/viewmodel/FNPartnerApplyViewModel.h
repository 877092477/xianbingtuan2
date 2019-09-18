//
//  FNPartnerApplyViewModel.h
//  SuperMode
//
//  Created by jimmy on 2017/10/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMViewModel.h"
#import "FNPartnerApplyModel.h"
@interface FNPartnerApplyViewModel : JMViewModel
@property (nonatomic, strong)FNPartnerApplyModel* model;
@property (nonatomic, strong)NSArray<FAMintroduce *>* list;
@property (nonatomic, strong)RACCommand* confirmCommand;
@end
