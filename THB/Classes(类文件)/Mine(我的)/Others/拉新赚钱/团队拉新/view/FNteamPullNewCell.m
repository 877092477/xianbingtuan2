//
//  FNteamPullNewCell.m
//  嗨如意
//
//  Created by Fnuo-iOS on 2018/5/10.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNteamPullNewCell.h"

@implementation FNteamPullNewCell

#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *reuseIdentifier = @"FNteamPullNewCell";
    FNteamPullNewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNteamPullNewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIButton *NumBtn=[UIButton new];
        NumBtn.userInteractionEnabled=NO;
        NumBtn.titleLabel.font=kFONT14;
        [NumBtn setTitleColor:FNBlackColor forState:UIControlStateNormal];
        [self addSubview:NumBtn];
        [NumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.centerY.equalTo(self.mas_centerY);
            make.height.width.equalTo(@40);
        }];
        self.NumBtn=NumBtn;
        
        UIImageView *Headportrait=[UIImageView new];
        Headportrait.cornerRadius=30;
        [self addSubview:Headportrait];
        [Headportrait mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(NumBtn.mas_right).offset(0);
            make.centerY.equalTo(self.mas_centerY);
            make.height.width.equalTo(@60);
        }];
        self.Headportrait=Headportrait;
        
        UILabel *Name=[UILabel new];
        Name.textColor=FNGlobalTextGrayColor;
        Name.font=kFONT14;
        [self addSubview:Name];
        [Name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(Headportrait.mas_right).offset(10);
            make.centerY.equalTo(self.mas_centerY);
        }];
        self.Name=Name;
        
        UILabel *popNum=[UILabel new];
        popNum.textColor=FNBlackColor;
        popNum.font=kFONT14;
        [self addSubview:popNum];
        [popNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-15);
            make.centerY.equalTo(self.mas_centerY);
        }];
        self.popNum=popNum;
    }
    return self;
}

-(void)setModel:(teamPullNewListModel *)model{
    _model=model;
    if (_model) {
        [self.Headportrait setHeader:model.head_img];
        self.Name.text=model.nickname;
        self.popNum.text=[NSString stringWithFormat:@"%@人",model.headcount];
    }
}

@end
