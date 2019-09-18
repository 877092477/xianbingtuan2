//
//  FNEarningsOneHeadView.m
//  THB
//
//  Created by 李显 on 2018/9/11.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNEarningsOneHeadView.h"

@implementation FNEarningsOneHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=FNColor(238, 69, 123);
        
        [self initUI];
    }
    return self;
}
-(void)initUI{
    self.BgImageView=[UIImageView new];
    [self.contentView addSubview:self.BgImageView];
    /** headerTitle **/
    self.headTitle=[UILabel new];
    self.headTitle.textAlignment=NSTextAlignmentCenter;
    [self addOneLabelWithLabView:self.headTitle TextColor:[UIColor whiteColor] fontSize:13 addSub:self.BgImageView];
    /** 金额1 **/
    self.amountOneLB=[UILabel new];
    self.amountOneLB.textAlignment=NSTextAlignmentLeft;
    [self addOneLabelWithLabView:self.amountOneLB TextColor:[UIColor whiteColor] fontSize:16 addSub:self.BgImageView];
    /** 账户余额 **/
    self.balanceLB=[UILabel new];
    self.balanceLB.textAlignment=NSTextAlignmentCenter;
    [self addOneLabelWithLabView:self.balanceLB TextColor:[UIColor whiteColor] fontSize:11 addSub:self.BgImageView];
    /** 累计收益 **/
    self.grandLB=[UILabel new];
    self.grandLB.textAlignment=NSTextAlignmentRight;
    [self addOneLabelWithLabView:self.grandLB TextColor:[UIColor whiteColor] fontSize:11 addSub:self.BgImageView];
    /** 金额2 **/
    self.amountTwoLB=[UILabel new];
    self.amountTwoLB.textAlignment=NSTextAlignmentLeft;
    [self addOneLabelWithLabView:self.amountTwoLB TextColor:[UIColor whiteColor] fontSize:13 addSub:self.BgImageView];
    /** 立即提现 **/
    self.extractBtn=[UIButton new];
    self.extractBtn.cornerRadius=12.5;
    //self.extractBtn.titleLabel.font=[UIFont fontWithDevice:11];
    self.extractBtn.titleLabel.font=kFONT12;
    [self.extractBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.BgImageView addSubview:self.extractBtn];
    /** 1Image **/
    self.ImageOneView=[UIImageView new];
    [self.BgImageView addSubview:self.ImageOneView];
    /** 2Image **/
    self.ImagetwoView=[UIImageView new];
    [self.BgImageView addSubview:self.ImagetwoView];
    //立即提现图片
    self.depositiImg=[UIImageView new];
    self.depositiImg.hidden=YES;
    [self.BgImageView addSubview:self.depositiImg];
    
    [self initdistribute];
    UIView *lineview=[UIView new];
    [self.contentView addSubview:lineview];
    lineview.backgroundColor=FNColor(245, 245, 245);
    lineview.sd_layout
    .leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(10).bottomEqualToView(self.contentView);
}
-(void)initdistribute{
    CGFloat titleTop=SafeAreaTopHeight-35;
    self.BgImageView.sd_layout
    .leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 10);
    
    UIView *line=[UIView new];
    [self.BgImageView addSubview:line];
    line.sd_layout
    .heightIs(1).centerYEqualToView(self.BgImageView).centerXEqualToView(self.BgImageView).widthIs(1);
    
    self.headTitle.sd_layout
    .rightSpaceToView(self.BgImageView, 10).centerXEqualToView(self.BgImageView).leftSpaceToView(self.BgImageView, 10).topSpaceToView(self.BgImageView, titleTop).heightIs(25);
    //[self.headTitle setSingleLineAutoResizeWithMaxWidth:150];
    
    self.ImageOneView.sd_layout
    .widthIs(20).heightIs(15).centerYEqualToView(self.BgImageView).rightSpaceToView(line, 5);
    
    self.amountOneLB.sd_layout
    .leftSpaceToView(line, 5).heightIs(25).rightSpaceToView(self.BgImageView, 10).centerYEqualToView(self.BgImageView);
    
    self.balanceLB.sd_layout
    .leftSpaceToView(self.BgImageView, 10).rightSpaceToView(self.BgImageView, 10).topSpaceToView(self.amountOneLB, 10).heightIs(20);
    
    self.extractBtn.sd_layout
    .centerXEqualToView(self.BgImageView).topSpaceToView(self.balanceLB, 10).heightIs(25).widthIs(100);
    
    self.ImagetwoView.sd_layout
    .centerXEqualToView(self.BgImageView).heightIs(15).widthIs(20).topSpaceToView(self.extractBtn, 10);
    
    self.grandLB.sd_layout
    .rightSpaceToView(self.ImagetwoView, 10).heightIs(20).topEqualToView(self.ImagetwoView).leftSpaceToView(self.BgImageView, 10);
    
    self.amountTwoLB.sd_layout
    .leftSpaceToView(self.ImagetwoView, 10).heightIs(20).topEqualToView(self.ImagetwoView).rightSpaceToView(self.BgImageView, 10);
    
    self.depositiImg.sd_layout
    .centerXEqualToView(self.extractBtn).centerYEqualToView(self.extractBtn).widthIs(89).heightIs(27);
   
}
-(void)setModel:(FNEarnigsNModel *)model{
    NSLog(@"money:%@",model.money);
    if(model){
        NSString*monicon= [FNBaseSettingModel settingInstance].mon_icon;
        [self.BgImageView setNoPlaceholderUrlImg:model.back_img];
        self.headTitle.text=model.topTitle;//@"嗨如意会员收益";
        self.amountOneLB.text=model.money;//@"2421.01";
        self.balanceLB.text=model.str;//@"账户余额";
        self.grandLB.text=model.str1;//@"累计提现";
        self.amountTwoLB.text=model.lj_money;//@"2421.01";
        [self.ImageOneView setUrlImg:monicon];
        [self.ImagetwoView setUrlImg:monicon];
        self.extractBtn.backgroundColor=[UIColor whiteColor];
        NSString *is_tx=[[NSUserDefaults standardUserDefaults] objectForKey:@"JM_MPM_wallet_is_tx"];
        NSString *imageUrl=[[NSUserDefaults standardUserDefaults] objectForKey:@"JM_MPM_wallet_img"];
        if ([NSString checkIsSuccess:is_tx andElement:@"1"]) {
            self.extractBtn.hidden=YES;
            self.depositiImg.hidden=NO;
            [self.depositiImg setNoPlaceholderUrlImg:imageUrl];
        }else{
            NSString *title1=[[NSUserDefaults standardUserDefaults] objectForKey:@"JM_MPM_wallet_title1"];
            if ([title1 kr_isNotEmpty]) {
                [self.extractBtn setTitle:title1 forState:UIControlStateNormal];
                CGFloat extractW=[self getWidthWithText:title1 height:25 font:12];
                self.extractBtn.hidden=NO;
                self.depositiImg.hidden=YES;
                self.extractBtn.sd_layout
                .centerXEqualToView(self.BgImageView).topSpaceToView(self.balanceLB, 10).heightIs(25).widthIs(extractW+10);
            }
        }
    }
}
//AddLB
-(void)addOneLabelWithLabView:(UILabel *)label TextColor:(UIColor *)textColor fontSize:(float)fontSize addSub:(UIView *)View{
    label.textColor = textColor;
    //label.textAlignment=NSTextAlignmentLeft;
    label.font=[UIFont fontWithDevice:fontSize];
    [View addSubview:label];
    
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
