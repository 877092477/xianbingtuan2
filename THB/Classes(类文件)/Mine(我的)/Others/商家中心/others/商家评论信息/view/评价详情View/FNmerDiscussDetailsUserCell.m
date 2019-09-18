//
//  FNmerDiscussDetailsUserCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/31.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerDiscussDetailsUserCell.h"

@implementation FNmerDiscussDetailsUserCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.headImgView=[[UIImageView alloc]init];
    [self addSubview:self.headImgView];
    
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    
    self.dateLB=[[UILabel alloc]init];
    [self addSubview:self.dateLB];
    
    self.nameLB.font=[UIFont systemFontOfSize:13];
    self.nameLB.textColor=RGB(51, 51, 51);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.dateLB.font=[UIFont systemFontOfSize:13];
    self.dateLB.textColor=RGB(153, 153, 153);
    self.dateLB.textAlignment=NSTextAlignmentLeft;
    
    self.headImgView.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self, 17).heightIs(41).widthIs(41);
    
    self.headImgView.cornerRadius=41/2;
    self.headImgView.clipsToBounds = YES;
    
    self.nameLB.sd_layout
    .leftSpaceToView(self, 67).heightIs(16).topSpaceToView(self, 15).widthIs(120);
    
    self.dateLB.sd_layout
    .leftSpaceToView(self, 67).heightIs(14).topSpaceToView(self.nameLB, 9).widthIs(120);
    
}

-(void)setModel:(FNmerchentReviewModel *)model{
    _model=model;
    if(model){
        [self.headImgView setUrlImg:model.head_img];
        self.nameLB.text=model.username;
        self.dateLB.text=model.time;
    }
}
@end
