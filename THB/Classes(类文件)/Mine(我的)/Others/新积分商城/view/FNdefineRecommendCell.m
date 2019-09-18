//
//  FNdefineRecommendCell.m
//  THB
//
//  Created by Jimmy on 2019/1/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//
//推荐130
#import "FNdefineRecommendCell.h"

@implementation FNdefineRecommendCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews
{
    self.bgView=[UIView new];
    [self addSubview:self.bgView];
    
    self.RecommendImage=[[UIImageView alloc]init];
    [self.bgView addSubview:self.RecommendImage];
    
    self.versionLB=[UILabel new];
    self.versionLB.textColor=RGB(140, 140, 140);;
    self.versionLB.font=kFONT13;
    self.versionLB.textAlignment=NSTextAlignmentCenter;
    [self.bgView addSubview:self.versionLB];
    
    self.bgView.sd_layout
    .topSpaceToView(self.bgView,0).bottomSpaceToView(self, 10).leftSpaceToView(self, 10).rightSpaceToView(self, 10);
    
    self.RecommendImage.sd_layout
    .heightIs(30).widthIs(30).centerXEqualToView(self.bgView).topSpaceToView(self.bgView,30);
    
    self.versionLB.sd_layout
    .heightIs(15).leftSpaceToView(self.bgView, 5).rightSpaceToView(self.bgView, 5).topSpaceToView(self.RecommendImage,20);
    
}
-(void)setModel:(FNDefiniteListItemModel *)model{
    _model=model;
    if(model){
        self.bgView.backgroundColor=RGB(250, 249, 249);
        [self.RecommendImage setNoPlaceholderUrlImg:model.img];
        self.versionLB.text=model.name;
    }
}
@end
