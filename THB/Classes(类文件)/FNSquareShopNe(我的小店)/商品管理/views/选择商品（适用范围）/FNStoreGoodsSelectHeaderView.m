//
//  FNStoreGoodsSelectHeaderView.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/16.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreGoodsSelectHeaderView.h"

@interface FNStoreGoodsSelectHeaderView()

@property (nonatomic, strong) UIButton *btnSelected;

@end

@implementation FNStoreGoodsSelectHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _lblTitle = [[UILabel alloc] init];
    _btnSelected = [[UIButton alloc] init];
    
    [self.contentView addSubview:_lblTitle];
    [self.contentView addSubview:_btnSelected];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.centerY.equalTo(@0);
        make.right.lessThanOrEqualTo(self.btnSelected.mas_left).offset(-20);
    }];
    [_btnSelected mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.top.bottom.equalTo(@0);
        make.width.mas_equalTo(80);
    }];
    
    //    self.backgroundColor = UIColor.whiteColor;
    self.backgroundView = ({
        UIView * view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = UIColor.whiteColor;
        view;
    });
    
    _lblTitle.textColor = RGB(204, 204, 204);
    _lblTitle.font = kFONT11;
    
    [_btnSelected setTitleColor: RGB(51, 51, 51) forState: UIControlStateNormal];
    [_btnSelected setTitle: @"全选" forState: UIControlStateNormal];
    [_btnSelected setImage: IMAGE(@"store_goods_select_check_disabled") forState: UIControlStateNormal];
    _btnSelected.titleLabel.font = kFONT10;
    [_btnSelected addTarget:self action:@selector(onSelectClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnSelected layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:7];
}


- (void)setIsSelected: (BOOL)isSelected {
    if (isSelected) {
        [_btnSelected setImage: IMAGE(@"store_goods_select_check_enabled") forState: UIControlStateNormal];
    } else {
        
        [_btnSelected setImage: IMAGE(@"store_goods_select_check_disabled") forState: UIControlStateNormal];
    }
    
}

- (void)onSelectClick {
    if ([_delegate respondsToSelector:@selector(didAllClick:)]) {
        [_delegate didAllClick:self];
    }
}


@end
