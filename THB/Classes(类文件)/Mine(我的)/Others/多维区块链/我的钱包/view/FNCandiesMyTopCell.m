//
//  FNCandiesMyTopCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNCandiesMyTopCell.h"

@implementation FNCandiesMyTopCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    self.bgImgView=[[UIImageView alloc]init];
    [self addSubview:self.bgImgView];
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.priceLB=[[UILabel alloc]init];
    [self addSubview:self.priceLB];
    
    self.hintLB=[[UILabel alloc]init];
    [self addSubview:self.hintLB];
    
    self.comeUponLB=[[UILabel alloc]init];
    [self addSubview:self.comeUponLB];
    
    self.unitLB=[[UILabel alloc]init];
    [self addSubview:self.unitLB];
    
    self.comeUponLB.font=[UIFont systemFontOfSize:18];
    self.comeUponLB.textColor=[UIColor whiteColor];
    self.comeUponLB.textAlignment=NSTextAlignmentLeft;
    
    self.unitLB.font=[UIFont systemFontOfSize:12];
    self.unitLB.textColor=[UIColor whiteColor];
    self.unitLB.textAlignment=NSTextAlignmentLeft;
    
    self.titleLB.font=[UIFont systemFontOfSize:15];
    self.titleLB.textColor=RGB(51, 51, 51);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.hintLB.font=[UIFont systemFontOfSize:10];
    self.hintLB.textColor=RGB(51, 51, 51);
    self.hintLB.textAlignment=NSTextAlignmentLeft;
    
    self.priceLB.font=[UIFont systemFontOfSize:44];
    self.priceLB.textColor=RGB(51, 51, 51);
    self.priceLB.textAlignment=NSTextAlignmentLeft;
    
    self.incomeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.incomeBtn];
    
    self.convertBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.convertBtn];
    
    [self.incomeBtn setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    [self.convertBtn setTitleColor:RGB(116, 93, 250) forState:UIControlStateNormal];
    self.incomeBtn.titleLabel.textAlignment=NSTextAlignmentRight;
    self.incomeBtn.titleLabel.font=kFONT10;
    self.convertBtn.titleLabel.font=kFONT14;
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    self.incomeBtn.sd_layout
    .rightSpaceToView(self, 20).topSpaceToView(self, 20).heightIs(18).widthIs(60);
    
    //self.incomeBtn.imageView.sd_layout
    //.centerYEqualToView(self.incomeBtn).widthIs(10).heightIs(10).rightSpaceToView(self.incomeBtn, 0);
    
    //self.incomeBtn.titleLabel.sd_layout
    //.centerYEqualToView(self.incomeBtn).leftSpaceToView(self.incomeBtn, 0).heightIs(20).rightSpaceToView(self.incomeBtn, 16);
    self.incomeBtn.imageView.sd_layout
    .leftSpaceToView(self.incomeBtn, 0).topSpaceToView(self.incomeBtn, 0).rightSpaceToView(self.incomeBtn, 0).bottomSpaceToView(self.incomeBtn, 0);
    
    self.convertBtn.sd_layout
    .rightSpaceToView(self, 20).topSpaceToView(self, 57).heightIs(25).widthIs(80);
    
    self.convertBtn.imageView.sd_layout
    .leftSpaceToView(self.convertBtn, 0).topSpaceToView(self.convertBtn, 0).rightSpaceToView(self.convertBtn, 0).bottomSpaceToView(self.convertBtn, 0);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 20).topSpaceToView(self, 17).heightIs(19).rightSpaceToView(self.incomeBtn, 10);
    
    self.priceLB.sd_layout
    .leftSpaceToView(self, 20).topSpaceToView(self.titleLB, 11).heightIs(50).rightSpaceToView(self.convertBtn, 10);
    
    self.hintLB.sd_layout
    .leftSpaceToView(self, 20).topSpaceToView(self.priceLB, 10).heightIs(13).rightSpaceToView(self, 30);
    
    self.unitLB.sd_layout
    .leftSpaceToView(self, 20).widthIs(150).heightIs(16).bottomSpaceToView(self, 5);
    
    self.comeUponLB.sd_layout
    .leftSpaceToView(self, 20).widthIs(150).heightIs(22).bottomSpaceToView(self.unitLB, 0);
    
//    self.titleLB.text=@"我的糖果";
//    self.priceLB.text=@"6,965";
//    self.hintLB.text=@"(账户里有10个糖果以上，超出的部分，才可以进行转让和交易)"; 
//    [self.incomeBtn setTitle:@"收支明细" forState:UIControlStateNormal];
//    [self.convertBtn setTitle:@"兑换任务" forState:UIControlStateNormal];
    self.convertBtn.cornerRadius=25/2;
    self.bgImgView.cornerRadius=5/2;
}

-(void)setModel:(FNCandiesMyModel *)model{
    _model=model;
    if(model){
        [self.bgImgView setUrlImg:model.dwqkb_top_bj];
        self.titleLB.text=model.dwqkb_wode_str;
        self.priceLB.text=model.qkb_counts;
        //self.hintLB.text=model.dwqkb_explain_str;
        self.comeUponLB.text=model.qkb_price;
        self.unitLB.text=model.qkb_price_str;
        self.comeUponLB.textColor=[UIColor colorWithHexString:model.dwqkb_top_color];
        self.unitLB.textColor=[UIColor colorWithHexString:model.dwqkb_top_color];
        self.titleLB.textColor=[UIColor colorWithHexString:model.dwqkb_top_color];
        self.priceLB.textColor=[UIColor colorWithHexString:model.dwqkb_top_color];
        //self.hintLB.textColor=[UIColor colorWithHexString:model.dwqkb_top_color];
        
        //[self.incomeBtn setTitle:model.dwqkb_explain_str forState:UIControlStateNormal];
        //[self.convertBtn setTitle:@"兑换任务" forState:UIControlStateNormal];
        [self.incomeBtn sd_setImageWithURL:URL(model.dwqkb_shouyi_btn) forState:UIControlStateNormal];
        self.incomeBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
        [self.convertBtn sd_setImageWithURL:URL(model.dwqkb_exchange_btn) forState:UIControlStateNormal];
        self.convertBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
        
    }
}
@end
