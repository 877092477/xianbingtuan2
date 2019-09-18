//
//  FNStoreManagerGoodsHeaderView.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/9.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreManagerGoodsHeaderView.h"

@interface FNStoreManagerGoodsHeaderView()



@end

@implementation FNStoreManagerGoodsHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _lblTitle = [[UILabel alloc] init];
    _btnSort = [[UIButton alloc] init];
    
    [self.contentView addSubview:_lblTitle];
    [self.contentView addSubview:_btnSort];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.centerY.equalTo(@0);
        make.right.lessThanOrEqualTo(self.btnSort.mas_left).offset(-20);
    }];
    [_btnSort mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.top.bottom.equalTo(@0);
        make.width.mas_equalTo(50);
    }];
    
//    self.backgroundColor = UIColor.whiteColor;
    self.backgroundView = ({
        UIView * view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = UIColor.whiteColor;
        view;
    });
    
    _lblTitle.textColor = RGB(204, 204, 204);
    _lblTitle.font = kFONT11;
    
    [_btnSort setTitleColor: RGB(51, 51, 51) forState: UIControlStateNormal];
    [_btnSort setTitle: @"排序" forState: UIControlStateNormal];
    _btnSort.titleLabel.font = kFONT10;
    [_btnSort addTarget:self action:@selector(onSortClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onSortClick {
    if ([_delegate respondsToSelector:@selector(headerViewDidSortClick:)]) {
        [_delegate headerViewDidSortClick:self];
    }
}

@end
