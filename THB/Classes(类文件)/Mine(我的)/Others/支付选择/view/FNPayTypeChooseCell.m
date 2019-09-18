//
//  FNPayTypeChooseCell.m
//  THB
//
//  Created by Fnuo-iOS on 2018/6/15.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNPayTypeChooseCell.h"

@implementation FNPayTypeChooseCell

#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *reuseIdentifier = @"FNPayTypeChooseCell";
    FNPayTypeChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNPayTypeChooseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
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
        self.backgroundColor=FNWhiteColor;
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        
        [self InitializeView];
    }
    return self;
}

-(void)InitializeView{
    UIImageView *Icon=[UIImageView new];
    Icon.cornerRadius=5;
    [self addSubview:Icon];
    [Icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@10);
        make.bottom.equalTo(@-10);
        make.width.equalTo(Icon.mas_height);
    }];
    self.Icon=Icon;
    
    UIImageView *choose=[[UIImageView alloc]initWithImage:IMAGE(@"vip_choose_off")];
    [self addSubview:choose];
    [choose sizeToFit];
    [choose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(@-10);
        make.width.equalTo(@(choose.width));
        make.height.equalTo(@(choose.height));
    }];
    self.choose=choose;
    
    UILabel *TopLabel=[UILabel new];
    TopLabel.textColor=FNBlackColor;
    TopLabel.font=kFONT15;
    [self addSubview:TopLabel];
    [TopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Icon.mas_right).offset(10);
        make.right.equalTo(choose.mas_left).offset(-10);
        make.top.equalTo(Icon.mas_top).offset(5);
    }];
    self.TopLabel=TopLabel;
    
    UILabel *BtmLabel=[UILabel new];
    BtmLabel.textColor=FNGlobalTextGrayColor;
    BtmLabel.font=kFONT13;
    [self addSubview:BtmLabel];
    [BtmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Icon.mas_right).offset(10);
        make.right.equalTo(choose.mas_left).offset(-10);
        make.bottom.equalTo(Icon.mas_bottom).offset(-5);
    }];
    self.BtmLabel=BtmLabel;
}

-(void)setPayModel:(PayTypeModel *)PayModel{
    _PayModel=PayModel;
    if (_PayModel) {
        [self.Icon setUrlImg:PayModel.img];
        self.TopLabel.text=PayModel.name;
        self.BtmLabel.text=PayModel.str;
        if (PayModel.isSelected==YES) {
            self.choose.image=IMAGE(@"vip_choose_on");
        }else{
            self.choose.image=IMAGE(@"vip_choose_off");
        }
    }
}

-(void)setCardPayModel:(FNMyCardPayTypeModel *)PayModel{
    _CardPayModel=PayModel;
    if (_CardPayModel) {
        [self.Icon setUrlImg:PayModel.img];
        self.TopLabel.text=PayModel.str;
        self.BtmLabel.text=PayModel.val;
        if (PayModel.isSelected==YES) {
            self.choose.image=IMAGE(@"vip_choose_on");
        }else{
            self.choose.image=IMAGE(@"vip_choose_off");
        }
    }
}

@end
