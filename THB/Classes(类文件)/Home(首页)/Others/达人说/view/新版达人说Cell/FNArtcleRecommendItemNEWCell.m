//
//  FNArtcleRecommendItemNEWCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/23.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNArtcleRecommendItemNEWCell.h"

@implementation FNArtcleRecommendItemNEWCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNArtcleRecommendItemNEWCellID";
    FNArtcleRecommendItemNEWCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializedSubviews];
        
    }
    return self;
}

- (void)initializedSubviews{
    
    self.bgImgView=[[UIImageView alloc]init];
    self.showImg=[[UIImageView alloc]init];
    self.titleLB=[[UILabel alloc]init];
    self.contentLB=[[UILabel alloc]init];
    self.headImg=[[UIImageView alloc]init];
    self.nameLB=[[UILabel alloc]init];
    self.checkBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.amountBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.bgImgView];
    [self addSubview:self.showImg];
    [self addSubview:self.titleLB];
    [self addSubview:self.contentLB];
    [self addSubview:self.headImg];
    [self addSubview:self.nameLB];
    [self addSubview:self.checkBtn];
    [self addSubview:self.amountBtn];
    
    //self.backgroundColor=RGB(250, 250, 250);
    
//    self.bgImgView.backgroundColor=[UIColor whiteColor];
//    self.bgImgView.borderWidth=2;
//    self.bgImgView.borderColor = RGB(250, 242, 242);
//    self.bgImgView.cornerRadius=10;
//    self.bgImgView.clipsToBounds = YES;
    
    self.showImg.cornerRadius=5;
    
    self.headImg.cornerRadius=17/2;
    self.titleLB.font=kFONT16;
    self.titleLB.textColor=RGB(51, 51, 51);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.contentLB.font=kFONT13;
    self.contentLB.textColor=RGB(51, 51, 51);
    self.contentLB.numberOfLines=3;
    self.contentLB.textAlignment=NSTextAlignmentLeft;
    
    self.nameLB.font=kFONT12;
    self.nameLB.textColor=RGB(153, 153, 153);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.checkBtn.titleLabel.font=kFONT12;
    [self.checkBtn setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    
    self.amountBtn.titleLabel.font=kFONT10;
    [self.amountBtn setTitleColor:RGB(255, 80, 69) forState:UIControlStateNormal];
    
    
    //self.bgImgView.cornerRadius=10;
    
    self.amountBtn.cornerRadius=5;
    self.amountBtn.borderWidth=1.5;
    self.amountBtn.borderColor = RGB(255, 80, 69);
    
    [self incomposition];
    
}

-(void)incomposition{
     
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 6).topSpaceToView(self, 5).rightSpaceToView(self, 6).bottomSpaceToView(self, 5);
    
    self.showImg.sd_layout
    .leftSpaceToView(self, 25).bottomSpaceToView(self, 60).rightSpaceToView(self, 25).heightIs(110);
    //topSpaceToView(self, 130)
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 25).rightSpaceToView(self, 90).topSpaceToView(self, 28).heightIs(25);
    
    self.amountBtn.sd_layout
    .rightSpaceToView(self, 25).centerYEqualToView(self.titleLB).heightIs(25).widthIs(50);
    
    self.contentLB.sd_layout
    .leftSpaceToView(self, 25).topSpaceToView(self, 67).rightSpaceToView(self, 25).heightIs(55);
    
    self.headImg.sd_layout
    .leftSpaceToView(self, 25).topSpaceToView(self.showImg, 15).heightIs(17).widthIs(17);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.headImg, 4).centerYEqualToView(self.headImg).heightIs(19);
    [self.nameLB setSingleLineAutoResizeWithMaxWidth:180];
    
    self.checkBtn.sd_layout
    .rightSpaceToView(self, 25).centerYEqualToView(self.headImg).heightIs(20).widthIs(70);
    
    
    
//    self.showImg.frame=CGRectMake(12, 14, FNDeviceWidth-24, 160);
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.showImg.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = self.showImg.bounds;
//    maskLayer.path = maskPath.CGPath;
//    self.showImg.layer.mask = maskLayer;
    
    [self.headImg addTarget:self action:@selector(headImgAction)];
    [self.nameLB addTarget:self action:@selector(headImgAction)];
    
}
-(void)headImgAction{
    if ([self.delegate respondsToSelector:@selector(didRecommendItemNEWCellAction:)]) {
        [self.delegate didRecommendItemNEWCellAction:self.indexS];
    }
}
-(void)setModel:(FNEssayItemDModel *)model{
    _model=model;
    if(model){
        [self.bgImgView setNoPlaceholderUrlImg:model.bg_img];
        [self.showImg setUrlImg:model.banner];
        [self.headImg setUrlImg:model.head_img];
        self.titleLB.text=model.title;
        self.contentLB.text=model.article;
        self.nameLB.text=model.talent_name;
        CGFloat checkBtnW=[model.readtimes kr_getWidthWithTextHeight:20 font:14];
        CGFloat amountBtnW=[model.goodscount_str kr_getWidthWithTextHeight:20 font:12];
        if(checkBtnW>80){
            checkBtnW=80;
        }
        if(amountBtnW>65){
            amountBtnW=65;
        }
        [self.checkBtn setImage:IMAGE(@"FN_DRS_ckImg") forState:UIControlStateNormal];
        [self.checkBtn setTitle:model.readtimes forState:UIControlStateNormal];
        self.checkBtn.sd_layout
        .rightSpaceToView(self, 15).centerYEqualToView(self.headImg).heightIs(20).widthIs(checkBtnW+10+13);
        self.checkBtn.imageView.sd_layout
        .centerYEqualToView(self.checkBtn).leftSpaceToView(self.checkBtn, 0).heightIs(10).widthIs(13);
        self.checkBtn.titleLabel.sd_layout
        .centerYEqualToView(self.checkBtn).leftSpaceToView(self.checkBtn.imageView, 5).heightIs(20).rightSpaceToView(self.checkBtn, 2);
        
        
        [self.amountBtn setTitle:model.goodscount_str forState:UIControlStateNormal];
        self.amountBtn.sd_layout
        .rightSpaceToView(self, 25).centerYEqualToView(self.titleLB).heightIs(25).widthIs(amountBtnW+15);
        
    }
}
@end
