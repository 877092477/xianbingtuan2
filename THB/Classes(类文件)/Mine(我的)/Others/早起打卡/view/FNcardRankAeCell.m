//
//  FNcardRankAeCell.m
//  THB
//
//  Created by Jimmy on 2019/2/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcardRankAeCell.h"

@implementation FNcardRankAeCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
        
    }
    return self;
}

- (void)initializedSubviews
{
    //self.bgImg=[[UIImageView alloc]init];
    //self.bgImg.image=IMAGE(@"FN_punch_BGimg");
    //[self addSubview:self.bgImg];
    
//    self.titleLB=[[UILabel alloc]init];
//    self.titleLB.font=[UIFont systemFontOfSize:14];
//    self.titleLB.textColor=[UIColor whiteColor];
//    self.titleLB.textAlignment=NSTextAlignmentCenter;
//    [self addSubview:self.titleLB];
    
    
    self.todayBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.todayBtn.titleLabel.font=kFONT16;
    [self.todayBtn setTitle:@"今日战况" forState:UIControlStateNormal];
    [self.todayBtn setBackgroundImage:IMAGE(@"FN_jrzk_img") forState:UIControlStateNormal];
    [self addSubview:self.todayBtn];
    
    self.inviteBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.inviteBtn.titleLabel.font=kFONT12;
    [self.inviteBtn setTitle:@"立即邀请好友参与早起打卡" forState:UIControlStateNormal];
    [self.inviteBtn setImage:IMAGE(@"FN_dk_rightimg") forState:UIControlStateNormal];
    [self.inviteBtn sizeToFit];
    self.inviteBtn.size = CGSizeMake(self.inviteBtn.width+10, 40);
    [self.inviteBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5.0f];
    [self addSubview:self.inviteBtn];
    
    
    CGFloat sizeW=FNDeviceWidth/3;
    self.bestView=[[FNCardItemAeView alloc]init];
    self.bestView.frame=CGRectMake(0, 60, sizeW, 170);
    [self addSubview:self.bestView];
    
    self.firstView=[[FNCardItemAeView alloc]init];
    self.firstView.frame=CGRectMake(sizeW, 60, sizeW, 170);
    [self addSubview:self.firstView];
    
    self.longestView=[[FNCardItemAeView alloc]init];
    self.longestView.frame=CGRectMake(sizeW+sizeW, 60, sizeW, 170);
    [self addSubview:self.longestView];
    
    [self incomposition];
 
    
    
}
-(void)incomposition{
    CGFloat inter_5=5;
    CGFloat inter_15=15;
    CGFloat inter_20=20;
    
    self.todayBtn.sd_layout
    .leftSpaceToView(self,0).topSpaceToView(self, inter_20).heightIs(40).widthIs(92);
    
    self.inviteBtn.sd_layout
    .rightSpaceToView(self, 10).topSpaceToView(self, inter_20).heightIs(40).widthIs(self.inviteBtn.width);
    
    
    
    
}

- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}
@end
