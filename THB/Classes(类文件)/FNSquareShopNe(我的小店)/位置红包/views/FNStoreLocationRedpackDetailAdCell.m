//
//  FNStoreLocationRedpackDetailAdCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/29.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreLocationRedpackDetailAdCell.h"

@interface FNStoreLocationRedpackDetailAdCell()

@property (nonatomic, strong) UIButton *btnClose;

@end

@implementation FNStoreLocationRedpackDetailAdCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _imgAd = [[UIImageView alloc] init];
    _btnClose = [[UIButton alloc] init];
    
    [self.contentView addSubview:_imgAd];
    [self.contentView addSubview:_btnClose];
    
    [_imgAd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [_btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@12);
        make.right.equalTo(@-12);
    }];
    
    [_btnClose setImage: IMAGE(@"store_location_button_close") forState: UIControlStateNormal];
    [_btnClose addTarget:self action:@selector(didCloseClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didCloseClick {
    if ([_delegate respondsToSelector:@selector(adCellDidClose:)]) {
        [_delegate adCellDidClose:self];
    }
}

@end
