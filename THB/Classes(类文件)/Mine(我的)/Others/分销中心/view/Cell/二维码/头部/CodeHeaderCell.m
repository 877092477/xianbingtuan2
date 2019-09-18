//
//  CodeHeaderCell.m
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

#import "CodeHeaderCell.h"

@implementation CodeHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.btn addTarget:self action:@selector(copyTextMethod:) forControlEvents:UIControlEventTouchUpInside];
    self.btn.borderWidth=0.5;
    self.btn.borderColor=RED;
    self.btn.cornerRadius=5;
    self.btn.clipsToBounds = YES;
    self.btn.backgroundColor=[UIColor whiteColor];
    [self.btn setTitle:@"立即复制" forState:UIControlStateNormal];
    [self.btn setTitleColor:RED forState:UIControlStateNormal];
    [self.btn setBackgroundImage:IMAGE(@"") forState:UIControlStateNormal];
}

-(void)copyTextMethod:(UIButton *)sender{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _url;
    //[FNTipsView showTips:@"推广链接已粘贴到您的剪贴板"];
    [FNTipsView showTips:@"推广链接已粘贴到您的剪贴板"];
    
}

-(void)setUrl:(NSString *)url{
    _url = url;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
