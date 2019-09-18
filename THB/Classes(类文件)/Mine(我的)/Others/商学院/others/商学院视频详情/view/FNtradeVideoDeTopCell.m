//
//  FNtradeVideoDeTopCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNtradeVideoDeTopCell.h"

@implementation FNtradeVideoDeTopCell
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
    
    self.shoImgView=[[UIImageView alloc]init];
    [self addSubview:self.shoImgView];
    
    self.shoLB=[[UILabel alloc]init];
    [self addSubview:self.shoLB];
    
    self.bottomView=[[UIView alloc]init];
    [self addSubview:self.bottomView];
    
    self.typeImgView=[[UIImageView alloc]init];
    [self.bottomView addSubview:self.typeImgView];
    
    self.nameLB=[[UILabel alloc]init];
    [self.bottomView addSubview:self.nameLB];
    
    self.countLB=[[UILabel alloc]init];
    [self.bottomView addSubview:self.countLB];
    
    self.hotImgView=[[UIImageView alloc]init];
    [self.bottomView addSubview:self.hotImgView];
    
    self.titleLB=[[UILabel alloc]init];
    [self.bottomView addSubview:self.titleLB];
    
    self.dateLB=[[UILabel alloc]init];
    [self.bottomView addSubview:self.dateLB];
    
    self.shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.bottomView addSubview:self.shareBtn];
    self.shareBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    self.shareBtn.titleLabel.textAlignment=NSTextAlignmentRight;
    [self.shareBtn setTitleColor:RGB(45, 45, 52) forState:UIControlStateNormal];
    
    self.likeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.bottomView addSubview:self.likeBtn];
    self.likeBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    self.likeBtn.titleLabel.textAlignment=NSTextAlignmentRight;
    [self.likeBtn setTitleColor:RGB(45, 45, 52) forState:UIControlStateNormal];
    
    
    self.playBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.playBtn];
    [self.playBtn setImage:IMAGE(@"FN_TrAplayimg") forState:UIControlStateNormal];
    self.headImgView.cornerRadius=5;
    self.headImgView.clipsToBounds = YES;
    self.headImgView.backgroundColor=RGB(250, 250, 250); 
    self.shoImgView.backgroundColor=[UIColor whiteColor];
    self.shoLB.font=[UIFont systemFontOfSize:12];
    self.shoLB.textColor=[UIColor lightGrayColor];
    self.shoLB.textAlignment=NSTextAlignmentLeft;
   
    self.typeImgView.backgroundColor=RGB(250, 250, 250);
    self.hotImgView.backgroundColor=RGB(250, 250, 250);
    
    self.nameLB.font=[UIFont systemFontOfSize:15];
    self.nameLB.textColor=RGB(28, 28, 28);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.titleLB.font=[UIFont systemFontOfSize:12];
    self.titleLB.textColor=RGB(23, 22, 26);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.dateLB.font=[UIFont systemFontOfSize:9];
    self.dateLB.textColor=RGB(27, 28, 36);
    self.dateLB.textAlignment=NSTextAlignmentLeft;
    
    self.countLB.font=[UIFont systemFontOfSize:9];
    self.countLB.textColor=RGB(28, 28, 28);
    self.countLB.textAlignment=NSTextAlignmentRight;
    
    self.bottomView.sd_layout
    .leftSpaceToView(self, 0).bottomSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(100);
    
    self.typeImgView.sd_layout
    .leftSpaceToView(self.bottomView, 24).topSpaceToView(self.bottomView, 5).widthIs(35).heightIs(19);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.typeImgView, 10).centerYEqualToView(self.typeImgView).heightIs(20);
    
    self.countLB.sd_layout
    .rightSpaceToView(self.bottomView, 12).bottomEqualToView(self.typeImgView).widthIs(30).heightIs(13);
    
    self.hotImgView.sd_layout
    .rightSpaceToView(self.countLB, 5).centerYEqualToView(self.countLB).widthIs(10).heightIs(11);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self.bottomView, 25).topSpaceToView(self.typeImgView, 17).rightSpaceToView(self.bottomView, 25).heightIs(16);
    
    self.dateLB.sd_layout
    .leftSpaceToView(self.bottomView, 25).topSpaceToView(self.titleLB, 3).rightSpaceToView(self.bottomView, 25).heightIs(13);
    
    self.shareBtn.sd_layout
    .rightSpaceToView(self.bottomView, 12).bottomSpaceToView(self.bottomView, 12).widthIs(45).heightIs(15);
    
    self.likeBtn.sd_layout
    .rightSpaceToView(self.shareBtn, 15).bottomSpaceToView(self.bottomView, 12).widthIs(45).heightIs(15);
    self.shoLB.text=@"嗨如意省钱";
    self.nameLB.text=@"如何在嗨如意省钱赚钱";
    self.titleLB.text=@"嗨如意讲师";
    self.countLB.text=@"1.5w";
    self.dateLB.text=@"2019-3-30  13:23:54";
    NSString *shareStr=@"105";
    NSString *likeStr=@"82";
    [self.shareBtn setTitle:@"105" forState:UIControlStateNormal];
    [self.likeBtn setTitle:@"82" forState:UIControlStateNormal];
    [self.shareBtn setImage:IMAGE(@"FN_TrVfximg") forState:UIControlStateNormal];
    [self.likeBtn setImage:IMAGE(@"FN_TrVXHimg") forState:UIControlStateNormal];
    
    CGFloat countLBW=[self.countLB.text kr_getWidthWithTextHeight:13 font:9];
    if(countLBW>80){
        countLBW=80;
    }
    CGFloat likeBtnW=[likeStr kr_getWidthWithTextHeight:15 font:12];
    if(likeBtnW>90){
       likeBtnW=90;
    }
    CGFloat shareBtnW=[shareStr kr_getWidthWithTextHeight:15 font:12];
    if(shareBtnW>90){
       shareBtnW=90;
    }
    self.countLB.sd_layout
    .rightSpaceToView(self.bottomView, 12).bottomEqualToView(self.typeImgView).widthIs(countLBW).heightIs(13);
    
    self.hotImgView.sd_layout
    .rightSpaceToView(self.countLB, 5).centerYEqualToView(self.countLB).widthIs(10).heightIs(11);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.typeImgView, 10).centerYEqualToView(self.typeImgView).rightSpaceToView(self.hotImgView, 10).heightIs(20);
    
 
    self.shareBtn.sd_layout
    .rightSpaceToView(self.bottomView, 12).bottomSpaceToView(self.bottomView, 12).widthIs(shareBtnW+22).heightIs(15);
    
    self.shareBtn.titleLabel.sd_layout
    .rightSpaceToView(self.shareBtn, 2).heightIs(15).centerYEqualToView(self.shareBtn).widthIs(shareBtnW);
    
    self.shareBtn.imageView.sd_layout
    .leftSpaceToView(self.shareBtn, 0).rightSpaceToView(self.shareBtn.titleLabel, 5).widthIs(15).heightIs(15);
    
    self.likeBtn.sd_layout
    .rightSpaceToView(self.shareBtn, 15).bottomSpaceToView(self.bottomView, 12).widthIs(likeBtnW+22).heightIs(15);
    
    self.likeBtn.titleLabel.sd_layout
    .rightSpaceToView(self.likeBtn, 2).heightIs(15).centerYEqualToView(self.likeBtn).widthIs(likeBtnW);
    
    self.likeBtn.imageView.sd_layout
    .leftSpaceToView(self.likeBtn, 0).rightSpaceToView(self.likeBtn.titleLabel, 5).widthIs(15).heightIs(15);
    
    
    self.headImgView.sd_layout
    .leftSpaceToView(self, 25).topSpaceToView(self, 16).rightSpaceToView(self, 25).heightIs(170);
    
    self.shoImgView.sd_layout
    .leftSpaceToView(self, 37).topSpaceToView(self, 22).widthIs(20).heightIs(20);
    
    self.shoLB.sd_layout
    .leftSpaceToView(self.shoImgView, 5).centerYEqualToView(self.shoImgView).heightIs(12).rightSpaceToView(self, 35);
    
    self.playBtn.sd_layout
    .centerXEqualToView(self).topSpaceToView(self, 75).widthIs(50).heightIs(50);
}
@end
