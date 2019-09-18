//
//  FNmerConSeekGoodsItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerConSeekGoodsItemCell.h"

@implementation FNmerConSeekGoodsItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.bgView=[[UIView alloc]init];
    [self addSubview:self.bgView];
    
    self.headImgView=[[UIImageView alloc]init];
    [self.bgView addSubview:self.headImgView];
    
    self.nameLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.nameLB];
    
    self.sumLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.sumLB];
    
    self.countLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.countLB];
    
    self.msgLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.msgLB];
    
    self.bgView.backgroundColor=[UIColor whiteColor];
    
    self.nameLB.font=[UIFont systemFontOfSize:13];
    self.nameLB.textColor=RGB(60, 60, 60);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.sumLB.font=[UIFont systemFontOfSize:12];
    self.sumLB.textColor=RGB(24, 24, 24);
    self.sumLB.textAlignment=NSTextAlignmentRight;
    
    self.countLB.font=[UIFont systemFontOfSize:12];
    self.countLB.textColor=RGB(24, 24, 24);
    self.countLB.textAlignment=NSTextAlignmentRight;
    
    self.msgLB.font=[UIFont systemFontOfSize:10];
    self.msgLB.textColor=RGB(153, 153, 153);
    self.msgLB.textAlignment=NSTextAlignmentLeft;
    //self.msgLB.backgroundColor=RGB(255, 190, 190);
    
    self.bgView.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self, 0).rightSpaceToView(self, 10).bottomSpaceToView(self, 0);
    
    self.headImgView.sd_layout
    .leftSpaceToView(self.bgView, 10).centerYEqualToView(self.bgView).heightIs(26).widthIs(29);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.headImgView, 10).topEqualToView(self.headImgView).widthIs(150).heightIs(14);
    
    self.sumLB.sd_layout
    .rightSpaceToView(self.bgView, 10).centerYEqualToView(self.bgView).widthIs(80).heightIs(16);
    
    self.countLB.sd_layout
    .rightSpaceToView(self.sumLB, 5).centerYEqualToView(self.sumLB).widthIs(60).heightIs(16);
    
    self.msgLB.sd_layout
    .leftSpaceToView(self.headImgView, 10).bottomEqualToView(self.headImgView).widthIs(100).heightIs(12);
    
}

-(void)setModel:(FNmerConsumeGoodsItemModel *)model{
    _model=model;
    if(model){
        [self.headImgView setUrlImg:model.goods_img];
        self.nameLB.text=model.goods_title;
        self.sumLB.text=model.sum;
        self.countLB.text=model.count;
        self.msgLB.text=model.tips;
    }
}
@end
