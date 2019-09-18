//
//  FNBrokerageDetailHeadView.m
//  THB
//
//  Created by 李显 on 2018/9/11.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNBrokerageDetailHeadView.h"

@implementation FNBrokerageDetailHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor= [UIColor whiteColor];
        
        [self initUI];
    }
    return self;
}
-(void)initUI{
    self.headImageView=[UIImageView new];
    [self.contentView addSubview:self.headImageView];
    
    self.headTitle=[UILabel new];
    self.headTitle.textColor = [UIColor grayColor];
    self.headTitle.font=[UIFont fontWithDevice:12];
    [self.contentView addSubview:self.headTitle];
    
    [self initdistribute];
    UIView *lineview=[UIView new];
    [self.contentView addSubview:lineview];
    lineview.backgroundColor=FNColor(245, 245, 245);
    lineview.sd_layout
    .leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(1).bottomEqualToView(self.contentView);
}
-(void)initdistribute{
    
    self.headImageView.sd_layout
    .heightIs(15).widthIs(8).rightSpaceToView(self.contentView, 10).centerYEqualToView(self.contentView);
    self.headTitle.sd_layout
    .leftSpaceToView(self.contentView, 10).heightIs(20).centerYEqualToView(self.contentView);
    
    [self.headTitle setSingleLineAutoResizeWithMaxWidth:150];
}
@end
