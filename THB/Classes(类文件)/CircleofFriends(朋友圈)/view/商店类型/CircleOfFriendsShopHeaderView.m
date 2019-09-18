//
//  CircleOfFriendsShopHeaderView.m
//  THB
//
//  Created by Weller on 2018/12/18.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "CircleOfFriendsShopHeaderView.h"

@interface CircleOfFriendsShopHeaderView()

@property (nonatomic, strong) UIScrollView *vHeader;
@property (nonatomic, strong) NSMutableArray<UIView*> *splits;
@property (nonatomic, strong) NSMutableArray<UIButton*> *buttons;

@end

@implementation CircleOfFriendsShopHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _buttons = [[NSMutableArray alloc] init];
        _splits = [[NSMutableArray alloc] init];
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    self.backgroundView = ({
        UIView * view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = UIColor.clearColor;
        view;
    });
    
    _vHeader = [[UIScrollView alloc] init];
    [self.contentView addSubview:_vHeader];
    [_vHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.bottom.equalTo(@0);
    }];
}

- (void) setButtons: (NSArray<NSString*>*)titles {
    for (UIView *view in _vHeader.subviews) {
        [view removeFromSuperview];
    }
    [_buttons removeAllObjects];
    [_splits removeAllObjects];
    
    CGFloat padding = (XYScreenWidth - 64 * 4 - 20) / 3;
    
    for (NSInteger index = 0; index < titles.count; index++) {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:titles[index] forState:UIControlStateNormal];
        button.titleLabel.font = kFONT13;
        button.backgroundColor = FNWhiteColor;
        button.cornerRadius = 8;
        [button addTarget:self action:@selector(onClick:)];
        [_vHeader addSubview:button];
        [_buttons addObject:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (index == 0) {
                make.left.equalTo(@10);
            } else {
                make.left.equalTo(self.buttons[index - 1].mas_right).offset(padding);
            }
            
            make.top.equalTo(@4);
            make.bottom.equalTo(@-4);
            make.height.mas_equalTo(36);
            make.width.mas_equalTo(64);
        }];
        
    }
    [self setSelectedAt:0];
}

- (void)setSelectedAt: (NSInteger)index {
    for (NSInteger i = 0; i < _buttons.count; i++) {
        UIButton *button = _buttons[i];
        if (index == i) {
            [button setTitleColor: RED forState:UIControlStateNormal];
        } else {
            [button setTitleColor: RGB(155, 155, 155) forState:UIControlStateNormal];
        }
    }
}

- (void)onClick: (UITapGestureRecognizer*)sender {
    UIButton *button = (UIButton*)sender.view;
    NSInteger index = [_buttons indexOfObject:button];
    [self setSelectedAt:index];
    if (_delegate && [_delegate respondsToSelector:@selector(didHeader:selectedAt:)]) {
        [_delegate didHeader:self selectedAt:index];
    }
    
}

@end
