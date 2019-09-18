//
//  FNmerSetingsItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerSetingsItemCell.h"

@implementation FNmerSetingsItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.leftTitleLB=[[UILabel alloc]init];
    [self addSubview:self.leftTitleLB];
    
    self.rightLB=[[UILabel alloc]init];
    [self addSubview:self.rightLB];
    
    self.rightImgView=[[UIImageView alloc]init];
    [self addSubview:self.rightImgView];
    
    self.headView=[[UIImageView alloc]init];
    [self addSubview:self.headView];
    
    self.leftTitleLB.font=[UIFont systemFontOfSize:14];
    self.leftTitleLB.textColor=RGB(60, 60, 60);
    self.leftTitleLB.textAlignment=NSTextAlignmentLeft;
    
    self.rightLB.font=[UIFont systemFontOfSize:14];
    self.rightLB.textColor=RGB(140, 140, 140);
    self.rightLB.textAlignment=NSTextAlignmentRight;
    self.rightLB.numberOfLines=2;
    
    self.leftTitleLB.sd_layout
    .leftSpaceToView(self, 20).heightIs(20).widthIs(70).centerYEqualToView(self);
    
    self.rightLB.sd_layout
    .leftSpaceToView(self.leftTitleLB, 5).rightSpaceToView(self, 40).topSpaceToView(self, 5).bottomSpaceToView(self, 5);
    
    self.rightImgView.sd_layout
    .rightSpaceToView(self, 20).centerYEqualToView(self).widthIs(7).heightIs(13);
    
    self.headView.sd_layout
    .rightSpaceToView(self, 38).centerYEqualToView(self).widthIs(38).heightIs(38);
    
    self.headView.cornerRadius=38/2;
    self.headView.clipsToBounds = YES;
    //self.lineView=[[UIView alloc]init];
    //[self addSubview:self.lineView];
    //self.lineView.sd_layout
    //.bottomEqualToView(self).leftSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(1);
    
    self.headView.hidden=YES;
}

-(void)setModel:(FNmerSetingsItemModel *)model{
    _model=model;
    if(model){
        self.leftTitleLB.text=model.leftStr;
        self.rightLB.text=model.rightStr;
        self.rightImgView.image=IMAGE(@"FJ_xY_img");
        if(model.rightState==0){
           self.headView.hidden=YES;
        }else{
           self.headView.hidden=NO;
            [self.headView setUrlImg:model.imageUrl];
        }
    }
}
@end
