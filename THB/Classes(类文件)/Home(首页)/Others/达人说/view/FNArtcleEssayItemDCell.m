//
//  FNArtcleEssayItemDCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNArtcleEssayItemDCell.h"

@implementation FNArtcleEssayItemDCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNArtcleEssayItemDCell";
    FNArtcleEssayItemDCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
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
    self.headImg=[[UIImageView alloc]init];
    self.nameLB=[[UILabel alloc]init];
    self.checkBtn=[UIButton buttonWithType:UIButtonTypeCustom]; 
    [self addSubview:self.bgImgView];
    [self addSubview:self.showImg];
    [self addSubview:self.titleLB];
    [self addSubview:self.headImg];
    [self addSubview:self.nameLB];
    [self addSubview:self.checkBtn];
    
    self.headImg.cornerRadius=26/2;
    self.titleLB.font=kFONT15;
    self.titleLB.textColor=RGB(51, 51, 51);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.nameLB.font=kFONT15;
    self.nameLB.textColor=RGB(51, 51, 51);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.checkBtn.titleLabel.font=kFONT14;
    [self.checkBtn setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    
    self.bgImgView.backgroundColor=[UIColor whiteColor];
    self.bgImgView.cornerRadius=10;
    
    [self incomposition];
 
}

-(void)incomposition{
    CGFloat gap_8=8;
    CGFloat gap_12=12;
    CGFloat gap_14=14;
    CGFloat gap_30=30;
    self.bgImgView.sd_layout
    .leftSpaceToView(self, gap_12).topSpaceToView(self, gap_14).rightSpaceToView(self, gap_12).bottomSpaceToView(self, gap_14);
    
    self.showImg.sd_layout
    .leftSpaceToView(self, gap_12).topSpaceToView(self, gap_14).rightSpaceToView(self, gap_12).heightIs(160);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, gap_30).topSpaceToView(self.showImg, gap_8).rightSpaceToView(self, gap_30).heightIs(19);
    
    self.headImg.sd_layout
    .leftSpaceToView(self, gap_30).topSpaceToView(self.titleLB, 6).heightIs(26).widthIs(26);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.headImg, 6).centerYEqualToView(self.headImg).heightIs(19);
    [self.nameLB setSingleLineAutoResizeWithMaxWidth:180];
    
    self.checkBtn.sd_layout
    .rightSpaceToView(self, 15).centerYEqualToView(self.headImg).heightIs(20).widthIs(70);
    
    self.showImg.frame=CGRectMake(12, 14, FNDeviceWidth-24, 160);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.showImg.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.showImg.bounds;
    maskLayer.path = maskPath.CGPath;
    self.showImg.layer.mask = maskLayer;
    
    [self.headImg addTarget:self action:@selector(headImgAction)];
    [self.nameLB addTarget:self action:@selector(headImgAction)];
    
}
-(void)headImgAction{
    if ([self.delegate respondsToSelector:@selector(didArtcleEssayHeadItemAction:)]) {
        [self.delegate didArtcleEssayHeadItemAction:self.indexS];
    }
}
-(void)setModel:(FNEssayItemDModel *)model{
    _model=model;
    if(model){
        [self.showImg setUrlImg:model.banner];
        [self.headImg setUrlImg:model.head_img];
        self.titleLB.text=model.title;
        self.nameLB.text=model.talent_name;
        CGFloat checkBtnW=[model.readtimes kr_getWidthWithTextHeight:20 font:14];
        
        if(checkBtnW>80){
            checkBtnW=80;
        }
        [self.checkBtn setImage:IMAGE(@"FN_DRS_ckImg") forState:UIControlStateNormal];
        [self.checkBtn setTitle:model.readtimes forState:UIControlStateNormal];
        self.checkBtn.sd_layout
        .rightSpaceToView(self, 15).centerYEqualToView(self.headImg).heightIs(20).widthIs(checkBtnW+10+20);
        self.checkBtn.imageView.sd_layout
        .centerYEqualToView(self.checkBtn).leftSpaceToView(self.checkBtn, 0).heightIs(10).widthIs(20);
        self.checkBtn.titleLabel.sd_layout
        .centerYEqualToView(self.checkBtn).leftSpaceToView(self.checkBtn.imageView, 5).heightIs(20).rightSpaceToView(self.checkBtn, 2);
        
        //[self.checkBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
        
    }
}

@end
