//
//  FNGradelItemNView.h
//  THB
//
//  Created by 李显 on 2018/9/9.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StrategyItemModel;
@interface FNGradelItemNView : UIView

@property (nonatomic, strong)UIImageView *lineGrayView;

@property (nonatomic, strong)UILabel* StrategytitleLB;

@property (nonatomic, strong)UILabel* StrategypriceLB;

@property (nonatomic, strong)StrategyItemModel *model;

@end
