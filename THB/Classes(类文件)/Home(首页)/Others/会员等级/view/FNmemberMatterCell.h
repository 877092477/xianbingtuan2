//
//  FNmemberMatterCell.h
//  THB
//
//  Created by Jimmy on 2018/9/7.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GradeMemberNModel.h"

@interface FNmemberMatterCell : UITableViewCell

/** 会员等级Image **/
@property (nonatomic, strong)UIImageView *matterImageView;

@property (nonatomic, strong)GradeAdvertisingNModel *model;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
