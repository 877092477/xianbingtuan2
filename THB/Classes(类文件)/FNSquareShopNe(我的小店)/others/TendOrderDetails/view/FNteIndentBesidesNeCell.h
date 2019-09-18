//
//  FNteIndentBesidesNeCell.h
//  69橙子
//
//  Created by Jimmy on 2018/12/6.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FNtendOrderDetailsDeModel.h"

@interface FNteIndentBesidesNeCell : UITableViewCell
/** BG **/
@property (nonatomic, strong)UIView *bgView;
/** 文本 **/
@property (nonatomic, strong)UILabel* corrupLB;
/** Line **/
@property (nonatomic, strong)UILabel* LineLB;
@property(nonatomic , strong)FNtendDetailsOrderMsgModel *model;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end


