//
//  FNCreaditCardCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/20.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNCreaditCardCell.h"

@interface FNCreaditCardCell()

@property (nonatomic, strong) UIView *vTag;
@property (nonatomic, strong) UIView *vLine;

@property (nonatomic, strong) NSMutableArray<UIButton*> *tagButtons;
@property (nonatomic, strong) NSMutableArray<UILabel*> *tagLabels;

@end

@implementation FNCreaditCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void) configUI {
    
    _tagButtons = [[NSMutableArray alloc] init];
    _tagLabels = [[NSMutableArray alloc] init];
    
    _imgCard = [[UIImageView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblCount = [[UILabel alloc] init];
    _vTag = [[UIView alloc] init];
    _btnBuy = [[UIButton alloc] init];
    _lblBuy = [[UILabel alloc] init];
    _btnShare = [[UIButton alloc] init];
    _lblShare = [[UILabel alloc] init];
    _vLine = [[UILabel alloc] init];
    
    
    [self.contentView addSubview:_imgCard];
    [self.contentView addSubview:_lblTitle];
    [self.contentView addSubview:_lblCount];
    [self.contentView addSubview:_vTag];
    [self.contentView addSubview:_btnBuy];
    [self.contentView addSubview:_lblBuy];
    [self.contentView addSubview:_btnShare];
    [self.contentView addSubview:_lblShare];
    [self.contentView addSubview:_vLine];
    
    
    [_imgCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@12);
        make.bottom.equalTo(@-12);
        make.width.equalTo(self.imgCard.mas_height).multipliedBy(132.0/83);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgCard.mas_right).offset(12);
        make.top.equalTo(self.imgCard);
        make.right.lessThanOrEqualTo(@-10);
    }];
    [_lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgCard.mas_right).offset(12);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(6);
        make.right.lessThanOrEqualTo(@-10);
        make.height.mas_equalTo(14);
    }];
    [_vTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgCard.mas_right).offset(12);
        make.top.equalTo(self.lblCount.mas_bottom).offset(6);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(16);
    }];
    
    [_btnBuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(18);
        make.left.equalTo(self.imgCard.mas_right).offset(12);
        make.top.equalTo(self.vTag.mas_bottom).offset(8);
    }];
    [_lblBuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.btnBuy);
        make.left.equalTo(self.btnBuy.mas_left).offset(4);
        make.right.equalTo(self.btnBuy.mas_right).offset(-4);
    }];
    [_btnShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(18);
        make.left.equalTo(self.btnBuy.mas_right).offset(4);
        make.top.equalTo(self.vTag.mas_bottom).offset(8);
    }];
    [_lblShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.btnShare);
        make.left.equalTo(self.btnShare.mas_left).offset(4);
        make.right.equalTo(self.btnShare.mas_right).offset(-4);
    }];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(@0);
        make.left.equalTo(@25);
        make.height.mas_equalTo(1);
    }];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _imgCard.contentMode = UIViewContentModeScaleAspectFill;
    
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.font = kFONT14;
    
    _lblCount.textColor = RGB(153, 153, 153);
    _lblCount.font = kFONT10;
    
    _lblBuy.textColor = UIColor.whiteColor;
    _lblBuy.font = kFONT10;
    
    
    _lblShare.textColor = UIColor.whiteColor;
    _lblShare.font = kFONT10;
    
    _vLine.backgroundColor = RGB(240, 240, 240);
    
}

- (void) setTags: (NSArray<NSString*> *)tags withColor: (UIColor*)color andBg: (NSString*)bg {
    
    for (UIView *v in self.tagButtons) {
        [v removeFromSuperview];
    }
    for (UIView *v in self.tagLabels) {
        [v removeFromSuperview];
    }
    [self.tagButtons removeAllObjects];
    [self.tagLabels removeAllObjects];
    
    for (NSInteger index = 0 ; index < tags.count; index++) {
        
        NSString *tag = tags[index];
        UIButton *btnTag = [[UIButton alloc] init];
        UILabel *lblTag = [[UILabel alloc] init];
        
        [self.vTag addSubview: btnTag];
        [self.vTag addSubview: lblTag];
        
        [self.tagButtons addObject: btnTag];
        [self.tagLabels addObject: lblTag];
        
        [btnTag mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.equalTo(@0);
            if (index == 0) {
                make.left.equalTo(@0);
            } else {
                make.left.equalTo(self.tagButtons[index - 1].mas_right).offset(5);
            }
        }];
        
        [lblTag mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(btnTag);
            make.left.equalTo(btnTag).offset(4);
            make.right.equalTo(btnTag).offset(-4);
        }];
        
        lblTag.textColor = color;
        lblTag.font = kFONT10;
        lblTag.text = tag;
        [btnTag sd_setBackgroundImageWithURL:URL(bg) forState:UIControlStateNormal];
    }
}

@end
