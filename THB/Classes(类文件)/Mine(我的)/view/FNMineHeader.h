//
//  FNMineHeader.h
//  THB
//
//  Created by Jimmy on 2018/1/16.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "JMView.h"

@interface FNMineHeader : JMView
@property (nonatomic, strong)ProfileModel* model;
@property (nonatomic, copy)void (^profileClicked)(void);
@property (nonatomic, copy)void (^loginClicked)(void);

@property (nonatomic, strong)UIButton* upgradeButton;

@end
