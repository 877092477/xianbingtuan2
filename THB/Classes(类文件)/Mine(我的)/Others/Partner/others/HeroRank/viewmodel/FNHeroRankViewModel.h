//
//  FNHeroRankViewModel.h
//  SuperMode
//
//  Created by jimmy on 2017/10/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMViewModel.h"
#import "FNHeroRankModel.h"
@interface FNHeroRankViewModel : JMViewModel
@property (nonatomic, strong)NSMutableArray<FNHeroRankModel *>* ranks;
@property (nonatomic, assign)NSInteger index;//0 for family,1for commission;
@end
