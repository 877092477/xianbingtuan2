//
//  FNPartnerCenterViewModel.h
//  SuperMode
//
//  Created by jimmy on 2017/10/16.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMViewModel.h"
#import "FNPartnerCenterModel.h"
#import "DisCenterIconModel.h"
@interface FNPartnerCenterViewModel : JMViewModel
@property (nonatomic, strong)FNPartnerCenterModel* model;
@property (nonatomic, strong)NSArray<DisCenterIconModel *>* CenterIconModel;
@end
