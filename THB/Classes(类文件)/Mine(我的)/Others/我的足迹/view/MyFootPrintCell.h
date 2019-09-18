//
//  MyFootPrintCell.h
//  THB
//
//  Created by zhongxueyu on 16/3/31.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYSuperTableViewCell.h"
#import "MyFootModel.h"
@interface MyFootPrintCell : XYSuperTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *rebates;

@property (weak, nonatomic) IBOutlet UILabel *firstTime;

@property (weak, nonatomic) IBOutlet UILabel *lastTime;

@property (weak, nonatomic) IBOutlet UILabel *fromShop;

@property (weak, nonatomic) IBOutlet UILabel *rebatePercentage;

@property (nonatomic,strong) MyFootModel *model;


@end
