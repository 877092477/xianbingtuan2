//
//  FNGoodsSelectorCountCell.m
//  THB
//
//  Created by Weller Zhao on 2019/1/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNGoodsSelectorCountCell.h"

@interface FNGoodsSelectorCountCell()

@property (nonatomic, strong) UILabel *lblTitle;

@property (nonatomic, strong) UIButton *btnSub;
@property (nonatomic, strong) UILabel *lblCount;
@property (nonatomic, strong) UIButton *btnAdd;



@end

@implementation FNGoodsSelectorCountCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}


- (void)configUI {
    self.lblTitle = [[UILabel alloc] init];
    self.btnSub = [[UIButton alloc] init];
    self.lblCount = [[UILabel alloc] init];
    self.btnAdd = [[UIButton alloc] init];
    
    [self.contentView addSubview: self.lblTitle];
    [self.contentView addSubview: self.btnSub];
    [self.contentView addSubview:self.lblCount];
    [self.contentView addSubview: self.btnAdd];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(@0);
        make.right.lessThanOrEqualTo(_btnSub.mas_left).offset(-10);
    }];
    [self.lblTitle setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.lblTitle setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    [self.btnSub mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.width.height.mas_equalTo(30);
    }];
    [self.btnSub setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.btnSub setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    [self.lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(self.btnSub.mas_right).offset(10);
        make.right.equalTo(self.btnAdd.mas_left).offset(-10);
        make.width.mas_equalTo(30);
    }];
    [self.lblCount setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.lblCount setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    [self.btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.width.height.mas_equalTo(30);
        make.right.equalTo(@-10);
        make.top.equalTo(@20);
        make.bottom.equalTo(@-20);
    }];
    [self.btnAdd setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.btnAdd setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(XYScreenWidth);
//        make.height.mas_equalTo(60);
    }];
    
    self.lblTitle.text = @"购买";
    self.lblTitle.textColor = RGB(24, 24, 24);
    self.lblTitle.font = kFONT14;
    
    [self.btnSub setImage:IMAGE(@"integral_mall_button_sub") forState:UIControlStateNormal];
    [self.btnSub setImage:IMAGE(@"integral_mall_button_sub_disable") forState:UIControlStateDisabled];
    
    self.lblCount.textColor = RGB(24, 24, 24);
    self.lblCount.font = kFONT14;
    
    [self.btnAdd setImage:IMAGE(@"integral_mall_button_add") forState:UIControlStateNormal];
//    [self.btnAdd setImage:IMAGE(@"integral_mall_button_add_disable") forState:UIControlStateDisabled];
    
    [self.btnSub addTarget:self action:@selector(onSubClick)];
    [self.btnAdd addTarget:self action:@selector(onAddClick)];
}

- (void)setCount: (int)count {
    count = count > _maxCount ? _maxCount : count;
    count = count <= 1 ? 1 : count;
    _count = count;
    self.lblCount.text = [NSString stringWithFormat:@"%d", count];
    [_btnAdd setEnabled: _count < _maxCount];
    [_btnSub setEnabled: _count > 1];
    if ([_delegate respondsToSelector:@selector(goodSelector:didCountChange:)]) {
        [_delegate goodSelector:self didCountChange:count];
    }
}

- (void)setMaxCount: (int)count {
    _maxCount = count;
}

- (void) onSubClick {
    [self setCount:_count - 1];
}

- (void) onAddClick {
    [self setCount:_count + 1];
}
- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGSize size = [self.contentView systemLayoutSizeFittingSize:layoutAttributes.size];
    CGRect cellFrame = layoutAttributes.frame;
    NSLog(@"%f  %f", size.width, size.height);
    NSLog(@"%f  %f", cellFrame.size.width, cellFrame.size.height);
    cellFrame.size = size;
    layoutAttributes.frame = cellFrame;
    return layoutAttributes;
}
@end
