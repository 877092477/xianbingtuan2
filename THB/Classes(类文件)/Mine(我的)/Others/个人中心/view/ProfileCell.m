//
//  ProfileCell.m
//  FnuoApp
//
//  Created by zhongxueyu on 16/3/5.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "ProfileCell.h"

@implementation ProfileCell

- (void)awakeFromNib {
    //添加下方分割线
    UIImageView *lineImg=[[UIImageView alloc] initWithFrame:CGRectMake(0, self.contentView.bounds.size.height, XYScreenWidth, 1)];
    
    lineImg.image = IMAGE(@"member_line1");
    [self.contentView addSubview:lineImg];
    
    lineImg.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .widthIs(XYScreenWidth)
    .heightIs(1);
    
    [self setupAutoHeightWithBottomView:lineImg bottomMargin:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
