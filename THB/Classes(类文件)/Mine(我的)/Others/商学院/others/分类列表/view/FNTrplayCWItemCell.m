//
//  FNTrplayCWItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/24.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNTrplayCWItemCell.h"

@implementation FNTrplayCWItemCell
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
    
    
    self.dateLB=[[UILabel alloc]init];
    [self addSubview:self.dateLB];
    
    self.countLB=[[UILabel alloc]init];
    [self addSubview:self.countLB];
    
//    self.headImgView.backgroundColor=RGB(250, 250, 250);
//    self.dateImgView.backgroundColor=RGB(250, 250, 250);
//    self.hotImgView.backgroundColor=RGB(250, 250, 250);
//
//    self.playImgView.backgroundColor=[UIColor whiteColor];
//    self.shoImgView.backgroundColor=[UIColor whiteColor];
//    self.stateImgView.backgroundColor=[UIColor whiteColor];
    
    self.shoLB.font=[UIFont systemFontOfSize:12];
    self.shoLB.textColor=[UIColor lightGrayColor];
    self.shoLB.textAlignment=NSTextAlignmentLeft;
    
    self.dateLB.font=[UIFont systemFontOfSize:9];
    self.dateLB.textColor=RGB(27, 28, 36);
    self.dateLB.textAlignment=NSTextAlignmentLeft;
    
    self.countLB.font=[UIFont systemFontOfSize:9];
    self.countLB.textColor=RGB(27, 28, 36);
    self.countLB.textAlignment=NSTextAlignmentRight;
    
    self.headImgView.sd_layout
    .leftSpaceToView(self, 12).topSpaceToView(self, 12).rightSpaceToView(self, 12).heightIs(145);
    
    self.shoImgView.sd_layout
    .leftSpaceToView(self, 15).topSpaceToView(self, 17).widthIs(20).heightIs(20);
    
    self.stateImgView.sd_layout
    .rightEqualToView(self.headImgView).topEqualToView(self.headImgView).widthIs(39).heightIs(33);
    
    self.shoLB.sd_layout
    .leftSpaceToView(self.shoImgView, 5).centerYEqualToView(self.shoImgView).heightIs(12).rightSpaceToView(self.stateImgView, 10);
    
    self.playImgView.sd_layout
    .topSpaceToView(self, 62).centerXEqualToView(self).widthIs(45).heightIs(45);
    
    self.dateImgView.sd_layout
    .leftSpaceToView(self, 12).bottomSpaceToView(self, 10).widthIs(10).heightIs(10);
    
    self.dateLB.sd_layout
    .leftSpaceToView(self.dateImgView, 10).centerYEqualToView(self.dateImgView).heightIs(13).widthIs(100);
    
    self.countLB.sd_layout
    .rightSpaceToView(self, 12).centerYEqualToView(self.dateImgView).widthIs(30).heightIs(13);
    
    self.hotImgView.sd_layout
    .rightSpaceToView(self.countLB, 5).bottomSpaceToView(self, 12).widthIs(10).heightIs(11);
   
    self.headImgView.contentMode=UIViewContentModeScaleToFill;
    self.headImgView.clipsToBounds=YES;
}

-(void)setModel:(FNtradeHomeRecommendItemModel *)model{
    _model=model;
    if(model){
        self.dateLB.text=model.create_time;//@"2019-6-12 12:23";
        self.countLB.text=model.browse;//@"1.5w";
        //self.shoLB.text=@"嗨如意";
        CGFloat countLBW=[self.countLB.text kr_getWidthWithTextHeight:13 font:9];
        if(countLBW>80){
           countLBW=80;
        }
        self.countLB.sd_layout
        .rightSpaceToView(self, 12).centerYEqualToView(self.dateImgView).widthIs(countLBW).heightIs(13);
        self.hotImgView.sd_layout
        .rightSpaceToView(self.countLB, 5).centerYEqualToView(self.dateImgView).widthIs(10).heightIs(11);
        [self.playImgView setUrlImg:model.play_icon];
        [self.headImgView setUrlImg:model.thumbnail];
        [self.dateImgView setUrlImg:model.time_icon];
        [self.hotImgView setUrlImg:model.browse_icon];
    }
}

@end
