//
//  FNMineSignUpHeader.h
//  THB
//
//  Created by Jimmy on 2018/1/17.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "JMView.h"
@class FNMineSignUpModel;
@interface FNMineSignUpHeader : JMView
@property (nonatomic, copy)void (^signUpClicked)(void);
@property (nonatomic, strong)FNMineSignUpModel* model;
@end
