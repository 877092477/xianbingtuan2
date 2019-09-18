//
//  FNmerMembersHeadView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/16.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerMembersHeadView.h"

@implementation FNmerMembersHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.bgView=[[UIView alloc]init];
    [self addSubview:self.bgView];
    
    self.lineView=[[UIView alloc]init];
    [self addSubview:self.lineView];
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.rightTextLB=[[UILabel alloc]init];
    [self addSubview:self.rightTextLB];
    
    self.rightImg=[[UIImageView alloc]init];
    [self addSubview:self.rightImg];
    
    self.lucencyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.lucencyBtn];
    self.lucencyBtn.backgroundColor=[UIColor clearColor];
    [self.lucencyBtn addTarget:self action:@selector(lucencyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.bgView.backgroundColor=[UIColor whiteColor];
    self.bgView.cornerRadius=5;
    self.lineView.backgroundColor=RGB(251, 135, 77);
    
    self.titleLB.font=[UIFont systemFontOfSize:14];
    self.titleLB.textColor=RGB(24, 24, 24);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.rightTextLB.font=[UIFont systemFontOfSize:12];
    self.rightTextLB.textColor=RGB(140, 140, 140);
    self.rightTextLB.textAlignment=NSTextAlignmentRight;
    
    self.bgView.sd_layout
    .leftSpaceToView(self, 10).rightSpaceToView(self, 10).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 33).rightSpaceToView(self, 120).centerYEqualToView(self).heightIs(20);
    
    self.lineView.sd_layout
    .leftSpaceToView(self, 20).centerYEqualToView(self).widthIs(2).heightIs(15);
    
    self.rightTextLB.sd_layout
    .rightSpaceToView(self, 35).centerYEqualToView(self).heightIs(20).widthIs(85);
    
    self.rightImg.sd_layout
    .centerYEqualToView(self).rightSpaceToView(self, 20).widthIs(5).heightIs(9);
    
    self.lucencyBtn.sd_layout
    .leftSpaceToView(self, 10).rightSpaceToView(self, 10).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
}
-(void)lucencyBtnClick:(UIButton*)btn{ 
        if ([self.delegate respondsToSelector:@selector(didMerHeaderLucencySeletedClickIndex:)]) {
            [self.delegate didMerHeaderLucencySeletedClickIndex:self.index];
        }
    
}
-(void)setModel:(FNmerMembersModel *)model{
    _model=model;
    if(model){
        self.titleLB.text=model.name;
        self.rightTextLB.text=model.hint;
        self.rightImg.image=IMAGE(model.img);
    }
}
@end
