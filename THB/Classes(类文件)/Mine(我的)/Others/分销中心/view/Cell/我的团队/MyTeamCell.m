//
//  MyTeamCell.m
//  THB
//
//  Created by zhongxueyu on 16/7/30.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "MyTeamCell.h"

@implementation MyTeamCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setModel:(MyTeamModel *)model{
    _model = model;
    self.nickNameLabel.text = [NSString stringWithFormat:@"%@(%@)",model.nickname,model.phone];
    self.registerTimeLabel.text = model.time;
    self.incomeLabel.text = [NSString stringWithFormat:@"%@",model.j_commission];
    self.memberLabel.text = [NSString stringWithFormat:@"%@个成员",model.count];
    



}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
