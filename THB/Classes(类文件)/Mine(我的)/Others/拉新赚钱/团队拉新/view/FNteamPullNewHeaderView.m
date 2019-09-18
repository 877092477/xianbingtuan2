//
//  FNteamPullNewHeaderView.m
//  嗨如意
//
//  Created by Fnuo-iOS on 2018/5/10.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNteamPullNewHeaderView.h"

@implementation FNteamPullNewHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIView *line=[UIView new];
        line.backgroundColor=RGB(250, 103, 130);
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).offset(10);
            make.height.equalTo(@1);
            make.left.equalTo(@30);
            make.right.equalTo(@-30);
        }];
        
        UIImageView *Headportrait=[UIImageView new];
        Headportrait.cornerRadius=35;
        [self addSubview:Headportrait];
        [Headportrait mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@15);
            make.left.equalTo(@30);
            make.width.height.equalTo(@70);
        }];
        self.Headportrait=Headportrait;
        
        UIImageView *QRCodeImage=[UIImageView new];
        QRCodeImage.cornerRadius=5;
        [self addSubview:QRCodeImage];
        [QRCodeImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@15);
            make.right.equalTo(@-30);
            make.width.height.equalTo(@70);
        }];
        self.QRCodeImage=QRCodeImage;
        
        UILabel *label=[UILabel new];
        label.textColor=FNWhiteColor;
        label.font=kFONT12;
        label.text=@"扫码进团队";
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(QRCodeImage.mas_bottom).offset(0);
            make.centerX.equalTo(QRCodeImage.mas_centerX);
        }];
        
        UILabel *Name=[UILabel new];
        Name.textColor=FNWhiteColor;
        Name.font=kFONT14;
        [self addSubview:Name];
        [Name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(Headportrait.mas_right).offset(10);
            make.right.equalTo(QRCodeImage.mas_left).offset(-10);
            make.centerY.equalTo(Headportrait.mas_centerY);
        }];
        self.Name=Name;
        
        FNCmbDoubleTextButton *leftBtn = [[FNCmbDoubleTextButton alloc]init];
        leftBtn.backgroundColor = [UIColor clearColor];
        [leftBtn.topLable setTitleColor:FNWhiteColor forState:(UIControlStateNormal)];
        leftBtn.topLable.titleLabel.font = kFONT14;
        [leftBtn.bottomLabel setTitleColor:FNWhiteColor forState:(UIControlStateNormal)];
        leftBtn.bottomLabel.titleLabel.font = kFONT14;
        [leftBtn.topLable setTitle:@"个人拉新总数" forState:(UIControlStateNormal)];
        [self addSubview:leftBtn];
        
        FNCmbDoubleTextButton *midBtn = [[FNCmbDoubleTextButton alloc]init];
        midBtn.backgroundColor = [UIColor clearColor];
        [midBtn.topLable setTitleColor:FNWhiteColor forState:(UIControlStateNormal)];
        midBtn.topLable.titleLabel.font = kFONT14;
        [midBtn.bottomLabel setTitleColor:FNWhiteColor forState:(UIControlStateNormal)];
        midBtn.bottomLabel.titleLabel.font = kFONT14;
        [midBtn.topLable setTitle:@"团队拉新总数" forState:(UIControlStateNormal)];
        [self addSubview:midBtn];
        
        FNCmbDoubleTextButton *rightBtn = [[FNCmbDoubleTextButton alloc]init];
        rightBtn.backgroundColor = [UIColor clearColor];
        [rightBtn.topLable setTitleColor:FNWhiteColor forState:(UIControlStateNormal)];
        rightBtn.topLable.titleLabel.font = kFONT14;
        [rightBtn.bottomLabel setTitleColor:FNWhiteColor forState:(UIControlStateNormal)];
        rightBtn.bottomLabel.titleLabel.font = kFONT14;
        [rightBtn.topLable setTitle:@"团队总人数" forState:(UIControlStateNormal)];
        [self addSubview:rightBtn];
        
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom).offset(15);
            make.bottom.equalTo(@-15);
            make.width.equalTo(rightBtn.mas_width);
            make.left.equalTo(@0);
            make.right.equalTo(midBtn.mas_left).offset(0);
        }];
        
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom).offset(15);
            make.bottom.equalTo(@-15);
            make.width.equalTo(midBtn.mas_width);
            make.right.equalTo(@0);
        }];
        
        [midBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom).offset(15);
            make.bottom.equalTo(@-15);
            make.width.equalTo(leftBtn.mas_width);
            make.left.equalTo(leftBtn.mas_right).offset(1);
            make.right.equalTo(rightBtn.mas_left).offset(-1);
        }];
        
        UIView *line1=[UIView new];
        line1.backgroundColor=RGB(250, 103, 130);
        [self addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom).offset(10);
            make.bottom.equalTo(@-10);
            make.width.equalTo(@1);
            make.left.equalTo(leftBtn.mas_right).offset(0);
        }];
        
        UIView *line2=[UIView new];
        line2.backgroundColor=RGB(250, 103, 130);
        [self addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom).offset(10);
            make.bottom.equalTo(@-10);
            make.width.equalTo(@1);
            make.right.equalTo(rightBtn.mas_left).offset(0);
        }];
     
        self.leftBtn=leftBtn;
        self.midBtn=midBtn;
        self.rightBtn=rightBtn;
    }
    return self;
}

-(void)setModel:(teamPullNewModel *)model{
    _model=model;
    if (_model) {
        [self.Headportrait setHeader:model.user_img];
        [self.QRCodeImage setUrlImg:model.qrcode_url];
        self.Name.text=model.username;
        
        [self.leftBtn.bottomLabel setTitle:model.p_headcount forState:(UIControlStateNormal)];
        [self.midBtn.bottomLabel setTitle:model.team_headcount forState:(UIControlStateNormal)];
        [self.rightBtn.bottomLabel setTitle:model.team_num forState:(UIControlStateNormal)];
    }
}

@end
