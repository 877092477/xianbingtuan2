//
//  FNstatisticsCanDeCell.m
//  THB
//
//  Created by Jimmy on 2018/12/27.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//头部1cell 110
#import "FNstatisticsCanDeCell.h"

@implementation FNstatisticsCanDeCell
-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    self.backgroundColor=[UIColor whiteColor];//RGB(246, 245, 245);
    
    self.bgImage=[UIImageView new];
    self.bgImage.backgroundColor=RGB(255, 69, 31);
    self.bgImage.cornerRadius=5;
    [self addSubview:self.bgImage];
    
    self.titleLB=[UILabel new];
    self.titleLB.font=kFONT14;
    self.titleLB.textColor=[UIColor whiteColor];
    [self addSubview:self.titleLB];
    
    self.sumLB=[UILabel new];
    self.sumLB.font=[UIFont systemFontOfSize:24];
    self.sumLB.textAlignment=NSTextAlignmentLeft;
    self.sumLB.textColor=[UIColor whiteColor];
    [self addSubview:self.sumLB];
    
    self.detailBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.detailBtn.titleLabel.font=kFONT11;;
    [self.detailBtn setTitleColor:RGB(140,140,140) forState:UIControlStateNormal];
    [self addSubview:self.detailBtn];
    
    self.carryBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.carryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.carryBtn.titleLabel.font=kFONT13;
    self.carryBtn.borderColor = [UIColor whiteColor];//RGB(255, 85, 85);
    self.carryBtn.borderWidth=1;
    self.carryBtn.cornerRadius=25/2;
    self.carryBtn.clipsToBounds = YES;
    self.carryBtn.hidden=YES;
    [self.carryBtn addTarget:self action:@selector(carryBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.carryBtn];
    
    [self incompositionFrames]; 
    
}
-(void)incompositionFrames{
    CGFloat inter_30=30;
    CGFloat inter_7=7.5;
    CGFloat inter_10=10;
    CGFloat inter_15=15;
    
    self.bgImage.sd_layout
    .rightSpaceToView(self, inter_10).topSpaceToView(self, inter_15).leftSpaceToView(self, inter_10).bottomSpaceToView(self, inter_15);
    
    self.titleLB.sd_layout
    .heightIs(20).topSpaceToView(self, inter_30).leftSpaceToView(self, inter_30);
    [self.titleLB setSingleLineAutoResizeWithMaxWidth:150];
    
    self.sumLB.sd_layout
    .heightIs(25).topSpaceToView(self, 57).leftSpaceToView(self, inter_30);
    [self.sumLB setSingleLineAutoResizeWithMaxWidth:150];
    
    self.detailBtn.sd_layout
    .heightIs(15).rightSpaceToView(self, inter_30).topSpaceToView(self, inter_30);//.widthIs(65)
    [self.detailBtn setupAutoSizeWithHorizontalPadding:10 buttonHeight:15];
    
    self.carryBtn.sd_layout
    .heightIs(25).rightSpaceToView(self, inter_30).widthIs(65).topSpaceToView(self, 57);
    [self.carryBtn setupAutoSizeWithHorizontalPadding:10 buttonHeight:25];
    
    
    
}

-(void)setModel:(FNstatisticsTXModel *)model{
    _model=model;
    if(model){
        self.titleLB.text=model.str;//@"可提现金额";
        self.sumLB.text=model.money;//@"178.00";
        [self.detailBtn setTitle:model.str1 forState:UIControlStateNormal];//model.str1//@"收入明细";
        [self.carryBtn setTitle:model.str3 forState:UIControlStateNormal];
        [self.bgImage setNoPlaceholderUrlImg:model.bj_img];
         
        
        self.titleLB.textColor=[UIColor colorWithHexString:model.color];
        self.sumLB.textColor=[UIColor colorWithHexString:model.color];
        [self.detailBtn setTitleColor:[UIColor colorWithHexString:model.color] forState:UIControlStateNormal];
        [self.carryBtn setTitleColor:[UIColor colorWithHexString:model.color] forState:UIControlStateNormal];
        self.carryBtn.hidden=NO;
        /*NSString *is_tx=model.is_tx;//[[NSUserDefaults standardUserDefaults] objectForKey:@"JM_MPM_wallet_is_tx"];
        NSString *imageUrl=[[NSUserDefaults standardUserDefaults] objectForKey:@"JM_MPM_wallet_img"];
        if ([NSString checkIsSuccess:is_tx andElement:@"1"]) {
            //self.extractBtn.hidden=YES;
            //self.depositiImg.hidden=NO;
            //[self.depositiImg setNoPlaceholderUrlImg:imageUrl];
            [self.carryBtn sd_setBackgroundImageWithURL:URL(imageUrl) forState:UIControlStateNormal];
            [self.carryBtn setTitle:@"" forState:UIControlStateNormal];
            self.carryBtn.sd_layout
            .heightIs(25).rightSpaceToView(self, 30).bottomEqualToView(self.sumLB).widthIs(65);
        }else{
            NSString *title1=[[NSUserDefaults standardUserDefaults] objectForKey:@"JM_MPM_wallet_title1"];
            if ([title1 kr_isNotEmpty]) {
                CGFloat carryBtnW=[self getWidthWithText:model.str3 height:25 font:13];
                self.carryBtn.sd_layout
                .heightIs(25).rightSpaceToView(self, 30).bottomEqualToView(self.sumLB).widthIs(carryBtnW);
                
            }
        }*/
    }
}
-(void)carryBtnClick{
    if ([self.delegate respondsToSelector:@selector(inStatisticsCanwithdraw)]) {
        [self.delegate inStatisticsCanwithdraw];
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
