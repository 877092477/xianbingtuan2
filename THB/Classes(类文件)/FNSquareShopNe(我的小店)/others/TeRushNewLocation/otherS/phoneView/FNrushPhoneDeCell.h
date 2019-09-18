//
//  FNrushPhoneDeCell.h
//  69橙子
//
//  Created by 李显 on 2018/12/9.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJPerson;

@interface FNrushPhoneDeCell : UITableViewCell


@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *phoneNumLabel;

@property (nonatomic, strong)UIImageView *iconImageV;

@property (nonatomic, strong) LJPerson *model;
@end


