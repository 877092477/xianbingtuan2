//
//  FNmeActivitToolItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmeActivitToolItemCell.h"

@implementation FNmeActivitToolItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.bgImgView=[[UIImageView alloc]init];
    [self addSubview:self.bgImgView];
    
    self.imgView=[[UIImageView alloc]init];
    [self addSubview:self.imgView];
    
    self.lineView=[[UIView alloc]init];
    [self addSubview:self.lineView];
    
    self.rightImgView=[[UIImageView alloc]init];
    [self addSubview:self.rightImgView];
    
    self.redImgView=[[UIImageView alloc]init];
    [self addSubview:self.redImgView];
    
    self.blueImgView=[[UIImageView alloc]init];
    [self addSubview:self.blueImgView];
    
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    
    self.hintLB=[[UILabel alloc]init];
    [self addSubview:self.hintLB];
    
    self.marchLB=[[UILabel alloc]init];
    [self addSubview:self.marchLB];
    
    self.notBegunLB=[[UILabel alloc]init];
    [self addSubview:self.notBegunLB];
    
    self.bgImgView.backgroundColor=[UIColor whiteColor];
    
    self.lineView.backgroundColor=RGB(240, 240, 240);
    
    self.nameLB.font=[UIFont systemFontOfSize:14];
    self.nameLB.textColor=RGB(51, 51, 51);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.hintLB.font=[UIFont systemFontOfSize:11];
    self.hintLB.textColor=RGB(153, 153, 153);
    self.hintLB.textAlignment=NSTextAlignmentLeft;
    
    self.marchLB.font=[UIFont systemFontOfSize:11];
    self.marchLB.textColor=RGB(51, 51, 51);
    self.marchLB.textAlignment=NSTextAlignmentLeft;
    
    self.notBegunLB.font=[UIFont systemFontOfSize:11];
    self.notBegunLB.textColor=RGB(51, 51, 51);
    self.notBegunLB.textAlignment=NSTextAlignmentLeft;
    
    self.bgImgView.cornerRadius=5;
    self.bgImgView.clipsToBounds = YES;
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 12).topSpaceToView(self, 0).rightSpaceToView(self, 21).bottomSpaceToView(self, 0);
    
    self.imgView.sd_layout
    .leftSpaceToView(self, 28).centerYEqualToView(self).heightIs(45).widthIs(45);
    
    self.lineView.sd_layout
    .centerYEqualToView(self).centerXEqualToView(self).heightIs(43).widthIs(1);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.imgView, 12).topSpaceToView(self, 23).heightIs(18).rightSpaceToView(self.lineView, 5);
    
    self.hintLB.sd_layout
    .leftSpaceToView(self.imgView, 12).topSpaceToView(self.nameLB, 4).heightIs(15).rightSpaceToView(self.lineView, 5);
    
    self.rightImgView.sd_layout
    .centerYEqualToView(self).rightSpaceToView(self, 8).widthIs(32).heightIs(32);
  
    
    self.redImgView.sd_layout
    .topSpaceToView(self, 27).leftSpaceToView(self.lineView, 28).widthIs(11).heightIs(11);
    
    self.blueImgView.sd_layout
    .topSpaceToView(self.redImgView, 8).leftSpaceToView(self.lineView, 28).widthIs(11).heightIs(11);
    
    self.marchLB.sd_layout
    .leftSpaceToView(self.redImgView, 3).centerYEqualToView(self.redImgView).heightIs(15).rightSpaceToView(self.rightImgView, 5);
    
    self.notBegunLB.sd_layout
    .leftSpaceToView(self.blueImgView, 3).centerYEqualToView(self.blueImgView).heightIs(15).rightSpaceToView(self.rightImgView, 5);
}

-(void)setModel:(FNmeActivitToolModel *)model{
    _model=model;
    if(model){
        [self.imgView setUrlImg:model.icon];
        [self.redImgView setUrlImg:model.ongoing_icon];
        [self.blueImgView setUrlImg:model.nostart_icon];
        [self.rightImgView setUrlImg:model.btn];
        
        self.nameLB.text=model.title;
        self.hintLB.text=model.tips;
        self.marchLB.text=model.ongoing_str;
        self.notBegunLB.text=model.nostart_str;
    }
}
@end
