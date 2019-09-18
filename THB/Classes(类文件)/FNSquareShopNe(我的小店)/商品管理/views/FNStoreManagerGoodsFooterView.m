//
//  FNStoreManagerGoodsFooterView.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/10.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreManagerGoodsFooterView.h"

@interface FNStoreManagerGoodsFooterView()


@end

@implementation FNStoreManagerGoodsFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _btnAdd = [[UIButton alloc] init];
    _btnAdd.titleLabel.font = kFONT12;
    _btnAdd.backgroundColor = UIColor.whiteColor;
    [_btnAdd setTitleColor:RGB(255, 102, 102) forState: UIControlStateNormal];
    [_btnAdd setTitle: @"添加商品" forState: UIControlStateNormal];
    [_btnAdd setImage: IMAGE(@"store_manager_button_add_red") forState: UIControlStateNormal];
    [_btnAdd layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:8];
    [_btnAdd addTarget:self action:@selector(onAddClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.backgroundView = ({
        UIView * view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = UIColor.clearColor;
        view;
    });
    
    [self.contentView addSubview:_btnAdd];
    
    [_btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.top.bottom.equalTo(@0);
    }];
}

- (void)onAddClick {
    if ([_delegate respondsToSelector:@selector(footerViewDidAddClick:)]) {
        [_delegate footerViewDidAddClick:self];
    }
}

@end
