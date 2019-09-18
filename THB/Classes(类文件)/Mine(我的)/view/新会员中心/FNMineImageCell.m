//
//  FNMineImageCell.m
//  THB
//
//  Created by Weller Zhao on 2018/12/25.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNMineImageCell.h"
#import "SDWebImage/UIButton+WebCache.h"

@interface FNMineImageCell()

@property (nonatomic, strong) UIView *vBackground;
@property (nonatomic, strong) NSMutableArray<UIButton*> *imageViews;
@property (nonatomic, assign) CGFloat padding;

@end

@implementation FNMineImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _padding = 10;
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = UIColor.clearColor;
    
    _imageViews = [[NSMutableArray alloc] init];
    
    _vBackground = [[UIView alloc] init];
    [self.contentView addSubview:_vBackground];
    [_vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(0, 10, 10, 10));
    }];
//    _vBackground.cornerRadius = 10;
    _vBackground.backgroundColor = UIColor.clearColor;
    
}

- (void)setImages: (NSArray<UIImage*> *)images column: (int)column {
    for (UIView *view in _imageViews) {
        [view removeFromSuperview];
    }
    [_imageViews removeAllObjects];
    
    if (column <= 0)
        return;
    
    CGFloat width = (XYScreenWidth - (_padding * 2)) / column;
    for (NSInteger index = 0; index < images.count; index ++) {
        UIButton *img = [[UIButton alloc] init];
        UIImage *image = images[index];
        [img setBackgroundImage:image forState:UIControlStateNormal];
        [img setBackgroundImage:image forState:UIControlStateHighlighted];
        [_vBackground addSubview:img];
        [_imageViews addObject:img];
        NSInteger row = index / column;
        NSInteger col = index % column;
        CGFloat rate = image.size.width / image.size.height;
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            if (col == 0) {
                make.left.equalTo(@0);
            } else {
                make.left.equalTo(_imageViews[index - 1].mas_right);
            }
            if (row == 0) {
                make.top.equalTo(@0);
            } else {
                make.top.equalTo(_imageViews[index - column].mas_bottom);
            }
//            make.width.equalTo(@0).dividedBy(column);
            make.width.mas_equalTo(width);
            make.height.equalTo(img.mas_width).dividedBy(rate);
            make.bottom.lessThanOrEqualTo(@0);
        }];
        [img addTarget:self action:@selector(onButtonClick:)];
    }
}


- (void)onButtonClick: (UITapGestureRecognizer*)sender {
    UIButton *button = (UIButton*)sender.view;
    NSInteger index = [_imageViews indexOfObject:button];
    if ([self.delegate respondsToSelector:@selector(imageCell:didClickAt:)]) {
        [self.delegate imageCell:self didClickAt:index];
    }
}

- (void) setPadding: (CGFloat)padding {
    _padding = padding;
    [_vBackground mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, padding, padding, padding));
    }];
}


@end
