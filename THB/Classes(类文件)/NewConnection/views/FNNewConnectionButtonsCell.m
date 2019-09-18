//
//  FNNewConnectionButtonsCell.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/6/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNNewConnectionButtonsCell.h"
#import "FNNewConnectionContactButton.h"

@interface FNNewConnectionButtonsCell()<FNNewConnectionContactButtonDelegate>

@property (nonatomic, strong) UIView *vBackground;
@property (nonatomic, strong) UIView *vLine;

@property (nonatomic, strong) NSMutableArray<FNNewConnectionContactButton*> *buttons;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSArray *counts;
@property (nonatomic, strong) UIView *vButtons;
@property (nonatomic, strong) MineIconsBlock onClick;

@end

@implementation FNNewConnectionButtonsCell

//每行数量
#define RowCount 5
//icon行高
#define RowHeight 100

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _buttons = [[NSMutableArray alloc] init];
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _vBackground = [[UIView alloc] init];
    _imgBackground = [[UIImageView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _btnChat = [[UIButton alloc] init];
    _vLine = [[UIView alloc] init];
    _vButtons = [[UIView alloc] init];
    
    
    [self.contentView addSubview:_vBackground];
    [_vBackground addSubview:_imgBackground];
    [_vBackground addSubview:_lblTitle];
    [_vBackground addSubview:_btnChat];
    [_vBackground addSubview:_vLine];
    [_vBackground addSubview:_vButtons];
    
    [_vBackground mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(0, 0, 0, 0));
//        make.height.mas_equalTo(116);
    }];
    [_imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@10);
        make.right.lessThanOrEqualTo(self.btnChat.mas_left).offset(-10);
        make.height.mas_equalTo(28);
    }];
    [_btnChat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.centerY.equalTo(self.lblTitle);
    }];
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@28);
        make.left.right.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    [_vButtons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.vLine.mas_bottom).offset(10);
        make.bottom.equalTo(@-10);
        make.height.mas_equalTo(0);
    }];
    
    self.backgroundColor = UIColor.clearColor;
    
    _vLine.backgroundColor = RGB(240, 240, 240);
    
//    _lblTitle.text = @"我的推荐人";
    _lblTitle.font = kFONT11;
    _lblTitle.textColor = RGB(102, 102, 102);
    _lblTitle.textAlignment = NSTextAlignmentCenter;
    
//    [_btnChat setTitle:@"查看更多>" forState:UIControlStateNormal];
    [_btnChat setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    _btnChat.titleLabel.font = kFONT11;
    [_btnChat addTarget:self action:@selector(clickMore) forControlEvents:UIControlEventTouchUpInside];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void) setPadding: (CGFloat)padding {
    [_vBackground mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(padding, padding, 0, padding));
    }];
}

- (void) clickMore {
    if ([_delegate respondsToSelector: @selector(cellDidMoreClick:)]) {
        [_delegate cellDidMoreClick: self];
    }
}


- (void)reloadData {
    for (FNNewConnectionContactButton *view in _buttons) {
        [view removeFromSuperview];
    }
    [_buttons removeAllObjects];
    
    CGFloat padding = 10;
    
    for (NSInteger index = 0; index < _titles.count; index ++) {
        FNNewConnectionContactButton *button = [[FNNewConnectionContactButton alloc] init];
        [button.imgIcon sd_setImageWithURL:_images[index]];
        button.lblTitle.text = _titles[index];
        button.lblTitle.textColor = RGB(168, 173, 186);
        button.lblTitle.font = [UIFont systemFontOfSize:11];
        [button setCount: _counts[index]];
        NSInteger colum = index % RowCount;
        NSInteger row = index / RowCount;
        
        [_vButtons addSubview:button];
        [_buttons addObject:button];
        button.delegate = self;
        if (_colors.count > index)
            button.lblTitle.textColor = _colors[index];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (colum == 0) {
                make.left.equalTo(@(padding));
            } else {
                make.left.equalTo(_buttons[index - 1].mas_right).offset(padding);
            }
            if (colum == RowCount - 1) {
                make.right.equalTo(@(-padding));
            }
            make.width.equalTo(self.vButtons.mas_width).dividedBy(RowCount).offset(-padding);
            make.height.mas_equalTo(RowHeight);
            if (row == 0) {
                make.top.equalTo(@0);
            } else {
                make.top.equalTo(self.buttons[index - RowCount].mas_bottom);
            }
            //            make.bottom.lessThanOrEqualTo(_vButtons);
        }];
    }
    
    if (_buttons.count > 0) {
        NSLog(@"%ld", RowHeight * (((_titles.count - 1) / RowCount) + 1));
        [_vButtons mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(RowHeight * (((_titles.count - 1) / RowCount) + 1));
        }];
    }
}

- (void)showWithImages: (NSArray*)imgUrls andTitles: (NSArray*)titles andColors: (NSArray*)colors counts: (NSArray*)counts clickBlock: (MineIconsBlock) onClick {
    if (imgUrls == nil || titles == nil || imgUrls.count != titles.count)
        return;
    self.images = imgUrls;
    self.titles = titles;
    self.colors = colors;
    self.counts = counts;
    self.onClick = onClick;
    [self reloadData];
}

- (void)didIconClick: (FNNewConnectionContactButton*)icon {
    
    NSInteger index = [_buttons indexOfObject:icon];
    if ([_delegate respondsToSelector:@selector(cell: didButtonClickAt:)]) {
        [_delegate cell: self didButtonClickAt: index];
    }
}

@end
