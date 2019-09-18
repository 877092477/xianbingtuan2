//
//  FNWithdrawViewModel.h
//  SuperMode
//
//  Created by jimmy on 2017/6/15.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMViewModel.h"
#import "FNWithdrawMOdel.h"
@interface FNWithdrawViewModel : JMViewModel
@property (nonatomic, strong)RACSubject* successSubject;
@property (nonatomic, strong)RACCommand* confirmCommand;
@property (nonatomic, copy)NSString* balance;
@property (nonatomic, copy)NSString* tips;
@property (nonatomic, strong)FNWithdrawMOdel* model;
@property (nonatomic, copy)NSString* type;
@end
