//
//  FNRMAccountManagementViewModel.h
//  THB
//
//  Created by Jimmy on 2018/1/15.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "JMViewModel.h"
#import "FNRMAccountManagementModel.h"
@interface FNRMAccountManagementViewModel : JMViewModel
@property (nonatomic, strong)NSArray<FNRMAccountManagementModel *>* list;
@end
