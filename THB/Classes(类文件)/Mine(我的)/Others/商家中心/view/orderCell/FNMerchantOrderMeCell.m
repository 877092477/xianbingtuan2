//
//  FNMerchantOrderMeCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNMerchantOrderMeCell.h"

@implementation FNMerchantOrderMeCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.bgImgView=[[UIImageView alloc]init];
    [self addSubview:self.bgImgView];
    
    self.verticalView=[[UIView alloc]init];
    [self addSubview:self.verticalView];
    
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    
    self.moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.moreBtn];
    
    self.lineView=[[UIView alloc]init];
    [self addSubview:self.lineView];
    
    self.nameLB.font=[UIFont systemFontOfSize:15];
    self.nameLB.textColor=RGB(24, 24, 24);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.moreBtn.titleLabel.font=kFONT12;
    [self.moreBtn setTitleColor:RGB(140, 140, 140) forState:UIControlStateNormal];
    self.moreBtn.titleLabel.textAlignment=NSTextAlignmentRight;
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    self.bgImgView.cornerRadius=5;
    self.bgImgView.clipsToBounds = YES;
    
    self.verticalView.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self, 15).widthIs(2).heightIs(15);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.verticalView, 10).centerYEqualToView(self.verticalView).widthIs(150).heightIs(20);
    
    self.moreBtn.sd_layout
    .rightSpaceToView(self, 5).centerYEqualToView(self.verticalView).heightIs(20).widthIs(75);
    
//    self.moreBtn.imageView.sd_layout
//    .rightSpaceToView(self.moreBtn, 15).widthIs(5).heightIs(9).centerYEqualToView(self.moreBtn);
//    
    self.moreBtn.titleLabel.sd_layout
    .leftSpaceToView(self.moreBtn, 5).rightSpaceToView(self.moreBtn, 5).heightIs(15).centerYEqualToView(self.moreBtn);
    
    self.lineView.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 45).rightSpaceToView(self, 0).heightIs(1);
    
    self.listView=[[FNmerchantOrderListView alloc]initWithFrame:CGRectMake(0, 46, FNDeviceWidth-20, 10)];
    [self addSubview:self.listView];
    
    
}

-(void)setModel:(FNMerchantMeModel *)model{
    _model=model;
    if(model){
        [self.bgImgView setUrlImg:model.img];
        self.verticalView.backgroundColor=[UIColor colorWithHexString:model.left_line_color];
        self.lineView.backgroundColor=RGB(232, 232, 232);
        self.nameLB.text=model.name;
        self.nameLB.textColor=[UIColor colorWithHexString:model.name_color];
        self.listView.model=model;
        NSArray *listArr=model.list;
        CGFloat listItemHeight=0;
        CGFloat listHeight=0;
        if([model.type isEqualToString:@"store_order"]){
            listItemHeight=60;
            listHeight=listItemHeight*listArr.count;
            [self.moreBtn setTitle:model.more_btn forState:UIControlStateNormal];
            [self.moreBtn setTitleColor:[UIColor colorWithHexString:model.more_btn_color] forState:UIControlStateNormal];
        }else if([model.type isEqualToString:@"store_yjkb"]){
            listItemHeight=100;
            CGFloat row=listArr.count;
            CGFloat coFloat=row/2;
            CGFloat secInt=ceil(coFloat);
            listHeight=listItemHeight*secInt;
        }
        self.listView.frame=CGRectMake(0, 46, FNDeviceWidth-20, listHeight);
    }
}
@end
