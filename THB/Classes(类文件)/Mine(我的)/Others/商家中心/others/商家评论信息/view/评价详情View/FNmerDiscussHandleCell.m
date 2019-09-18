//
//  FNmerDiscussHandleCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/31.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerDiscussHandleCell.h"

@implementation FNmerDiscussHandleCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.likeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.likeBtn];
    
    self.reviewBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.reviewBtn];
    
    self.queryBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.queryBtn];
    
    [self.likeBtn setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    self.likeBtn.titleLabel.font=kFONT11;
    
    [self.reviewBtn setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    self.reviewBtn.titleLabel.font=kFONT11;
    
    [self.queryBtn setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    self.queryBtn.titleLabel.font=kFONT11;
    
    self.likeBtn.sd_layout
    .rightSpaceToView(self, 15).widthIs(70).heightIs(28).bottomSpaceToView(self, 12);
    self.likeBtn.imageView.sd_layout
    .widthIs(14).heightIs(14).centerYEqualToView(self.likeBtn).rightSpaceToView(self.likeBtn.titleLabel, 5);
    
    self.reviewBtn.sd_layout
    .leftSpaceToView(self, 64).heightIs(28).bottomSpaceToView(self, 12).widthIs(95);
    self.reviewBtn.titleLabel.sd_layout
    .rightSpaceToView(self.reviewBtn, 0).centerYEqualToView(self.reviewBtn).heightIs(20).leftSpaceToView(self.reviewBtn, 0);
    self.reviewBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    
    self.queryBtn.sd_layout
    .rightSpaceToView(self.likeBtn, 12).heightIs(28).bottomSpaceToView(self, 12).widthIs(70);
    self.queryBtn.imageView.sd_layout
    .widthIs(14).heightIs(14).centerYEqualToView(self.queryBtn).rightSpaceToView(self.queryBtn.titleLabel, 5);
    
    [self.likeBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:6];
    [self.queryBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:6];
    
    self.lineTwoView=[[UIView alloc]init];
    [self addSubview:self.lineTwoView];
    
//    self.lineOneView=[[UIView alloc]init];
//    [self addSubview:self.lineOneView];
//
//    self.likeImgView=[[UIImageView alloc]init];
//    [self addSubview:self.likeImgView];
    
    
//    self.titleLB=[[UILabel alloc]init];
//    [self addSubview:self.titleLB];
//
//    self.titleLB.font=[UIFont systemFontOfSize:11];
//    self.titleLB.textColor=RGB(140, 140, 140);
//    self.titleLB.textAlignment=NSTextAlignmentRight;
//
//    self.likeImgView.sd_layout
//    .leftSpaceToView(self, 10).widthIs(13).heightIs(13).bottomSpaceToView(self, 15);
//    self.lineOneView.sd_layout
//    .leftSpaceToView(self, 10).rightSpaceToView(self, 10).bottomSpaceToView(self, 38).heightIs(1);
    self.lineTwoView.sd_layout
    .leftSpaceToView(self, 10).rightSpaceToView(self, 10).bottomSpaceToView(self, 0).heightIs(1);
//    self.titleLB.sd_layout
//    .rightSpaceToView(self, 10).centerYEqualToView(self.likeImgView).heightIs(15).widthIs(80);
    
//    self.gradeView=[[FNmerGradeView alloc]init];
//    self.gradeView.frame=CGRectMake(34, 50, 70, 15);
//    self.gradeView.isBead=YES;
//    [self addSubview:self.gradeView];
//
//    self.gradeView.sd_resetLayout
//    .leftSpaceToView(self, 35).heightIs(15).centerYEqualToView(self.likeImgView).widthIs(70);
//
//    self.omitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [self addSubview:self.omitBtn];
//
//    self.omitBtn.sd_layout
//    .leftSpaceToView(self.gradeView, 5).widthIs(15).heightIs(15).centerYEqualToView(self.likeImgView);
    
}
-(void)setModel:(FNmerchentReviewModel *)model{
    _model=model;
    if(model){
        [self.likeBtn sd_setImageWithURL:URL(model.vote_img) forState:UIControlStateNormal];
        [self.queryBtn sd_setImageWithURL:URL(model.doubt_img) forState:UIControlStateNormal];
        
        [self.likeBtn setTitle:[NSString stringWithFormat:@"%@",model.vote] forState:UIControlStateNormal]; 
        [self.queryBtn setTitle:model.doubt forState:UIControlStateNormal];
//        if([model.has_vote integerValue]==0){
//            [self.likeBtn sd_setImageWithURL:URL(model.vote_img) forState:UIControlStateNormal];
//            [self.likeBtn setTitleColor:[UIColor colorWithHexString:model.vote_color] forState:UIControlStateNormal];
//        }
//        if([model.has_vote integerValue]==1){
//            [self.likeBtn sd_setImageWithURL:URL(model.vote_img1) forState:UIControlStateNormal];
//            [self.likeBtn setTitleColor:[UIColor colorWithHexString:model.vote_color1] forState:UIControlStateNormal];
//        }
        [self.likeBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:6];
        [self.queryBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:6];
        
//        [self.likeImgView setUrlImg:model.vote_img];
        
//        self.titleLB.text=[NSString stringWithFormat:@"%@人点赞",model.vote];
        
//        NSInteger starInt=model.vote_user_img.count;
//        CGFloat maxWidth=FNDeviceWidth-90-20-30;
//        CGFloat gradeWidth=starInt*20;
//        if(gradeWidth>maxWidth){
//           gradeWidth=maxWidth;
//        }
//        if(model.vote_user_img.count>0){
//            self.gradeView.imgArr=model.vote_user_img;
//            self.gradeView.itemGap=5;
//            self.gradeView.sd_resetLayout
//            .leftSpaceToView(self, 35).heightIs(15).centerYEqualToView(self.likeImgView).widthIs(gradeWidth);
//            self.omitBtn.sd_resetLayout
//            .leftSpaceToView(self.gradeView, 5).widthIs(15).heightIs(15).centerYEqualToView(self.likeImgView);
//            [self.omitBtn setImage:IMAGE(@"FN_merOmitDimg") forState:UIControlStateNormal];
//        }
        
        self.likeBtn.borderWidth=1;
        self.likeBtn.borderColor = RGB(216, 216, 216);
        self.likeBtn.cornerRadius=28/2;
        self.likeBtn.clipsToBounds = YES; 
        
        self.queryBtn.borderWidth=1;
        self.queryBtn.borderColor = RGB(216, 216, 216);
        self.queryBtn.cornerRadius=28/2;
        self.queryBtn.clipsToBounds = YES;
        
        self.lineOneView.backgroundColor=RGB(232, 232, 232);
        self.lineTwoView.backgroundColor=RGB(232, 232, 232);
    }
}
@end
