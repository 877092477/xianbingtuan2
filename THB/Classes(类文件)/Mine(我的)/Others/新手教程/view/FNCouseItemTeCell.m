//
//  FNCouseItemTeCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/9.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNCouseItemTeCell.h"

@implementation FNCouseItemTeCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews{
    
    self.dateLB=[[UILabel alloc]init];
    self.imgView=[[UIImageView alloc]init];
    self.bgView=[[UIView alloc]init];
    self.contentLB=[[UILabel alloc]init];
    self.rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.imgView];
    [self addSubview:self.dateLB];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.contentLB];
    [self.bgView addSubview:self.rightBtn];
    
    self.dateLB.font=kFONT11;
    self.dateLB.textColor=RGB(153, 153, 153);
    self.dateLB.textAlignment=NSTextAlignmentCenter;
    self.contentLB.font=kFONT16;
    self.contentLB.textColor=RGB(60, 60, 60);
    self.contentLB.textAlignment=NSTextAlignmentLeft;
    [self incomposition];
}
-(void)incomposition{
    
    self.dateLB.sd_layout
    .leftSpaceToView(self, 10).rightSpaceToView(self, 10).topSpaceToView(self, 0).heightIs(30);
    
    self.imgView.sd_layout
    .leftSpaceToView(self, 10).rightSpaceToView(self, 10).topSpaceToView(self, 30).heightIs(145);
    
    self.bgView.sd_layout
    .leftSpaceToView(self, 10).rightSpaceToView(self, 10).topSpaceToView(self, 175).heightIs(45);
    
    self.rightBtn.sd_layout
    .rightSpaceToView(self.bgView, 0).widthIs(45).heightIs(45).centerYEqualToView(self.bgView);
    
    self.rightBtn.imageView.sd_layout
    .centerYEqualToView(self.rightBtn).centerXEqualToView(self.rightBtn).widthIs(15).heightIs(15);
    
    self.contentLB.sd_layout
    .leftSpaceToView(self.bgView, 15).rightSpaceToView(self.bgView, 50).bottomSpaceToView(self.bgView, 0).topSpaceToView(self.bgView, 0);
    
}

-(void)setModel:(FNCourseTeModel *)model{
    _model=model;
    if(model){
       self.dateLB.text=model.time;
       self.contentLB.text=model.name;
       [self.imgView setUrlImg:model.img];
       self.bgView.backgroundColor=[UIColor whiteColor];
       //[self.rightBtn setImage:IMAGE(@"FN_Couse_fximg") forState:UIControlStateNormal];
       NSInteger is_show_share=[model.is_show_share integerValue];
       if(is_show_share==0){
           self.rightBtn.hidden=YES;
       }else{
           self.rightBtn.hidden=NO;
           [self.rightBtn sd_setImageWithURL:URL(model.share_img) forState:UIControlStateNormal];
           [self.rightBtn addTarget:self action:@selector(rightBtnAction)];
           
       }
    }
}
-(void)rightBtnAction{
    if ([self.delegate respondsToSelector:@selector(inCouseItemShareAction:)]) {
        [self.delegate inCouseItemShareAction:self.indexPath];
    }
}
@end
