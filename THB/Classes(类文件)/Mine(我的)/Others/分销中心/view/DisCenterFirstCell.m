//
//  DisCenterFirstCell.m
//  THB
//
//  Created by zhongxueyu on 16/7/28.
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

#import "DisCenterFirstCell.h"

@implementation DisCenterFirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.moreBtn.tag = 1;
    self.drawBtn.tag = 2;
    [self.moreBtn addTarget:self action:@selector(ClickButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.MyComssionCenter addTarget:self action:@selector(ClickButtonMethod:) forControlEvents:UIControlEventTouchUpInside];

    [self.drawBtn addTarget:self action:@selector(ClickButtonMethod:) forControlEvents:UIControlEventTouchUpInside];

}

-(void)ClickButtonMethod:(UIButton *)sender{
    [self.delegate ButtonClickMethod:sender.tag];
}

-(void)setModel:(FXCenterInfoModel *)model{
    _model = model;
    XYLog(@"model is  %@",model.lj_commission);
    [self.headerImg setHeader:Userhead_img];
    self.totalMoneyLabel.text = [NSString stringWithFormat:@"累计佣金:%@元",_model.lj_commission];
    self.usedMoneyLabel.text = _model.commission;
    self.nickName.text = _model.nickname;
    self.registerTime.text = [NSString stringWithFormat:@"加入时间:%@",_model.time];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
