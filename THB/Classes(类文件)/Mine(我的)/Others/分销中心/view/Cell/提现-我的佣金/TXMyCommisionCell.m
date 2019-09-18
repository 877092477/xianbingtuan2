//
//  TXMyCommisionCell.m
//  THB
//
//  Created by zhongxueyu on 16/8/11.
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

#import "TXMyCommisionCell.h"

@implementation TXMyCommisionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(CommissionOModel *)model{
    self.orderNum.text = [NSString stringWithFormat:@"%@:%@",model.lv,model.orderId];
    self.nickname.text = model.nickname;
    self.money.text = model.return_commission;
    
    NSString*string =model.time;
    NSString *year;
    NSString *month;
    year = [string substringToIndex:4];//截取掉下标之前的字符串
    NSLog(@"截取的值为：%@",string);
    month = [string substringFromIndex:5];//截取掉下标4之后的字符串
    NSLog(@"截取的值为：%@",string);
    self.year.text =year;
    self.time_month.text = month;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
