//
//  FNPullNewDetailCell.m
//  THB
//
//  Created by Fnuo-iOS on 2018/5/10.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNPullNewDetailCell.h"

@implementation FNPullNewDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *reuseIdentifier = @"FNPullNewDetailCell";
    FNPullNewDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNPullNewDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
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
        
        FNPullNewDetailMidView* midView=[FNPullNewDetailMidView new];
        midView.backgroundColor=FNHomeBackgroundColor;
        [self addSubview:midView];
        [midView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(@40);
            make.bottom.equalTo(@-40);
        }];
        self.midView=midView;
        
        UIImage *regimg=IMAGE(@"friends_fp");
        UIImageView *reg=[[UIImageView alloc]initWithImage:regimg];
        [self addSubview:reg];
        [reg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.left.equalTo(@10);
            make.height.equalTo(@20);
            make.width.equalTo(@(regimg.size.width/regimg.size.height*20));
        }];
        
        UIImage *firstPurchaseimg=IMAGE(@"friends_fpo");
        UIImageView *firstPurchase=[[UIImageView alloc]initWithImage:regimg];
        [self addSubview:firstPurchase];
        [firstPurchase mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.left.equalTo(reg.mas_right).offset(5);
            make.height.equalTo(@20);
            make.width.equalTo(@(firstPurchaseimg.size.width/firstPurchaseimg.size.height*20));
        }];
        self.firstPurchase=firstPurchase;
        
        UIButton* phoneBtn=[UIButton new];
        phoneBtn.userInteractionEnabled=NO;
        phoneBtn.titleLabel.font=kFONT13;
        [phoneBtn setTitleColor:FNBlackColor forState:UIControlStateNormal];
        [phoneBtn setImage:IMAGE(@"friends_phone") forState:UIControlStateNormal];
        [self addSubview:phoneBtn];
        [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.right.equalTo(@-10);
            make.height.equalTo(@20);
        }];
        self.phoneBtn=phoneBtn;
        
        UILabel* union_id=[UILabel new];
        union_id.font=kFONT13;
        union_id.textColor=FNGlobalTextGrayColor;
        [self addSubview:union_id];
        [union_id mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@-10);
            make.left.equalTo(@10);
            make.height.equalTo(@20);
        }];
        self.union_id=union_id;
        
        UILabel* member_id=[UILabel new];
        member_id.font=kFONT13;
        member_id.textColor=FNGlobalTextGrayColor;
        [self addSubview:member_id];
        [member_id mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@-10);
            make.right.equalTo(@-10);
            make.height.equalTo(@20);
        }];
        self.member_id=member_id;
    }
    return self;
}

-(void)setModel:(PullNewDetailListModel *)model{
    _model=model;
    if (_model) {
        self.midView.leftTime.text=model.register_time;
        self.midView.midTime.text=model.bind_time;
        self.midView.rightTime.text=model.buy_time;
        
        self.firstPurchase.image=IMAGE(@"friends_fpo");
        if ([model.status integerValue]==4) {
            self.firstPurchase.image=IMAGE(@"friends_register");
        }

        [self.phoneBtn setTitle:[NSString stringWithFormat:@" %@",model.phone] forState:UIControlStateNormal];
        
        self.union_id.text=[NSString stringWithFormat:@"分享用户(unionId):%@",model.union_id];
        [self.union_id addSingleAttributed:@{NSForegroundColorAttributeName:FNMainGobalTextColor} ofRange:[self.union_id.text rangeOfString:model.union_id]];
        self.member_id.text=[NSString stringWithFormat:@"来源媒体id:%@",model.member_id];
        [self.member_id addSingleAttributed:@{NSForegroundColorAttributeName:FNMainGobalTextColor} ofRange:[self.member_id.text rangeOfString:model.member_id]];

    }
}

@end
