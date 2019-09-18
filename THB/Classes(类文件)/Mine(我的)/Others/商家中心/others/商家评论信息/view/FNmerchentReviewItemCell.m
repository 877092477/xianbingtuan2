//
//  FNmerchentReviewItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/10.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerchentReviewItemCell.h"

@implementation FNmerchentReviewItemCell
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
    
    self.pleasedLB=[[UILabel alloc]init];
    [self addSubview:self.pleasedLB];
    
    self.consumeLB=[[UILabel alloc]init];
    [self addSubview:self.consumeLB];
    
    self.reviewLB=[[UILabel alloc]init];
    [self addSubview:self.reviewLB];
    
    self.likeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.likeBtn];
    
    self.reviewBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.reviewBtn];
    
    self.queryBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.queryBtn];
    
    self.nameLB.font=[UIFont systemFontOfSize:14];
    self.nameLB.textColor=RGB(24, 24, 24);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.dateLB.font=[UIFont systemFontOfSize:13];
    self.dateLB.textColor=RGB(153, 153, 153);
    self.dateLB.textAlignment=NSTextAlignmentLeft;
    
    self.pleasedLB.font=[UIFont systemFontOfSize:13];
    self.pleasedLB.textColor=RGB(102, 102, 102);
    self.pleasedLB.textAlignment=NSTextAlignmentLeft;
    
    self.consumeLB.font=[UIFont systemFontOfSize:13];
    self.consumeLB.textColor=RGB(102, 102, 102);
    self.consumeLB.textAlignment=NSTextAlignmentLeft;
    
    self.reviewLB.font=[UIFont systemFontOfSize:12];
    self.reviewLB.textColor=RGB(60, 60, 60);
    self.reviewLB.textAlignment=NSTextAlignmentLeft;
    self.reviewLB.numberOfLines=0;
    
    [self.likeBtn setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    self.likeBtn.titleLabel.font=kFONT11;
    
    [self.reviewBtn setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    self.reviewBtn.titleLabel.font=kFONT11;
    
    [self.queryBtn setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    self.queryBtn.titleLabel.font=kFONT11;
    
    self.headImgView.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self, 17).heightIs(41).widthIs(41);
    
    self.headImgView.cornerRadius=41/2;
    self.headImgView.clipsToBounds = YES;
    
    self.nameLB.sd_layout
    .leftSpaceToView(self, 67).heightIs(16).topSpaceToView(self, 15).widthIs(120);
    
    self.dateLB.sd_layout
    .leftSpaceToView(self, 67).heightIs(14).topSpaceToView(self.nameLB, 9).widthIs(120);
    
    //self.pleasedLB.sd_layout
    //.rightSpaceToView(self, 10).centerYEqualToView(self.nameLB).widthIs(55).heightIs(15);
    
    self.pleasedLB.sd_layout
    .leftSpaceToView(self, 67).topSpaceToView(self.dateLB, 8).widthIs(35).heightIs(17);
    
    self.reviewLB.sd_layout
    .leftSpaceToView(self, 67).rightSpaceToView(self, 10).topSpaceToView(self.headImgView, 28).heightIs(70);
    
    
    self.reviewBtn.sd_layout
    .rightSpaceToView(self, 15).heightIs(28).bottomSpaceToView(self, 8).widthIs(70);
    //    self.reviewBtn.titleLabel.sd_layout
    //    .rightSpaceToView(self.reviewBtn, 0).centerYEqualToView(self.reviewBtn).heightIs(20).leftSpaceToView(self.reviewBtn, 0);
    //    self.reviewBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
        self.reviewBtn.imageView.sd_layout
        .centerYEqualToView(self.reviewBtn).centerXEqualToView(self.reviewBtn).widthIs(15).heightIs(15);
    
    //CGFloat btnWidth=(FNDeviceWidth-40)/3;
    //CGFloat btnTitleWidth=btnWidth/2;
    self.likeBtn.sd_layout
    .rightSpaceToView(self.reviewBtn, 12).widthIs(70).heightIs(28).bottomSpaceToView(self, 8);
    self.likeBtn.imageView.size=CGSizeMake(14, 14);
    self.likeBtn.imageView.sd_layout
    .widthIs(14).heightIs(14).centerYEqualToView(self.likeBtn).rightSpaceToView(self.likeBtn.titleLabel, 5);
    //.leftSpaceToView(self, 10).heightIs(40).bottomSpaceToView(self, 2).widthIs(btnWidth);
//    self.likeBtn.titleLabel.sd_layout
//    .rightSpaceToView(self.likeBtn, 0).centerYEqualToView(self.likeBtn).heightIs(20).widthIs(btnTitleWidth);
//    self.likeBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
//    self.likeBtn.imageView.sd_layout
//    .rightSpaceToView(self.likeBtn.titleLabel, 6).centerYEqualToView(self.likeBtn).widthIs(15).heightIs(15);
    
   
    
    self.queryBtn.sd_layout
    .rightSpaceToView(self.likeBtn, 12).heightIs(28).bottomSpaceToView(self, 8).widthIs(70);
    self.queryBtn.imageView.size=CGSizeMake(14, 14);
    self.queryBtn.imageView.sd_layout
    .widthIs(14).heightIs(14).centerYEqualToView(self.queryBtn).rightSpaceToView(self.queryBtn.titleLabel, 5);
    
//    self.queryBtn.titleLabel.sd_layout
//    .rightSpaceToView(self.queryBtn, 0).centerYEqualToView(self.queryBtn).heightIs(20).widthIs(btnTitleWidth);
//    self.queryBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
//    self.queryBtn.imageView.sd_layout
//    .rightSpaceToView(self.queryBtn.titleLabel, 6).centerYEqualToView(self.queryBtn).widthIs(15).heightIs(15);
    
    
    
    CGFloat itemHeight=(FNDeviceWidth-30)/3;
    self.imgListView=[[FNmerReviewPrintsView alloc]init];
    self.imgListView.frame=CGRectMake(10, 85, FNDeviceWidth-20, itemHeight);
    [self addSubview:self.imgListView];
    
    
    self.gradeView=[[FNmerGradeView alloc]init];
    self.gradeView.frame=CGRectMake(FNDeviceWidth-70, 10, 70, 15);
    [self addSubview:self.gradeView];
    
    self.gradeView.sd_layout
    .leftSpaceToView(self.pleasedLB, 5).heightIs(15).centerYEqualToView(self.pleasedLB).widthIs(70);
    //.rightSpaceToView(self.pleasedLB, 10).heightIs(15).centerYEqualToView(self.pleasedLB).widthIs(70);
    
    self.consumeLB.sd_layout
    .leftSpaceToView(self.gradeView, 13).centerYEqualToView(self.pleasedLB).heightIs(17).rightSpaceToView(self, 10);
    
    [self.likeBtn addTarget:self action:@selector(likeBtnAction)];
    [self.reviewBtn addTarget:self action:@selector(reviewBtnAction)];
    [self.queryBtn addTarget:self action:@selector(queryBtnAction)];
}
-(void)likeBtnAction{
    if ([self.delegate respondsToSelector:@selector(didMerLikeActionIsIndex:)]) {
        [self.delegate didMerLikeActionIsIndex:self.indexPa];
    }
}
-(void)reviewBtnAction{
    if ([self.delegate respondsToSelector:@selector(didMerReviewActionIsIndex:)]) {
        [self.delegate didMerReviewActionIsIndex:self.indexPa];
    }
}
-(void)queryBtnAction{
    if ([self.delegate respondsToSelector:@selector(didMerQueryActionIsIndex:)]) {
        [self.delegate didMerQueryActionIsIndex:self.indexPa];
    }
}
-(void)setModel:(FNmerchentReviewModel *)model{
    _model=model;
    if(model){
        if(model.imgs.count>0){
            CGFloat itemHeight=96;//(FNDeviceWidth-30)/3;
            CGFloat listHeight=0;
            CGFloat row=model.imgs.count;
            CGFloat coFloat=row/2;
            CGFloat secInt=ceil(coFloat);
            NSInteger lonRow=0;
            if(secInt>0){
               lonRow=secInt-1;
            }
            listHeight=itemHeight*secInt+2*lonRow;
            self.imgListView.sd_resetLayout
            .leftSpaceToView(self, 10).bottomSpaceToView(self, 44).rightSpaceToView(self, 10).heightIs(listHeight);
            //self.gradeView.model=model;
        }
        else{
            self.imgListView.sd_resetLayout
            .leftSpaceToView(self, 10).bottomSpaceToView(self, 44).rightSpaceToView(self, 10).heightIs(0);
        }
        self.imgListView.dataArr=model.imgs;
        self.likeBtn.borderWidth=1;
        self.likeBtn.borderColor = RGB(216, 216, 216);
        self.likeBtn.cornerRadius=28/2;
        self.likeBtn.clipsToBounds = YES;
        
        self.queryBtn.borderWidth=1;
        self.queryBtn.borderColor = RGB(216, 216, 216);
        self.queryBtn.cornerRadius=28/2;
        self.queryBtn.clipsToBounds = YES;
        
        self.reviewBtn.borderWidth=1;
        self.reviewBtn.borderColor = RGB(216, 216, 216);
        self.reviewBtn.cornerRadius=28/2;
        self.reviewBtn.clipsToBounds = YES;
            [self.headImgView setUrlImg:model.head_img];
            
            self.nameLB.text=model.username;
            self.dateLB.text=model.time;
            self.pleasedLB.text=@"评分:";//model.star_str;
            self.reviewLB.text=model.content;
            self.consumeLB.text=model.average_price;
            CGFloat textheight=0;
            CGFloat textWidth=FNDeviceWidth-77;
            if([model.content kr_isNotEmpty]){
                textheight=[model.content kr_heightWithMaxWidth:textWidth attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
            }
            self.reviewLB.sd_resetLayout
            .leftSpaceToView(self, 67).rightSpaceToView(self, 10).topSpaceToView(self.headImgView, 28).heightIs(textheight+10);
            
        
            [self.reviewBtn sd_setImageWithURL:URL(model.comment_img) forState:UIControlStateNormal];
            [self.queryBtn sd_setImageWithURL:URL(model.doubt_img) forState:UIControlStateNormal];
        
        
            [self.likeBtn setTitle:[NSString stringWithFormat:@"%@",model.vote] forState:UIControlStateNormal];
            if([model.has_vote integerValue]==0){
              [self.likeBtn sd_setImageWithURL:URL(model.vote_img) forState:UIControlStateNormal];
              [self.likeBtn setTitleColor:[UIColor colorWithHexString:model.vote_color] forState:UIControlStateNormal];
            }
            if([model.has_vote integerValue]==1){
               [self.likeBtn sd_setImageWithURL:URL(model.vote_img1) forState:UIControlStateNormal];
               [self.likeBtn setTitleColor:[UIColor colorWithHexString:model.vote_color1] forState:UIControlStateNormal];
            }
        
            //[self.reviewBtn setTitle:[NSString stringWithFormat:@"浏览%@",model.c_number] forState:UIControlStateNormal];
            [self.queryBtn setTitle:model.doubt forState:UIControlStateNormal]; 
            
            [self.likeBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:6];
            [self.queryBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:6];
            
            NSInteger starInt=[model.star integerValue];
            CGFloat gradeWidth=starInt*17;
//            CGFloat pleasedLBW=[model.star_str kr_getWidthWithTextHeight:15 font:11];
//            self.pleasedLB.sd_resetLayout
//            .rightSpaceToView(self, 10).centerYEqualToView(self.nameLB).widthIs(pleasedLBW).heightIs(15);
            if([self.model.star kr_isNotEmpty]){
                NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
                NSInteger countInt=[model.star integerValue];
                for (NSInteger i=0; i<countInt; i++) {
                    [arrM addObject:model.good_star];
                }
                self.gradeView.imgArr=arrM;
                self.gradeView.itemGap=2;
                self.gradeView.sd_resetLayout
                .leftSpaceToView(self.pleasedLB, 5).heightIs(15).centerYEqualToView(self.pleasedLB).widthIs(gradeWidth);
                //.rightSpaceToView(self, pleasedLBW+20).heightIs(15).centerYEqualToView(self.pleasedLB).widthIs(gradeWidth);
                self.consumeLB.sd_resetLayout
                .leftSpaceToView(self.gradeView, 13).centerYEqualToView(self.pleasedLB).heightIs(17).rightSpaceToView(self, 10);
            }
            
        //}
    }
}
@end
