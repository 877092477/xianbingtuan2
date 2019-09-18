//
//  FNrankingAgoUeCell.m
//  THB
//
//  Created by 李显 on 2019/1/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//
//215
#import "FNrankingAgoUeCell.h"

@implementation FNrankingAgoUeCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"rankingAgoUeCellID";
    FNrankingAgoUeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    self.backgroundColor=RGB(245, 245, 245);
    
    self.gradeBGImg=[UIImageView new];
    [self addSubview:self.gradeBGImg];
    
    self.gradeLB=[UILabel new];
    [self.gradeLB sizeToFit];
    self.gradeLB.textColor=[UIColor whiteColor];
    self.gradeLB.font=[UIFont systemFontOfSize:11];
    self.gradeLB.textAlignment=NSTextAlignmentCenter;
    [self.gradeBGImg addSubview:self.gradeLB];
    
    self.rankingImageView=[UIImageView new];
    [self addSubview:self.rankingImageView];
    
    self.headImageView=[UIImageView new];
    self.headImageView.cornerRadius=47/2;
    self.backgroundColor=[UIColor whiteColor];
    [self.rankingImageView addSubview:self.headImageView];
    
    self.numLB=[UILabel new];
    self.numLB.font=kFONT15;
    self.numLB.textAlignment=NSTextAlignmentCenter;
    [self.rankingImageView addSubview:self.numLB];
    
    self.nameLB=[UILabel new];
    [self.nameLB sizeToFit];
    self.nameLB.font=kFONT15;
    self.nameLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.nameLB];
    
    self.otherOneLB=[UILabel new];
    self.otherOneLB.textColor=RGB(250, 150, 75);
    self.otherOneLB.font=[UIFont systemFontOfSize:12];
    self.otherOneLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.otherOneLB];
    
    self.otherTwoLB=[UILabel new];
    self.otherTwoLB.textColor=RGB(250, 150, 75);
    self.otherTwoLB.font=kFONT12;
    self.otherTwoLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.otherTwoLB];
    
    [self incomposition];
}

-(void)incomposition{
    
    CGFloat inter_15=15;
    CGFloat inter_10=10;
    CGFloat inter_5=5;
    
    self.gradeBGImg.sd_layout
    .centerXEqualToView(self).topSpaceToView(self, inter_5).heightIs(18).widthIs(65);
    
    self.gradeLB.sd_layout
    .leftSpaceToView(self.gradeBGImg, 0).rightSpaceToView(self.gradeBGImg, 0).topSpaceToView(self.gradeBGImg, 0).bottomSpaceToView(self.gradeBGImg, 0);
    
    self.rankingImageView.sd_layout
    .centerXEqualToView(self).topSpaceToView(self.gradeBGImg, inter_10).heightIs(82).widthIs(62);
    
    self.headImageView.sd_layout
    .centerXEqualToView(self.rankingImageView).bottomSpaceToView(self.rankingImageView, inter_5).heightIs(47).widthIs(47);
    
    self.numLB.sd_layout
    .centerXEqualToView(self.rankingImageView).bottomSpaceToView(self.headImageView, 0).heightIs(22).widthIs(40);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self, inter_5).rightSpaceToView(self, inter_5).topSpaceToView(self.rankingImageView, inter_15).heightIs(17); 
    
    self.otherOneLB.sd_layout
    .leftSpaceToView(self, inter_5).rightSpaceToView(self, inter_5).topSpaceToView(self.nameLB, inter_15).heightIs(15);
    
    self.otherTwoLB.sd_layout
    .leftSpaceToView(self, inter_5).rightSpaceToView(self, inter_5).topSpaceToView(self.otherOneLB, 13).heightIs(15);
    
}

-(void)setModel:(FNarrangeItemModel *)model{
    _model=model;
    if (model) {
        self.numLB.text=model.num;
        self.nameLB.text=model.nickname;
        self.gradeLB.text=model.Vname;
        self.otherOneLB.text=[NSString stringWithFormat:@"%@%@%@",model.commission_str,model.commission,model.commission_unit];
        self.otherTwoLB.text=[NSString stringWithFormat:@"%@%@%@",model.lower_count_str,model.lower_count,model.lower_count_unit];
        self.otherOneLB.textColor=[UIColor colorWithHexString:model.commission_color];
        self.otherTwoLB.textColor=[UIColor colorWithHexString:model.lower_count_color];
        [self.rankingImageView setNoPlaceholderUrlImg:model.phb_img];
        [self.headImageView setNoPlaceholderUrlImg:model.head_img];
        [self.gradeBGImg setNoPlaceholderUrlImg:model.vip_logo];
        self.numLB.textColor=[UIColor whiteColor];
        
    }
}

@end
