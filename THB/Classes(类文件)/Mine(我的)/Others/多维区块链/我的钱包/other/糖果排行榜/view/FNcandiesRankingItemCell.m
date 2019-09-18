//
//  FNcandiesRankingItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcandiesRankingItemCell.h"

@implementation FNcandiesRankingItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    self.headImgView=[[UIImageView alloc]init];
    [self addSubview:self.headImgView]; 
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
   
    self.designationBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.designationBtn];
    
    self.gainLB=[[UILabel alloc]init];
    [self addSubview:self.gainLB];
    
    self.gainValueLB=[[UILabel alloc]init];
    [self addSubview:self.gainValueLB];
    
    self.designationBtn.cornerRadius=2;
    self.designationBtn.titleLabel.font=[UIFont systemFontOfSize:9];
    [self.designationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.titleLB.font=[UIFont systemFontOfSize:15];
    self.titleLB.textColor=RGB(251, 114, 82);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.nameLB.font=[UIFont systemFontOfSize:12];
    self.nameLB.textColor=RGB(37, 37, 43);
    self.nameLB.textAlignment=NSTextAlignmentCenter;
    
    self.gainLB.font=[UIFont systemFontOfSize:9];
    self.gainLB.textColor=RGB(37, 37, 43);
    self.gainLB.textAlignment=NSTextAlignmentLeft;
    
    self.gainValueLB.font=[UIFont systemFontOfSize:18];
    self.gainValueLB.textColor=RGB(254, 178, 31);
    self.gainValueLB.textAlignment=NSTextAlignmentRight;
    
    self.headImgView.cornerRadius=53/2;
    self.headImgView.borderWidth=1;
    self.headImgView.borderColor=RGB(252, 211, 53);
    self.headImgView.clipsToBounds = YES;
    
    self.headImgView.sd_layout
    .leftSpaceToView(self, 71).centerYEqualToView(self).heightIs(53).widthIs(53);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 10).centerYEqualToView(self).heightIs(15).rightSpaceToView(self.headImgView, 2);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.headImgView, 2).bottomSpaceToView(self, 17).heightIs(16).widthIs(85);
    
    self.designationBtn.sd_layout
    .centerXEqualToView(self.nameLB).heightIs(12).widthIs(30).bottomSpaceToView(self.nameLB, 7);
    
    self.gainLB.sd_layout
    .centerYEqualToView(self).leftSpaceToView(self.nameLB, 2).heightIs(14).widthIs(60);
    
    self.gainValueLB.sd_layout
    .centerYEqualToView(self).leftSpaceToView(self.gainLB, 2).heightIs(25).rightSpaceToView(self, 25);
    
}

-(void)setModel:(FNcandiesRankItemModel *)model{
    _model=model;
    if(model){
        self.titleLB.text=model.rank_str;
        self.nameLB.text=model.nickname;
        [self.designationBtn setTitle:model.vip_name forState:UIControlStateNormal];
        [self.designationBtn sd_setBackgroundImageWithURL:URL(model.vip_img) forState:UIControlStateNormal];
        //self.gainLB.text=model.str;
        self.gainValueLB.text=model.qkb_count;
        [self.headImgView setUrlImg:model.head_img];
        self.titleLB.textColor=[UIColor colorWithHexString:model.rank_color];
        self.gainValueLB.textColor=[UIColor colorWithHexString:model.count_color]; 
        CGFloat designationW=[model.vip_name kr_getWidthWithTextHeight:12 font:9];
        if(designationW>60){
           designationW=60;
        }
        self.designationBtn.sd_resetLayout
        .centerXEqualToView(self.nameLB).heightIs(12).widthIs(designationW+20).bottomSpaceToView(self.nameLB, 7);
        self.designationBtn.titleLabel.sd_layout
        .rightSpaceToView(self.designationBtn, 4).leftSpaceToView(self.designationBtn, 16).centerYEqualToView(self.designationBtn).heightIs(12);
    }
}
@end
