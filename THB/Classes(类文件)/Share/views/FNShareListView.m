//
//  FNShareListView.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/4.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNShareListView.h"

@interface FNShareListView()

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIView *vLine1;
@property (nonatomic, strong) UIView *vLine2;

@property (nonatomic, strong) UIView *vContent;

@property (nonatomic, strong) NSMutableArray<UIButton*> *shareButtons;

@end

@implementation FNShareListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _shareButtons = [[NSMutableArray alloc] init];
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    _lblTitle = [[UILabel alloc] init];
    _vLine1 = [[UIView alloc] init];
    _vLine2 = [[UIView alloc] init];
    _vContent = [[UIView alloc] init];
    
    [self addSubview:_lblTitle];
    [self addSubview:_vLine1];
    [self addSubview:_vLine2];
    [self addSubview:_vContent];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.height.mas_equalTo(20);
        make.centerX.equalTo(@0);
    }];
    [_vLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lblTitle.mas_left).offset(-20);
        make.centerY.equalTo(self.lblTitle);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(60);
    }];
    [_vLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblTitle.mas_right).offset(20);
        make.centerY.equalTo(self.lblTitle);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(60);
    }];
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(20);
        make.bottom.equalTo(@-20);
//        make.height.mas_equalTo(130);
    }];
    
    _lblTitle.text = @"———        图文分享到        ———";
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.font = kFONT12;
    
}

- (void)setImages: (NSArray<NSString*>*) images withTitles: (NSArray<NSString*>*) titles {
    
    if (images.count != titles.count) {
        return;
    }
    
    for (UIButton *button in _shareButtons) {
        [button removeFromSuperview];
    }
    [_shareButtons removeAllObjects];
    
    for (NSInteger index = 0; index < images.count; index ++) {
        UIButton *btnShare = [[UIButton alloc] init];
        [self.vContent addSubview:btnShare];
        [self.shareButtons addObject:btnShare];
        
        [btnShare mas_makeConstraints:^(MASConstraintMaker *make) {
            if (index == 0) {
                make.left.equalTo(@0);
            } else {
                make.left.equalTo(self.shareButtons[index - 1].mas_right);
                make.width.equalTo(self.shareButtons[index - 1]);
            }
            if (index == images.count - 1) {
                make.right.equalTo(@0);
            }
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
            
        }];
        
        UIImageView *imgIcon = [[UIImageView alloc] init];
        [btnShare addSubview:imgIcon];
        
        UILabel *lblTitle = [[UILabel alloc] init];
        [btnShare addSubview:lblTitle];
        
        [imgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(btnShare);
            make.centerY.equalTo(btnShare).offset(-10);
            make.width.height.mas_equalTo(50);
        }];
        
        [lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(btnShare);
            make.top.equalTo(imgIcon.mas_bottom).offset(10);
            make.left.greaterThanOrEqualTo(btnShare).offset(4);
            make.right.lessThanOrEqualTo(btnShare).offset(-4);
        }];
        
        lblTitle.text = titles[index];
        lblTitle.textColor = RGB(153, 153, 153);
        lblTitle.font = kFONT10;
        
        [imgIcon sd_setImageWithURL:URL(images[index])];
        
        [btnShare addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)shareClick: (UIButton*)sender {
    NSInteger index = [self.shareButtons indexOfObject:sender];
    if ([self.delegate respondsToSelector:@selector(shareListView:didClickAt:)]) {
        [self.delegate shareListView:self didClickAt:index];
    }
}

@end
