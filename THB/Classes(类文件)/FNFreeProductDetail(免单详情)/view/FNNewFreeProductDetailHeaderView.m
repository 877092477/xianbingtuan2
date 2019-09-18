//
//  FNNewFreeProductDetailHeaderView.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNNewFreeProductDetailHeaderView.h"
#import "SDCycleScrollView/SDCycleScrollView.h"

@interface FNNewFreeProductDetailHeaderView()

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) UIView        *vImage;

@property (nonatomic, strong) UIView        *vContent;

@property (nonatomic, strong) UIView        *vLine;
@property (nonatomic, strong) UIView        *vDetail;
@property (nonatomic, strong) UIView        *vLine2;
@property (nonatomic, strong) UILabel       *lblDetailTitle;

@end

@implementation FNNewFreeProductDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _vImage = [[UIView alloc] init];
    _vContent = [[UIView alloc] init];
    _lblPrice = [[UILabel alloc] init];
    _vMsg = [[UIView alloc] init];
    _lblMsg = [[UILabel alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblPeople = [[UILabel alloc] init];
    _lblCount = [[UILabel alloc] init];
    
    _vLine = [[UIView alloc] init];;
    _vDetail = [[UIView alloc] init];;
    _vLine2 = [[UIView alloc] init];;
    _lblDetailTitle = [[UILabel alloc] init];;
    
    [self addSubview: _vImage];
    [self addSubview: _vContent];
    [_vContent addSubview: _lblPrice];
    [_vContent addSubview: _vMsg];
    [_vMsg addSubview: _lblMsg];
    [_vContent addSubview: _lblTitle];
    [_vContent addSubview: _lblPeople];
    [_vContent addSubview: _lblCount];
    
    [self addSubview:_vLine];
    [self addSubview:_vDetail];
    [_vDetail addSubview:_vLine2];
    [_vDetail addSubview:_lblDetailTitle];
    
    [_vImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.height.equalTo(self.vImage.mas_width);
    }];
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.vImage.mas_bottom);
//        make.bottom.equalTo(@0);
//        make.height.equalTo
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.top.equalTo(@14);
        make.height.mas_equalTo(20);
    }];
    [_vMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lblPrice);
        make.left.equalTo(self.lblPrice.mas_right).offset(8);
        make.right.lessThanOrEqualTo(@-14);
        make.height.mas_equalTo(16);
    }];
    [_lblMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@4);
        make.right.equalTo(@-4);
        make.centerY.equalTo(@0);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(self.lblPrice.mas_bottom).offset(10);
        make.right.lessThanOrEqualTo(@-10);
    }];
    [_lblPeople mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.bottom.equalTo(@-10);
        make.top.greaterThanOrEqualTo(self.lblTitle.mas_bottom).offset(4);
    }];
    [_lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.bottom.equalTo(@-10);
    }];
    
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vContent.mas_bottom);
        make.left.right.equalTo(@0);
        make.height.mas_equalTo(10);
    }];
    [_vDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vLine.mas_bottom);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.mas_equalTo(34);
    }];
    [_vLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(@0);
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(2);
    }];
    [_lblDetailTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vLine2.mas_right).offset(10);
        make.centerY.equalTo(@0);
        make.right.lessThanOrEqualTo(@-10);
    }];
    
    
    self.vContent.backgroundColor = UIColor.whiteColor;
    
    _lblPrice.font = [UIFont systemFontOfSize:18];
    _lblPrice.textColor = RGB(255, 38, 38);
    
    _vMsg.backgroundColor = RGB(255, 219, 219);
    _vMsg.cornerRadius = 2.5;
    
    _lblMsg.textColor = RGB(255, 38, 38);
    _lblMsg.font = kFONT11;
    
    _lblTitle.textColor = RGB(60, 60, 60);
    _lblTitle.font = kFONT14;
    _lblTitle.numberOfLines = 2;
    
    _lblPeople.textColor = RGB(200, 200, 200);
    _lblPeople.font = kFONT12;
    
    _lblCount.textColor = RGB(200, 200, 200);
    _lblCount.font = kFONT12;
    
    _vLine.backgroundColor = RGB(245, 245, 245);
    
    _vDetail.backgroundColor = UIColor.whiteColor;
    _vLine2.backgroundColor = RGB(255, 38, 38);
    
    _lblDetailTitle.text = @"商品详情";
    _lblDetailTitle.font = [UIFont boldSystemFontOfSize:14];
    _lblDetailTitle.textColor = RGB(60, 60, 60);
    
    
    
}

- (void) setImages: (NSArray*) images {
    if (_cycleScrollView)
        [_cycleScrollView removeFromSuperview];
    
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:_vImage.frame imageURLStringsGroup:images];
    _cycleScrollView.autoScrollTimeInterval = 15;
    [_vImage addSubview:_cycleScrollView];
    [_cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}


@end
