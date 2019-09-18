//
//  FNNewConnectionSearchHeaderView.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/6/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNNewConnectionSearchHeaderView.h"



@implementation FNNewConnectionSearchSortButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _vSort = [[UIView alloc] init];
        _lblSort = [[UILabel alloc] init];
        _imgSort = [[UIImageView alloc] init];
        _vLine = [[UIView alloc] init];
        
        [self addSubview:_vSort];
        [_vSort addSubview:_lblSort];
        [_vSort addSubview:_imgSort];
        [_vSort addSubview: _vLine];
        
        [_vSort mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(@0);
            make.left.top.greaterThanOrEqualTo(@0);
            make.right.bottom.lessThanOrEqualTo(@0);
        }];
        [_lblSort mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(@0);
            make.centerY.equalTo(@0);
            make.left.greaterThanOrEqualTo(@0);
            make.centerX.equalTo(@0);
        }];
        [_imgSort mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lblSort.mas_right).offset(4);
            make.centerY.equalTo(@0);
            make.right.lessThanOrEqualTo(@0);
        }];
        [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.height.mas_equalTo(3);
            make.width.mas_equalTo(26);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        _lblSort.textColor = RGB(102, 102, 102);
        _lblSort.font = kFONT12;
        
        _vLine.backgroundColor = RGB(98, 231, 255);
        
    }
    return self;
}

- (void)setState: (int)state {
    _state = state;
    [self updateImage];
}

- (void)setIsHasSub: (BOOL) ishasSub {
    _isHasSub = ishasSub;
    [self updateImage];
}

- (void)updateImage {
    if (_isHasSub) {
        if (_state == 0) {
            self.imgSort.image = IMAGE(@"connection_cate_second_down_normal");
        } else if (_state == 1) {
            self.imgSort.image = IMAGE(@"connection_cate_second_down_selected");
        } else if (_state == 2) {
            self.imgSort.image = IMAGE(@"connection_cate_second_up_selected");
        }
    } else {
        if (_state == 0) {
            self.imgSort.image = IMAGE(@"connection_cate_second_normal");
        } else if (_state == 1) {
            self.imgSort.image = IMAGE(@"connection_cate_down_selected");
        } else if (_state == 2) {
            self.imgSort.image = IMAGE(@"connection_cate_up_selected");
        }
    }
    _vLine.hidden = _state == 0;
//    _vLine.hidden = YES;
    
}

@end


@interface FNNewConnectionSearchHeaderView()

@property (nonatomic, strong) UIView *vSearch;

@property (nonatomic, strong) UIView *vSort;
@property (nonatomic, strong) NSMutableArray<FNNewConnectionSearchSortButton*> *buttons;

@end

@implementation FNNewConnectionSearchHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _buttons = [[NSMutableArray alloc] init];
        [self configUI];
    }
    return self;
}

- (void) configUI {
    self.backgroundView = ({
        UIView * view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = RGB(250, 250, 250);
        view;
    });
    
    _lblTips = [[UILabel alloc] init];
    _vSearch = [[UIView alloc] init];
    _txfSearch = [[UITextField alloc] init];
    _btnSearch = [[UIButton alloc] init];
    _vSort = [[UIView alloc] init];
    
    [self.contentView addSubview: _lblTips];
    [self.contentView addSubview: _vSearch];
    [_vSearch addSubview: _txfSearch];
    [_vSearch addSubview: _btnSearch];
    [self.contentView addSubview: _vSort];
    
    [_lblTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.height.mas_equalTo(24);
    }];
    [_vSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.mas_equalTo(55);
        make.top.equalTo(self.lblTips.mas_bottom);
    }];
    [_txfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.height.mas_equalTo(28);
        make.left.equalTo(@12);
        make.right.equalTo(self.btnSearch.mas_left).offset(-4);
    }];
    [_btnSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(56);
        make.right.equalTo(@-10);
    }];
    [_vSort mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vSearch.mas_bottom);
        make.left.right.bottom.equalTo(@0);
        make.height.mas_equalTo(35);
    }];
    
    _lblTips.textColor = RGB(102, 102, 102);
    _lblTips.textAlignment = NSTextAlignmentCenter;
    _lblTips.font = kFONT11;
    
    _vSort.backgroundColor = UIColor.whiteColor;
    _vSearch.backgroundColor = UIColor.whiteColor;
    
    _txfSearch.backgroundColor = RGB(244, 244, 244);
    _txfSearch.cornerRadius = 4;
    _txfSearch.font = kFONT11;
//    _txfSearch.textColor = RGB(204, 204, 204);
    [_btnSearch addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void) searchClick {
    if ([self.delegate respondsToSelector:@selector(searchView:didSearchClick:)]) {
        [self.delegate searchView: self didSearchClick:_txfSearch.text];
    }
}

- (void)configCate: (NSArray<FNNewConnectionCateSortModel*>*) cates{
    
    for (FNNewConnectionSearchSortButton *button in _buttons) {
        [button removeFromSuperview];
    }
    [_buttons removeAllObjects];
    
    for (NSInteger index = 0; index < cates.count; index++) {
        FNNewConnectionCateSortModel* sort = cates[index];
        FNNewConnectionSearchSortButton *button = [[FNNewConnectionSearchSortButton alloc] init];
        [_vSort addSubview:button];
        [_buttons addObject:button];
        
        button.lblSort.text = sort.name;
        button.isHasSub = [sort.list_cate isEqualToString:@"second_list"];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (index == 0) {
                make.left.equalTo(@0);
            } else {
                make.left.equalTo(self.buttons[index - 1].mas_right);
                make.width.equalTo(self.buttons[0]);
            }
            make.top.bottom.equalTo(@0);
            if (index == cates.count - 1) {
                make.right.equalTo(@0);
            }
        }];
        
        NSInteger i = index;
        @weakify(self)
        @weakify(button)
        [button addJXTouch:^{
            @strongify(self)
            @strongify(button)
            if ([self.delegate respondsToSelector:@selector(searchView:didCateClick:button:)]) {
                [self.delegate searchView: self didCateClick:i button: button];
            }
            
            for (FNNewConnectionSearchSortButton *btn in _buttons) {
                if (btn == button) {
                    if (button.state == 1) {
                        button.state = 2;
                    } else {
                        button.state = 1;
                    }
                } else {
                    btn.state = 0;
                }
            }
            
            
        }];
    }
    
}


- (void)resetStatus {
    for (FNNewConnectionSearchSortButton *btn in _buttons) {
        btn.state = 0;
    }
}

@end
