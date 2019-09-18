//
//  FNMembershipUpgradeTopView.m
//  嗨如意
//
//  Created by Fnuo-iOS on 2018/4/20.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNMembershipUpgradeTopView.h"

@implementation FNMembershipUpgradeTopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView *BGImageView=[UIImageView new];
        [self addSubview:BGImageView];
        [BGImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(@0);
            make.bottom.equalTo(@-40);
        }];
        self.BGImageView=BGImageView;
        
        UIImageView *VipBGImageView=[UIImageView new];
        [self addSubview:VipBGImageView];
        [VipBGImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@50);
            make.left.equalTo(@10);
            make.right.equalTo(@-10);
            make.bottom.equalTo(@-0);
        }];
        self.VipBGImageView=VipBGImageView;
        
        UIImageView *HeadPortrait=[UIImageView new];
        HeadPortrait.cornerRadius=40;
        HeadPortrait.borderWidth=4;
        HeadPortrait.borderColor=FNWhiteColor;
        [self addSubview:HeadPortrait];
        [HeadPortrait mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(VipBGImageView.mas_centerX);
            make.top.equalTo(VipBGImageView.mas_top).offset(-30);
            make.width.and.height.equalTo(@80);
        }];
        self.HeadPortrait=HeadPortrait;
        
        UILabel *Label1=[UILabel new];
        Label1.font=kFONT14;
        Label1.textAlignment=NSTextAlignmentCenter;
        [self addSubview:Label1];
        [Label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(VipBGImageView.mas_centerX);
            make.top.equalTo(HeadPortrait.mas_bottom).offset(10);
        }];
        self.Label1=Label1;
        
        UIView *line1=[UIView new];
        [self addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(Label1.mas_centerY).offset(2);
            make.right.equalTo(Label1.mas_left).offset(-10);
            make.height.equalTo(@1);
            make.width.equalTo(@50);
        }];
        self.line1=line1;
        
        UIView *line2=[UIView new];
        [self addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(Label1.mas_centerY).offset(2);
            make.left.equalTo(Label1.mas_right).offset(10);
            make.height.equalTo(@1);
            make.width.equalTo(@50);
        }];
        self.line2=line2;
        
        UILabel *VipLabel=[UILabel new];
        VipLabel.font=kFONT15;
        VipLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:VipLabel];
        [VipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(VipBGImageView.mas_centerX);
            make.top.equalTo(Label1.mas_bottom).offset(5);
        }];
        self.VipLabel=VipLabel;
        
        UILabel *PhoneLabel=[UILabel new];
        PhoneLabel.font=kFONT15;
        PhoneLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:PhoneLabel];
        [PhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(VipBGImageView.mas_centerX);
            make.top.equalTo(VipLabel.mas_bottom).offset(5);
        }];
        self.PhoneLabel=PhoneLabel;
        
        UILabel *Label2=[UILabel new];
        Label2.font=kFONT13;
        Label2.textAlignment=NSTextAlignmentCenter;
        [self addSubview:Label2];
        [Label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(VipBGImageView.mas_centerX);
            make.top.equalTo(PhoneLabel.mas_bottom).offset(5);
        }];
        self.Label2=Label2;
        
        UIButton *caozuoBtn1=[UIButton new];
        [self addSubview:caozuoBtn1];
        self.caozuoBtn1=caozuoBtn1;
        
        UIButton *caozuoBtn2=[UIButton new];
        [self addSubview:caozuoBtn2];
        self.caozuoBtn2=caozuoBtn2;
    }
    return self;
}

-(void)setModel:(MembershipUpgradeModel *)Model{
    _Model=Model;
    if (_Model) {
        [self.BGImageView setNoPlaceholderUrlImg:Model.bjImg];
        [self.VipBGImageView setNoPlaceholderUrlImg:Model.conImg];
        [self.HeadPortrait setNoPlaceholderUrlImg:Model.head_img];
        
        self.Label1.text=Model.font[0].str;
        self.Label1.textColor=[NSString isEmpty:Model.font[0].font_color]?FNBlackColor:[UIColor colorWithHexString:Model.font[0].font_color];
        self.line1.backgroundColor=self.Label1.textColor;
        self.line2.backgroundColor=self.Label1.textColor;
        
        self.VipLabel.text=Model.font[1].str;
        self.VipLabel.textColor=[NSString isEmpty:Model.font[1].font_color]?FNBlackColor:[UIColor colorWithHexString:Model.font[1].font_color];
        
        self.PhoneLabel.text=Model.font[2].str;
        self.PhoneLabel.textColor=[NSString isEmpty:Model.font[2].font_color]?FNBlackColor:[UIColor colorWithHexString:Model.font[2].font_color];
        
        self.Label2.text=Model.font[3].str;
        self.Label2.textColor=[NSString isEmpty:Model.font[3].font_color]?FNBlackColor:[UIColor colorWithHexString:Model.font[3].font_color];
        
        UIImage *btnimg1=[UIImage imageWithData:[NSData dataWithContentsOfURL:URL(Model.btnImg1)]];
        UIImage *btnimg2=[UIImage imageWithData:[NSData dataWithContentsOfURL:URL(Model.btnImg2)]];
        NSLog(@"btnImg2:%@",Model.btnImg2);
        if (Model.is_hhr.integerValue==0||![Model.btnImg2 kr_isNotEmpty]) {
            [self.caozuoBtn2 removeFromSuperview];
            [self.caozuoBtn1 setBackgroundImage:btnimg1 forState:UIControlStateNormal];
            [self.caozuoBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.VipBGImageView.mas_centerX);
                make.bottom.equalTo(self.VipBGImageView.mas_bottom).offset(-20);
                make.height.equalTo(@25);
                make.width.equalTo(@(btnimg1.size.width/btnimg1.size.height*25));
            }];
        }else{
            [self.caozuoBtn1 setBackgroundImage:btnimg1 forState:UIControlStateNormal];
            [self.caozuoBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(@(-(JMScreenWidth/2+15))); make.bottom.equalTo(self.VipBGImageView.mas_bottom).offset(-20);
                make.height.equalTo(@25);
                make.width.equalTo(@(btnimg1.size.width/btnimg1.size.height*25));
            }];
            if(btnimg2){
                [self.caozuoBtn2 setBackgroundImage:btnimg2 forState:UIControlStateNormal];
                [self.caozuoBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(@(JMScreenWidth/2+15)); make.bottom.equalTo(self.VipBGImageView.mas_bottom).offset(-20);
                    make.height.equalTo(@25);
                    make.width.equalTo(@(btnimg2.size.width/btnimg2.size.height*25));
                }];
            }
        }
    }
}

@end

