//
//  FNStoreLocationRedpackAlertView.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/23.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreLocationRedpackAlertView.h"

@interface FNStoreLocationRedpackAlertView()

@property (nonatomic, strong) UIButton *btnBg;
@property (nonatomic, strong) UIButton *btnRedpack;
@property (nonatomic, strong) UIImageView *imgHeader;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;

@property (nonatomic, strong) RedpackClickBlcok clickBlock;

@end

@implementation FNStoreLocationRedpackAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _btnBg = [[UIButton alloc] init];
    _btnRedpack = [[UIButton alloc] init];
    _imgHeader = [[UIImageView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    
    [self addSubview:_btnBg];
    [self addSubview:_btnRedpack];
    [self addSubview:_imgHeader];
    [self addSubview:_lblTitle];
    [self addSubview:_lblDesc];
    
    [_btnBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_btnRedpack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.center.equalTo(@0);
    }];
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnRedpack).offset(54);
        make.centerX.equalTo(@0);
        make.width.height.mas_equalTo(72);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgHeader.mas_bottom).offset(15);
        make.centerX.equalTo(@0);
        make.left.greaterThanOrEqualTo(self.btnRedpack).offset(40);
        make.right.lessThanOrEqualTo(self.btnRedpack).offset(-40);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lblTitle.mas_bottom).offset(8);
        make.centerX.equalTo(@0);
        make.left.greaterThanOrEqualTo(self.btnRedpack).offset(40);
        make.right.lessThanOrEqualTo(self.btnRedpack).offset(-40);
    }];
    
    _btnBg.backgroundColor = RGBA(51, 51, 51, 0.2);
    
    _imgHeader.cornerRadius = 36;
    
    _lblTitle.textColor = UIColor.whiteColor;
    _lblTitle.font = [UIFont boldSystemFontOfSize:18];
    
    _lblDesc.textColor = UIColor.whiteColor;
    _lblDesc.font = kFONT14;
    
    [_btnBg addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_btnRedpack addTarget:self action:@selector(clickRedpack) forControlEvents:UIControlEventTouchUpInside];
    
    self.hidden = YES;
}

- (void)showModel: (FNStoreLocationRedpackDetailModel*)model block: (RedpackClickBlcok)block {
    
    _clickBlock = block;
    
    _lblTitle.text = model.store_name;
    _lblTitle.textColor = [UIColor colorWithHexString:model.color];
    _lblDesc.text = model.info;
    _lblDesc.textColor = [UIColor colorWithHexString:model.color];
    [_imgHeader sd_setImageWithURL:URL(model.store_img)];
    @weakify(self)
    [_btnRedpack sd_setBackgroundImageWithURL:URL(model.bjimg) forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self)
        if (image) {
            [self.btnRedpack mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo((self.bounds.size.width - 40) * image.size.height / image.size.width);
            }];
            self.hidden = NO;
        }
    }];
    
    
}

- (void)dismiss {
    self.hidden = YES;
}

- (void)clickRedpack {
    
    if (_clickBlock) {
        _clickBlock();
    }
    
}

@end
