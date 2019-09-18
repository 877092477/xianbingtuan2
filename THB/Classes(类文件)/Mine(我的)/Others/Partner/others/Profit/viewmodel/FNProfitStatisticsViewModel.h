//
//  FNProfitStatisticsViewModel.h
//  SuperMode
//
//  Created by jimmy on 2017/10/17.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMViewModel.h"
#import "FNProfitStatisticsModel.h"
@interface FNProfitStatisticsViewModel : JMViewModel
@property (nonatomic, strong)FNProfitStatisticsModel* model;

@property (nonatomic, strong)NSArray* datas;
@property (nonatomic, strong)NSArray* contents;

@property (nonatomic, strong)RACSubject* withdrawsubject;
@end
