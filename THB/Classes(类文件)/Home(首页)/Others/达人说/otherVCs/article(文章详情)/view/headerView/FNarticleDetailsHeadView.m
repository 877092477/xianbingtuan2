//
//  FNarticleDetailsHeadView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNarticleDetailsHeadView.h"

@implementation FNarticleDetailsHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews{
    self.backgroundColor=RGB(250, 250, 250);
    self.topbgImgView=[[UIImageView alloc]init];
    self.topDimImgView=[[UIImageView alloc]init];
    self.titleLB=[[UILabel alloc]init];
    self.headImg=[[UIImageView alloc]init];
    self.nameLB=[[UILabel alloc]init];
    //self.dateLB=[[UILabel alloc]init];
    self.checkLB=[[UILabel alloc]init];
    self.shorttitleLB=[[UILabel alloc]init];
    
    self.likeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.topbgImgView];
    [self addSubview:self.topDimImgView];
    [self addSubview:self.titleLB];
    [self addSubview:self.headImg];
    [self addSubview:self.nameLB];
    //[self addSubview:self.dateLB];
    [self addSubview:self.checkLB];
    [self addSubview:self.shorttitleLB];
    [self addSubview:self.likeBtn];
    
    self.headImg.cornerRadius=40/2;
    self.titleLB.numberOfLines=2;
    self.titleLB.font=[UIFont systemFontOfSize:18];
    self.titleLB.textColor=RGB(51, 51, 51);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.nameLB.font=kFONT14;
    self.nameLB.textColor=RGB(51, 51, 51);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    //self.dateLB.font=kFONT12;
    //self.dateLB.textColor=RGB(153, 153, 153);
    //self.dateLB.textAlignment=NSTextAlignmentRight;
    
    self.checkLB.font=kFONT12;
    self.checkLB.textColor=RGB(153, 153, 153);
    self.checkLB.textAlignment=NSTextAlignmentRight;
    
    self.shorttitleLB.font=kFONT11;
    self.shorttitleLB.textColor=RGB(251, 155, 31);
    self.shorttitleLB.textAlignment=NSTextAlignmentLeft;
    
    self.likeBtn.titleLabel.font=kFONT14;
    [self.likeBtn setTitleColor:RGB(251, 155, 31) forState:UIControlStateNormal];
    
    self.topbgImgView.contentMode=UIViewContentModeScaleToFill;
    self.topbgImgView.clipsToBounds=YES;
    
    [self incomposition];
}

-(void)incomposition{
    self.topbgImgView.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(125);
    self.topDimImgView.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(125);
    self.titleLB.sd_layout
    .leftSpaceToView(self, 12).topSpaceToView(self.topbgImgView, 19).rightSpaceToView(self, 100).heightIs(23);
    self.headImg.sd_layout
    .leftSpaceToView(self, 12).topSpaceToView(self.topbgImgView, 65).heightIs(40).widthIs(40);
    self.nameLB.sd_layout
    .leftSpaceToView(self.headImg, 12).rightSpaceToView(self, 12).topSpaceToView(self.topbgImgView, 67).heightIs(18);
    
    //self.dateLB.sd_layout
    //.leftSpaceToView(self.headImg, 80).topSpaceToView(self.topbgImgView, 69).heightIs(18).widthIs(70);
    
    self.checkLB.sd_layout
    .rightSpaceToView(self, 12).heightIs(15).topSpaceToView(self.topbgImgView, 50).widthIs(100);
    
    self.likeBtn.sd_layout
    .rightSpaceToView(self, 12).heightIs(15).widthIs(90).bottomSpaceToView(self.checkLB, 9);
    
    self.shorttitleLB.sd_layout
    .leftSpaceToView(self.headImg, 12).bottomEqualToView(self.headImg).rightSpaceToView(self, 12).heightIs(15);
    
}

-(void)setModel:(FNArticleDeailsXModel *)model{
    _model=model;
    if(model){
        [self.topbgImgView setUrlImg:model.banner];
        self.topDimImgView.image=IMAGE(@"FN_mengCeng_WZimg");
        [self.headImg setUrlImg:model.head_img];
        self.titleLB.text=[NSString stringWithFormat:@"%@",model.title];
        
        self.titleLB.textColor=[UIColor colorWithHexString:model.title_color];
        
        self.nameLB.textColor=[UIColor colorWithHexString:model.author_color];
        
        self.checkLB.textColor=[UIColor colorWithHexString:model.visit_color]; 
        
        self.shorttitleLB.text=model.shorttitle;
        NSString *jointStr=[NSString stringWithFormat:@"%@人阅读",model.readtimes];
        self.checkLB.text=jointStr;
        //if([model.label kr_isNotEmpty]){
        //   [self.checkLB fn_changeColorWithTextColor:RGB(251, 155, 31) changeText:model.label];
        //}
         NSString *jointNameStr=[NSString stringWithFormat:@"%@  %@",model.talent_name,model.time];
        self.nameLB.text=jointNameStr;
        if([model.time kr_isNotEmpty]){
           [self.nameLB fn_changeColorWithTextColor:RGB(153, 153, 153) changeText:model.time];
           [self.nameLB fn_changeFontWithTextFont:kFONT12 changeText:model.time];
        }
        
        self.shorttitleLB.text=model.label;
        
        CGFloat likeBtnW=[model.followtimes kr_getWidthWithTextHeight:20 font:14];
        if(likeBtnW>65){
            likeBtnW=65;
        }
        CGFloat likeZoonW=likeBtnW+10+20;
        
        [self.likeBtn setImage:IMAGE(@"FN_dr_dz_img") forState:UIControlStateNormal];
        [self.likeBtn setTitle:model.followtimes forState:UIControlStateNormal];
        
        self.titleLB.sd_layout
        .leftSpaceToView(self, 12).topSpaceToView(self.topbgImgView, 19).rightSpaceToView(self, likeZoonW+20).heightIs(23);
        
        self.likeBtn.sd_layout
        .rightSpaceToView(self, 12).bottomSpaceToView(self.checkLB, 9).heightIs(15).widthIs(likeZoonW);
        self.likeBtn.imageView.sd_layout
        .centerYEqualToView(self.likeBtn).leftSpaceToView(self.likeBtn, 0).heightIs(14).widthIs(14);
        self.likeBtn.titleLabel.sd_layout
        .centerYEqualToView(self.likeBtn).leftSpaceToView(self.likeBtn.imageView, 5).heightIs(20).rightSpaceToView(self.likeBtn, 2);
 
    }
}
@end
