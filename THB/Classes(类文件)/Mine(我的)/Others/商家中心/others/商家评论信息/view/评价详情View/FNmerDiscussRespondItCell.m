//
//  FNmerDiscussRespondItCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/31.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerDiscussRespondItCell.h"

@implementation FNmerDiscussRespondItCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.imgView=[[UIImageView alloc]init];
    [self addSubview:self.imgView];
    
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    
    self.dateLB=[[UILabel alloc]init];
    [self addSubview:self.dateLB];
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.titleLB.font=[UIFont systemFontOfSize:11];
    self.titleLB.textColor=RGB(24, 24, 24);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.nameLB.font=[UIFont systemFontOfSize:11];
    self.nameLB.textColor=RGB(24, 24, 24);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.dateLB.font=[UIFont systemFontOfSize:10];
    self.dateLB.textColor=RGB(140, 140, 140);
    self.dateLB.textAlignment=NSTextAlignmentRight;
    
    self.imgView.sd_layout
    .leftSpaceToView(self, 10).widthIs(13).heightIs(13).topSpaceToView(self, 8);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self, 34).rightSpaceToView(self, 115).centerYEqualToView(self.imgView).heightIs(16);
    
    self.dateLB.sd_layout
    .rightSpaceToView(self, 10).centerYEqualToView(self.imgView).widthIs(100).heightIs(12);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 34).rightSpaceToView(self, 23).topSpaceToView(self, 28).bottomSpaceToView(self, 10);
    
    //self.lineView=[[UIView alloc]init];
    //[self addSubview:self.lineView];
    //self.lineView.backgroundColor=RGB(232, 232, 232);
    //self.lineView.sd_layout
    //.leftSpaceToView(self, 10).rightSpaceToView(self, 10).bottomSpaceToView(self, 0).heightIs(1);
    
    
}
-(void)setModel:(FNmerchentReviewModel *)model{
    _model=model;
    if(model){
        self.nameLB.text=model.sub_comment_str;
        self.dateLB.text=model.sub_comment_time;
        [self.imgView setUrlImg:model.sub_comment_icon];
        self.titleLB.text=model.sub_comment; 
    }
}
@end
