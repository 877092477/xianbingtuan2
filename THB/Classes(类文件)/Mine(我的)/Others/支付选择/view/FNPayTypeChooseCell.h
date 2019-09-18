//
//  FNPayTypeChooseCell.h
//  THB
//
//  Created by Fnuo-iOS on 2018/6/15.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayTypeModel.h"
#import "FNMyCardPayTypeModel.h"

@interface FNPayTypeChooseCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong)PayTypeModel *PayModel;
@property (nonatomic,strong)FNMyCardPayTypeModel *CardPayModel;

@property (nonatomic,weak)UIImageView *Icon;
@property (nonatomic,weak)UILabel *TopLabel;
@property (nonatomic,weak)UILabel *BtmLabel;
@property (nonatomic,weak)UIImageView *choose;


@end
