//
//  FNtradeRecommendCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNtradeRecommendCell.h"

@implementation FNtradeRecommendCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews{
    self.headImgView=[[UIImageView alloc]init];
    [self addSubview:self.headImgView];
    
    self.playImgView=[[UIImageView alloc]init];
    [self addSubview:self.playImgView];
    
    self.dateImgView=[[UIImageView alloc]init];
    [self addSubview:self.dateImgView];
    
    self.hotImgView=[[UIImageView alloc]init];
    [self addSubview:self.hotImgView];
    
    self.shoImgView=[[UIImageView alloc]init];
    [self addSubview:self.shoImgView];
    
    self.stateImgView=[[UIImageView alloc]init];
    [self addSubview:self.stateImgView];
    
    self.shoLB=[[UILabel alloc]init];
    [self addSubview:self.shoLB];
    
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.dateLB=[[UILabel alloc]init];
    [self addSubview:self.dateLB];
    
    self.countLB=[[UILabel alloc]init];
    [self addSubview:self.countLB];
    
    self.lineView=[[UIView alloc]init];
    [self addSubview:self.lineView];
    
    self.lineView.backgroundColor=RGB(240, 240, 240);
    self.headImgView.backgroundColor=RGB(250, 250, 250);
//    self.dateImgView.backgroundColor=RGB(250, 250, 250);
//    self.hotImgView.backgroundColor=RGB(250, 250, 250);
//    self.playImgView.backgroundColor=[UIColor whiteColor];
//    self.shoImgView.backgroundColor=[UIColor whiteColor];
//    self.stateImgView.backgroundColor=[UIColor whiteColor]; 
    
    self.shoLB.font=[UIFont systemFontOfSize:8];
    self.shoLB.textColor=[UIColor lightGrayColor];
    self.shoLB.textAlignment=NSTextAlignmentLeft;
    
    self.nameLB.font=[UIFont systemFontOfSize:15];
    self.nameLB.textColor=RGB(27, 28, 36);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    self.nameLB.numberOfLines=2;
    
    self.titleLB.font=[UIFont systemFontOfSize:12];
    self.titleLB.textColor=RGB(23, 22, 26);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.dateLB.font=[UIFont systemFontOfSize:9];
    self.dateLB.textColor=RGB(27, 28, 36);
    self.dateLB.textAlignment=NSTextAlignmentLeft;
    
    self.countLB.font=[UIFont systemFontOfSize:9];
    self.countLB.textColor=RGB(27, 28, 36);
    self.countLB.textAlignment=NSTextAlignmentRight;
    
    self.headImgView.sd_layout
    .leftSpaceToView(self, 12).centerYEqualToView(self).widthIs(128).heightIs(88);
    
    self.playImgView.sd_layout
    .leftSpaceToView(self, 53).centerYEqualToView(self).widthIs(45).heightIs(45);
    
    self.shoImgView.sd_layout
    .leftSpaceToView(self, 15).topSpaceToView(self, 17).widthIs(13).heightIs(13);
    
    self.stateImgView.sd_layout
    .rightEqualToView(self.headImgView).topEqualToView(self.headImgView).widthIs(39).heightIs(33);
    
    self.shoLB.sd_layout
    .leftSpaceToView(self.shoImgView, 5).centerYEqualToView(self.shoImgView).heightIs(12).rightSpaceToView(self.stateImgView, 10);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.headImgView, 10).topSpaceToView(self, 7) .rightSpaceToView(self, 12).heightIs(50); 
    
    self.dateImgView.sd_layout
    .leftSpaceToView(self.headImgView, 10).bottomEqualToView(self.headImgView).widthIs(10).heightIs(10);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self.headImgView, 10).bottomSpaceToView(self.dateImgView, 6).rightSpaceToView(self, 12).heightIs(16);
    
    self.dateLB.sd_layout
    .leftSpaceToView(self.dateImgView, 4).centerYEqualToView(self.dateImgView).heightIs(13).widthIs(100);
    
    self.countLB.sd_layout
    .rightSpaceToView(self, 12).centerYEqualToView(self.dateImgView).widthIs(30).heightIs(13);
    
    self.hotImgView.sd_layout
    .rightSpaceToView(self.countLB, 5).bottomSpaceToView(self, 14).widthIs(10).heightIs(11);
    
    self.lineView.sd_layout
    .leftSpaceToView(self, 12).bottomEqualToView(self).rightSpaceToView(self, 12).heightIs(1);
   
}
-(void)setModel:(FNtradeHomeRecommendItemModel *)model{
    _model=model;
    if(model){
        self.nameLB.text=model.title;//@"嗨如意商学院新人必看小技巧《让你微信被加爆的方法》";
        [self.nameLB fn_changeLineSpaceWithTextLineSpace:5];
        self.titleLB.text=model.author;//@"嗨如意商学院";
        //self.shoLB.text=@"嗨如意";
        self.dateLB.text=model.create_time;//@"2019-6-12 12:23";
        self.countLB.text=model.browse;//@"1.5w";
        CGFloat countLBW=[self.countLB.text kr_getWidthWithTextHeight:13 font:9];
        if(countLBW>80){
            countLBW=80;
        }
        self.countLB.sd_layout
        .rightSpaceToView(self, 12).centerYEqualToView(self.dateImgView).widthIs(countLBW).heightIs(13);
        self.hotImgView.sd_layout
        .rightSpaceToView(self.countLB, 5).centerYEqualToView(self.dateImgView).widthIs(10).heightIs(11);
        [self.headImgView setUrlImg:model.thumbnail];
        [self.playImgView setUrlImg:model.play_icon];
        [self.hotImgView setUrlImg:model.browse_icon];
        [self.dateImgView setUrlImg:model.time_icon];
    }
}
@end
