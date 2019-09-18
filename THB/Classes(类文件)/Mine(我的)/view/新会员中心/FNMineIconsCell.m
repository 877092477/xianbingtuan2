//
//  FNMineIconsCell.m
//  THB
//
//  Created by Weller Zhao on 2018/12/25.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNMineIconsCell.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "FNMineIcon.h"

@interface FNMineIconsCell()<FNMineIconDelegate>
@property (nonatomic, strong) UIView *vBackground;
@property (nonatomic, strong) UIImageView *imgBackground;

@property (nonatomic, strong) UIView *vHeader;
@property (nonatomic, strong) UIView *vLine;
@property (nonatomic, strong) UILabel *lblTitle;

@property (nonatomic, strong) UIView *vButtons;
@property (nonatomic, strong) NSMutableArray<FNMineIcon*> *buttons;

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) MineIconsBlock onClick;

@end

@implementation FNMineIconsCell


//每行数量
#define RowCount 4
//icon行高
#define RowHeight 100

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _buttons = [[NSMutableArray alloc] init];
        [self configUI];
    }
    return self;
}


- (void)configUI {
    _onClick = nil;
    self.backgroundColor = UIColor.clearColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _imgBackground = [[UIImageView alloc] init];
    [self.contentView addSubview:_imgBackground];
    
    _vBackground = [[UIView alloc] init];
    [self.contentView addSubview:_vBackground];
    
    _vHeader = [[UIView alloc] init];
    [_vBackground addSubview:_vHeader];
    
    _lblTitle = [[UILabel alloc] init];
    [_vHeader addSubview:_lblTitle];
    _vLine = [[UIView alloc] init];
    [_vHeader addSubview:_vLine];
    
    _vButtons = [[UIView alloc] init];
    [_vBackground addSubview:_vButtons];
    [_vButtons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(_vBackground);
        make.top.equalTo(_vHeader.mas_bottom);
        make.height.mas_equalTo(0);
    }];
    
//    _vBackground.backgroundColor = UIColor.whiteColor;
    [_vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 10, 10, 10));
        //        make.height.mas_equalTo(200);
        //        make.bottom.greaterThanOrEqualTo(_vHeader);
    }];
//    _vBackground.cornerRadius = 10;
    [_imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_vBackground);
    }];
    
    [_vHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(_vBackground);
        make.height.mas_equalTo(40);
    }];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vHeader).offset(18);
        //        make.top.equalTo(_vBackground).offset(14);
        make.centerY.equalTo(_vHeader);
        make.right.lessThanOrEqualTo(_vBackground).offset(-18);
    }];
    _lblTitle.font = [UIFont systemFontOfSize:14];
    _lblTitle.textColor = RGB(83, 92, 113);
    
    [_vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vHeader).offset(18);
        make.right.equalTo(_vHeader).offset(-18);
        make.bottom.equalTo(_vHeader);
        make.height.mas_equalTo(1);
    }];
    _vLine.backgroundColor = RGB(242, 242, 242);
    
}

- (void)reloadData {
    for (FNMineIcon *view in _buttons) {
        [view removeFromSuperview];
    }
    [_buttons removeAllObjects];
    
    for (NSInteger index = 0; index < _titles.count; index ++) {
        FNMineIcon *button = [[FNMineIcon alloc] init];
        [button.imgIcon sd_setImageWithURL:_images[index]];
        button.lblTitle.text = _titles[index];
        button.lblTitle.textColor = RGB(168, 173, 186);
        button.lblTitle.font = [UIFont systemFontOfSize:11];
        NSInteger colum = index % RowCount;
        NSInteger row = index / RowCount;
        
        [_vButtons addSubview:button];
        [_buttons addObject:button];
        button.delegate = self;
        if (_colors.count > index)
            button.lblTitle.textColor = _colors[index];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (colum == 0) {
                make.left.equalTo(_vButtons);
            } else {
                make.left.equalTo(_buttons[index - 1].mas_right);
            }
            if (colum == RowCount - 1) {
                make.right.equalTo(_vButtons);
            }
            make.width.equalTo(_vButtons.mas_width).dividedBy(RowCount);
            make.height.mas_equalTo(RowHeight);
            if (row == 0) {
                make.top.equalTo(_vButtons);
            } else {
                make.top.equalTo(_buttons[index - RowCount].mas_bottom);
            }
            //            make.bottom.lessThanOrEqualTo(_vButtons);
        }];
    }
    
    if (_buttons.count > 0) {
        [_vButtons mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(RowHeight * (((_titles.count - 1) / RowCount) + 1));
        }];
    }
}

- (void)showWithImages: (NSArray*)imgUrls andTitles: (NSArray*)titles andColors: (NSArray*)colors clickBlock: (MineIconsBlock) onClick {
    if (imgUrls == nil || titles == nil || imgUrls.count != titles.count)
        return;
    self.images = imgUrls;
    self.titles = titles;
    self.colors = colors;
    self.onClick = onClick;
    [self reloadData];
}

- (void) setPadding: (CGFloat)padding {
    [_vBackground mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, padding, padding, padding));
    }];
}

- (void)showWithImages: (NSArray*)imgUrls andTitles: (NSArray*)titles clickBlock: (MineIconsBlock) onClick {
    [self showWithImages:imgUrls andTitles:titles clickBlock:onClick];
}

- (void)showTitle: (NSString*)title isShow: (BOOL)isShow {
    _lblTitle.text = title;
    _vHeader.hidden = !isShow;
    if (isShow) {
        [_vHeader mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
        }];
    } else {
        [_vHeader mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
}

- (void)didIconClick:(id)icon {
    NSInteger index = [_buttons indexOfObject:icon];
    if (_onClick) {
        _onClick(index);
    }
}

- (void) setBackgroundImage: (NSString*) imageUrl {
    [_imgBackground sd_setImageWithURL:imageUrl];
}

@end
