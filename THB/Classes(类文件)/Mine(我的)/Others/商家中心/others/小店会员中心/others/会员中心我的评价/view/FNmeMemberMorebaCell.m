//
//  FNmeMemberMorebaCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/21.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmeMemberMorebaCell.h"

@implementation FNmeMemberMorebaCell
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
    
    self.rightImgView=[[UIImageView alloc]init];
    [self.bgView addSubview:self.rightImgView];
    
    self.nameLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.nameLB];
    
    self.hintLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.hintLB];
    
    self.bgBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.bgBtn];
    
    self.bgView.backgroundColor=RGB(246, 246, 246);
    
    self.nameLB.font=[UIFont systemFontOfSize:15];
    self.nameLB.textColor=RGB(51, 51, 51);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.hintLB.font=[UIFont systemFontOfSize:13];
    self.hintLB.textColor=RGB(153, 153, 153);
    self.hintLB.textAlignment=NSTextAlignmentLeft;
    
    self.rightImgView.image=IMAGE(@"FJ_xY_img");
    
    self.bgView.sd_layout
    .leftSpaceToView(self, 64).rightSpaceToView(self, 15).heightIs(64);
    
    self.headImgView.sd_layout
    .leftSpaceToView(self.bgView, 9).centerYEqualToView(self.bgView).widthIs(47).heightIs(47);
    
    self.rightImgView.sd_layout
    .widthIs(8).heightIs(13).centerYEqualToView(self.bgView).rightSpaceToView(self.bgView, 9);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.headImgView, 9).topSpaceToView(self.bgView, 10).rightSpaceToView(self.rightImgView, 5).heightIs(19);
    
    self.hintLB.sd_layout
    .leftSpaceToView(self.headImgView, 9).topSpaceToView(self.nameLB, 7).rightSpaceToView(self.rightImgView, 5).heightIs(17);
    
    self.bgBtn.sd_layout
    .leftSpaceToView(self.bgView, 0).topSpaceToView(self.bgView, 0).rightSpaceToView(self.bgView, 0).bottomSpaceToView(self.bgView, 0);
    
    self.queryBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.queryBtn];
    
    self.likeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.likeBtn];
    
    self.moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.moreBtn];
    
    [self.likeBtn setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    self.likeBtn.titleLabel.font=kFONT11;
    
    [self.moreBtn setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    self.moreBtn.titleLabel.font=kFONT11;
    
    [self.queryBtn setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    self.queryBtn.titleLabel.font=kFONT11;
    
    self.queryBtn.sd_layout
    .leftSpaceToView(self, 64).heightIs(28).bottomSpaceToView(self, 10).widthIs(100);
    
    self.likeBtn.sd_layout
    .rightSpaceToView(self, 67).widthIs(70).heightIs(28).bottomSpaceToView(self, 10);
    self.likeBtn.imageView.sd_layout
    .widthIs(13).heightIs(13).centerYEqualToView(self.likeBtn).rightSpaceToView(self.likeBtn.titleLabel, 5);
    
    self.moreBtn.sd_layout
    .rightSpaceToView(self, 15).heightIs(28).bottomSpaceToView(self, 10).widthIs(40);
    
    [self.likeBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:4];
    
}

-(void)setModel:(FNmerchentReviewModel *)model{
    _model=model;
    if(model){
        [self.likeBtn sd_setImageWithURL:URL(model.vote_img) forState:UIControlStateNormal];
        //[self.queryBtn sd_setImageWithURL:URL(model.doubt_img) forState:UIControlStateNormal];
        
        [self.likeBtn setTitle:model.vote forState:UIControlStateNormal];
        //[self.queryBtn setTitle:model.doubt forState:UIControlStateNormal];
        
        CGFloat titleW=[model.vote kr_getWidthWithTextHeight:28 font:11];
        self.likeBtn.sd_resetLayout
        .rightSpaceToView(self, 67).widthIs(titleW+60).heightIs(28).bottomSpaceToView(self, 10);
        self.likeBtn.imageView.sd_resetLayout
        .widthIs(13).heightIs(13).centerYEqualToView(self.likeBtn).rightSpaceToView(self.likeBtn.titleLabel, 6);
        
        [self.likeBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:6];
        
        
        FNmeMeEvaluatesTabItemModel *storeModel=[FNmeMeEvaluatesTabItemModel mj_objectWithKeyValues:model.store];
        [self.headImgView setUrlImg:storeModel.img];
        self.nameLB.text=storeModel.name;
        self.hintLB.text=storeModel.str;
        
        
        self.likeBtn.cornerRadius=28/2;
        self.likeBtn.borderWidth=1;
        self.likeBtn.borderColor = RGB(233, 233, 233);
        self.likeBtn.clipsToBounds = YES;
        
        self.moreBtn.cornerRadius=28/2;
        self.moreBtn.borderWidth=1;
        self.moreBtn.borderColor = RGB(233, 233, 233);
        self.moreBtn.clipsToBounds = YES;
        [self.moreBtn setTitle:@"..." forState:UIControlStateNormal];
    }
}
@end
