//
//  FNteIndentBrandNeCell.h
//  69橙子
//
//  Created by Jimmy on 2018/12/6.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FNtendOrderDetailsDeModel.h"

@interface FNteIndentBrandNeCell : UITableViewCell
/** BGview **/
@property (nonatomic, strong)UIView* bgView;
/** 标题 **/
@property (nonatomic, strong)UILabel* titleLB;
/** state **/
@property (nonatomic, strong)UILabel* stateLB;
/** 值 **/
@property (nonatomic, strong)UILabel* happenLB;
@property(nonatomic , strong)FNtendOrderDetailsDeModel *model;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end


