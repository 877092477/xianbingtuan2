//
//  FNVideoMarketingHeaderCell.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNVideoMarketingHeaderCell.h"

@interface FNVideoMarketingHeaderCell()

@property (nonatomic, strong) UIView *vBackground;
@property (nonatomic, strong) UIImageView *imgTitle;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIButton *btnMore;

@end

@implementation FNVideoMarketingHeaderCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _vBackground = [[UIView alloc] init];
    _imgTitle = [[UIImageView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _btnMore = [[UIButton alloc] init];
    
    [self addSubview:_vBackground];
    [self addSubview: _imgTitle];
    [self addSubview: _lblTitle];
    [self addSubview: _btnMore];
    
    [_vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_imgTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.height.mas_equalTo(30);
        make.centerY.equalTo(@0);
        make.width.mas_equalTo(0);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgTitle.mas_right).offset(6);
        make.bottom.equalTo(self.imgTitle).offset(-5);
        make.right.lessThanOrEqualTo(self.btnMore.mas_left).offset(-10);
    }];
    [_btnMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-14);
        make.centerY.equalTo(@0);
    }];
    
    _vBackground.backgroundColor = UIColor.whiteColor;
    
    _imgTitle.contentMode = UIViewContentModeScaleAspectFill;
    
    _lblTitle.textColor = RGB(153, 153, 153);
    _lblTitle.font = kFONT12;
    
    [_btnMore setTitle:@"更多>" forState:UIControlStateNormal];
    [_btnMore setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    _btnMore.titleLabel.font = kFONT15;
    [_btnMore addTarget:self action:@selector(onMoreClick)];
}

- (void)setImage: (nullable NSString*)imgUrl withTitle: (NSString*)title isMoreShow: (BOOL)isShow {
    if (imgUrl) {
        @weakify(self)
        [XYNetworkAPI downloadImages:@[imgUrl] withFinishedBlock:^(NSArray<UIImage *> *images) {
            @strongify(self)
            UIImage *image = images.firstObject;
            if (image) {
                self.imgTitle.image = image;
                [self.imgTitle mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(30 / image.size.height * image.size.width);
                }];
            }
        }];
    }
    _lblTitle.text = title;
    _btnMore.hidden = !isShow;
}

- (void)onMoreClick {
    if ([_delegate respondsToSelector: @selector(headerdidMoreClick:)]) {
        [_delegate headerdidMoreClick:self];
    }
}
@end
