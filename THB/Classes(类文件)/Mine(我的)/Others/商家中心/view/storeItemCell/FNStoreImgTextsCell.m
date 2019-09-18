//
//  FNStoreImgTextsCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNStoreImgTextsCell.h"

@implementation FNStoreImgTextsCell
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
    
    self.lineView=[[UIView alloc]init];
    [self addSubview:self.lineView];
    
    self.nameLB.font=[UIFont systemFontOfSize:15];
    self.nameLB.textColor=RGB(24, 24, 24);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    self.bgImgView.cornerRadius=5;
    self.bgImgView.clipsToBounds = YES;
    
    self.verticalView.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self, 15).widthIs(2).heightIs(15);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.verticalView, 10).centerYEqualToView(self.verticalView).widthIs(150).heightIs(20);
    
    self.lineView.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 44).rightSpaceToView(self, 0).heightIs(1);
    
    self.listView=[[FNmeStoreImgTextView alloc]initWithFrame:CGRectMake(0, 45, FNDeviceWidth-20, 10)];
    [self addSubview:self.listView];
    self.listView.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 45).bottomSpaceToView(self, 0);
}

-(void)setModel:(FNMerchantMeModel *)model{
    _model=model;
    if(model){
        [self.bgImgView setUrlImg:model.img];
        self.verticalView.backgroundColor=[UIColor colorWithHexString:model.left_line_color];
        self.lineView.backgroundColor=RGB(232, 232, 232);
        self.nameLB.text=model.name;
        self.nameLB.textColor=[UIColor colorWithHexString:model.name_color];
        
        self.listView.sd_layout
        .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 45).bottomSpaceToView(self, 0);
        
        self.listView.model=model;
    }
}
@end
