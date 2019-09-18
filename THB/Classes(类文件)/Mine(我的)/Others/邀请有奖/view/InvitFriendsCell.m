//
//  InvitFriendsCell.m
//  THB
//
//  Created by zhongxueyu on 16/5/1.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "InvitFriendsCell.h"

@implementation InvitFriendsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}

-(void)setModel:(MyInvitModel *)model{
    _model = model;
    
    //    self.textArray = [NSMutableArray array];
    
    
    self.textArray = [NSMutableArray arrayWithObjects:model.lv,model.nickname,[NSString stringWithFormat:@"%.2f %@",model.fcommission,model.orderStatus],model.time, nil];
    CGFloat width = XYScreenWidth/4;
    CGFloat height = 21;
    for (int i = 0; i<4; i++) {
        self.label = [[UILabel alloc]init];
        self.label.frame = CGRectMake(i*width, CGRectGetHeight(self.contentView.frame)/2-10, width, height);
        self.label.text = self.textArray[i];
        
        self.label.font = kFONT12;
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:self.label];
        
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
