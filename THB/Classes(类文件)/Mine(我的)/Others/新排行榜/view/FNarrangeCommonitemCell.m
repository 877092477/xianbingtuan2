//
//  FNarrangeCommonitemCell.m
//  THB
//
//  Created by 李显 on 2019/1/21.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNarrangeCommonitemCell.h"

@implementation FNarrangeCommonitemCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"arrangeCommonitemCellID";
    FNarrangeCommonitemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
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
    
    self.middleLine=[[UIView alloc]init];
    //self.middleLine.backgroundColor=RGB(129, 128, 129);
    [self addSubview:self.middleLine];
    
    self.rankingImageView=[UIImageView new];
    [self addSubview:self.rankingImageView];
    
    self.numLB=[UILabel new];
    self.numLB.font=kFONT15;
    self.numLB.textAlignment=NSTextAlignmentCenter;
    [self.rankingImageView addSubview:self.numLB];
    
    self.headImageView=[UIImageView new];
    self.headImageView.cornerRadius=35/2;
    self.headImageView.borderWidth=1;
    self.headImageView.borderColor = RGB(243, 243, 243);
    self.headImageView.clipsToBounds = YES;
    [self addSubview:self.headImageView];
    
    self.nameLB=[UILabel new];
    [self.nameLB sizeToFit];
    self.nameLB.font=kFONT15;
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.nameLB];
    
    self.gradeBGImg=[UIImageView new];
    [self addSubview:self.gradeBGImg];
    
    self.gradeLB=[UILabel new];
    [self.gradeLB sizeToFit];
    self.gradeLB.textColor=[UIColor whiteColor];
    self.gradeLB.font=[UIFont systemFontOfSize:11];
    self.gradeLB.textAlignment=NSTextAlignmentCenter;
    [self.gradeBGImg addSubview:self.gradeLB];
    
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
    
    self.line=[[UIView alloc]init];
    self.line.backgroundColor=RGB(243, 243, 243);
    [self addSubview:self.line];
    
    
    [self incomposition];
}

-(void)incomposition{
   
    CGFloat inter_15=15;
    CGFloat inter_12=12;
    
    CGFloat mean_4=self.frame.size.width/4; 
    
    self.middleLine.sd_layout
    .centerXEqualToView(self).topSpaceToView(self, 0).bottomSpaceToView(self, 1).widthIs(1);
    
    self.rankingImageView.sd_layout
    .centerYEqualToView(self).leftSpaceToView(self, 30).heightIs(25).widthIs(25);
    
    self.numLB.sd_layout
    .topSpaceToView(self.rankingImageView, 0).centerXEqualToView(self.rankingImageView).heightIs(22).widthIs(40);
    
    self.headImageView.sd_layout
    .centerYEqualToView(self).leftSpaceToView(self.numLB, inter_15).heightIs(35).widthIs(35);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.headImageView, inter_12).bottomSpaceToView(self, inter_15).heightIs(17).widthIs(50);
    
    self.gradeBGImg.sd_layout
    .leftSpaceToView(self.headImageView, inter_12).topSpaceToView(self, 12).heightIs(18).widthIs(65);
    
    self.gradeLB.sd_layout
    .leftSpaceToView(self.gradeBGImg, 0).rightSpaceToView(self.gradeBGImg, 0).topSpaceToView(self.gradeBGImg, 0).bottomSpaceToView(self.gradeBGImg, 0);
    
    self.otherOneLB.sd_layout
    .leftSpaceToView(self.middleLine, 0).topSpaceToView(self, 27).heightIs(15).widthIs(mean_4);
    
    self.otherTwoLB.sd_layout
    .leftSpaceToView(self.otherOneLB, 0).topSpaceToView(self, 27).heightIs(15).widthIs(mean_4);
    
    self.line.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0).heightIs(1);
    
    
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
        
        NSInteger numInt=[model.num integerValue];
        if (numInt>6) {
            self.numLB.textColor=[UIColor blackColor];
        }
        else{
            self.numLB.textColor=[UIColor whiteColor];
        }
       
        CGFloat inter_12=12;
        CGFloat nameW=[self getWidthWithText:self.nameLB.text height:17 font:15];
        if(nameW>115){
            nameW=115;
        }
        self.headImageView.sd_layout
        .centerYEqualToView(self).leftSpaceToView(self.rankingImageView, 20).heightIs(35).widthIs(35);
        self.nameLB.sd_layout
        .leftSpaceToView(self.headImageView, inter_12).bottomSpaceToView(self, 7).heightIs(17).widthIs(nameW);
        self.gradeBGImg.sd_layout
        .leftSpaceToView(self.headImageView, inter_12).topSpaceToView(self, inter_12).heightIs(18).widthIs(65);
        self.gradeLB.sd_layout
        .leftSpaceToView(self.gradeBGImg, 0).rightSpaceToView(self.gradeBGImg, 0).topSpaceToView(self.gradeBGImg, 0).bottomSpaceToView(self.gradeBGImg, 0);
        
        
    }
}

//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}
@end
