//
//  FNgradeUeCell.m
//  THB
//
//  Created by Jimmy on 2019/1/16.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNgradeUeCell.h"

@implementation FNgradeUeCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"gradeUeCellID";
    FNgradeUeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
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
    
    self.dateLB=[UILabel new];
    self.dateLB.textColor=RGB(114, 114, 114);
    self.dateLB.font=kFONT13;
    self.dateLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.dateLB];
    
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
    self.gradeLB.font=[UIFont systemFontOfSize:8];
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
    
    CGFloat inter_23=13;
    CGFloat inter_15=15;
    CGFloat inter_12=12;
    CGFloat inter_10=10;
    
    CGFloat mean_4=self.frame.size.width/4;
    
    
    self.middleLine.sd_layout
    .centerXEqualToView(self).topSpaceToView(self, 0).bottomSpaceToView(self, 1).widthIs(1);
    
    self.dateLB.sd_layout
    .centerYEqualToView(self).leftSpaceToView(self, inter_23).heightIs(20).widthIs(70);
    
    self.headImageView.sd_layout
    .centerYEqualToView(self).leftSpaceToView(self.dateLB, inter_15).heightIs(35).widthIs(35);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.headImageView, inter_12).topSpaceToView(self, inter_15).heightIs(20).widthIs(50);
    
    self.gradeBGImg.sd_layout
    .leftSpaceToView(self.headImageView, inter_12).topSpaceToView(self.nameLB, 5).heightIs(10).widthIs(20);
    
    self.gradeLB.sd_layout
    .leftSpaceToView(self.gradeBGImg, 0).rightSpaceToView(self.gradeBGImg, 0).topSpaceToView(self.gradeBGImg, 0).bottomSpaceToView(self.gradeBGImg, 0);
    
    self.otherOneLB.sd_layout
    .leftSpaceToView(self.middleLine, 0).centerYEqualToView(self).heightIs(20).widthIs(mean_4);
    
    self.otherTwoLB.sd_layout
    .leftSpaceToView(self.otherOneLB, 0).centerYEqualToView(self).heightIs(20).widthIs(mean_4);
    
    self.line.sd_layout
    .bottomSpaceToView(self, 0).leftSpaceToView(self, inter_10).rightSpaceToView(self, inter_10).heightIs(1);
    
    
}

-(void)setModel:(FNgradeUeModel *)model{
    _model=model;
    if (model) {
        self.dateLB.text=[NSString getTimeStr:model.login_time withFormat:@"MM-dd HH:mm"];//model.login_time;
        self.nameLB.text=model.nickname;
        self.gradeLB.text=model.Vname;
        self.otherOneLB.text=model.commission;
        self.otherTwoLB.text=model.lower_count;  
        [self.headImageView setNoPlaceholderUrlImg:model.head_img];
        [self.gradeBGImg setNoPlaceholderUrlImg:model.vip_logo];
        
        
        CGFloat inter_23=13;
        CGFloat inter_15=15;
        CGFloat inter_12=12;
       
        CGFloat dateLBW=[self getWidthWithText:self.dateLB.text height:20 font:13];
        CGFloat nameW=[self getWidthWithText:self.nameLB.text height:20 font:15];
        if(nameW>130){
            nameW=130;
            XYLog(@"nickname=%@:%f",model.nickname,nameW);
        }
        CGFloat gradeW=[self getWidthWithText:self.gradeLB.text height:10 font:8];
        
        self.dateLB.sd_layout
        .centerYEqualToView(self).leftSpaceToView(self, inter_23).heightIs(20).widthIs(dateLBW);
        self.headImageView.sd_layout
        .centerYEqualToView(self).leftSpaceToView(self.dateLB, inter_15).heightIs(35).widthIs(35);
        self.nameLB.sd_layout
        .leftSpaceToView(self.headImageView, inter_12).topSpaceToView(self, 10).heightIs(20).widthIs(nameW);
        self.gradeBGImg.sd_layout
        .leftSpaceToView(self.headImageView, inter_12).bottomSpaceToView(self, 10).heightIs(10).widthIs(gradeW+10);
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
