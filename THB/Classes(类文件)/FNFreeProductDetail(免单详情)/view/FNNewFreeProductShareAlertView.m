//
//  FNNewFreeProductShareAlertView.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNNewFreeProductShareAlertView.h"

@interface FNNewFreeProductShareAlertView()

@property (nonatomic, strong) UIButton *btnBackground;
@property (nonatomic, strong) UIView *vBorder;
@property (nonatomic, strong) NSMutableArray<UIButton*> *buttons;
@property (nonatomic, strong) ShareBlock block;

@end

@implementation FNNewFreeProductShareAlertView

#define HEIGHT 96

static FNNewFreeProductShareAlertView* _instance = nil;

- (instancetype)initWithImages: (NSArray<NSString*>*) imageUrls andTitles: (NSArray<NSString*>*) titles
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self configUI];
        
        CGFloat width = XYScreenWidth / imageUrls.count;
        for (NSInteger index = 0; index < imageUrls.count; index ++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(width * index, 0, width, HEIGHT)];
            
            [button setTitleColor:RGB(140, 140, 140) forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:11];
            [button sd_setImageWithURL:URL(imageUrls[index]) forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [button setTitle:titles[index] forState:UIControlStateNormal];
                [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
            }];
            
            [self.vBorder addSubview:button];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@(width * index));
                make.top.equalTo(@0);
                make.height.mas_equalTo(HEIGHT);
                make.width.mas_equalTo(width);
            }];
            button.tag = 1000 + index;
            [button addTarget:self action:@selector(action:)];
        }
    }
    return self;
}

- (void)action: (UITapGestureRecognizer*)sender {
    NSInteger index = sender.view.tag - 1000;
    if (_block) {
        _block(index);
    }
}

- (void)configUI {
    _btnBackground = [[UIButton alloc] init];;
    _vBorder = [[UIView alloc] init];
    
    [self addSubview:_btnBackground];
    [self addSubview:_vBorder];
    
    [_btnBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_vBorder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.mas_equalTo(0);
    }];
    self.layer.masksToBounds = YES;
    
    _btnBackground.backgroundColor = RGBA(0, 0, 0, 0.3);
    [_btnBackground addTarget:self action:@selector(close)];
    
    _vBorder.backgroundColor = UIColor.whiteColor;
    
}

- (void)close {
    [FNNewFreeProductShareAlertView dismiss];
}
+ (void)showImages: (NSArray<NSString*>*)imageUrls withTitles: (NSArray<NSString*>*)titles bottomOffset: (CGFloat)offset onClick: (ShareBlock) block {
    [FNNewFreeProductShareAlertView dismiss];
    
    if (imageUrls.count != titles.count)
        return;
    
    _instance = [[FNNewFreeProductShareAlertView alloc] initWithImages:imageUrls andTitles:titles];
    [FNKeyWindow addSubview:_instance];
    [_instance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        if (offset == 0) {
            make.bottom.equalTo(@0);
        } else {
            make.bottom.equalTo(@0).offset((isIphoneX ? -32 : 0) - offset);
        }
    }];
    
    [_instance layoutIfNeeded];
    _instance.btnBackground.alpha = 0;
    _instance.block = block;
    
    @weakify(_instance)
    [UIView animateWithDuration:0.2 animations:^{
        _instance.btnBackground.alpha = 1;
        [_instance_weak_.vBorder mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(@0);
            make.height.mas_equalTo(HEIGHT);
        }];
        [_instance layoutIfNeeded];
    }];
}


+ (void)dismiss {
    
    if (_instance) {
        [_instance removeFromSuperview];
        _instance = nil;
    }
}

@end
