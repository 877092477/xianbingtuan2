//
//  FNGoodsSelectorCell.m
//  THB
//
//  Created by Weller Zhao on 2019/1/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNGoodsSelectorCell.h"

@interface FNGoodsSelectorCell()

@property (nonatomic, strong) UIView *vTitle;
@property (nonatomic, strong) UILabel *lblTitle;

@end

@implementation FNGoodsSelectorCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.vTitle = [[UIView alloc] init];
    self.lblTitle = [[UILabel alloc] init];
    
    [self.contentView addSubview:self.vTitle];
    [self.vTitle addSubview:self.lblTitle];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(@0);
    }];
    
    [self.vTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(4, 10, 4, 10));
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.top.equalTo(@4);
        make.bottom.equalTo(@-4);
        make.height.mas_equalTo(26);
    }];
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
//        make.width.mas_greaterThanOrEqualTo(60);
        make.left.equalTo(@8);
        make.right.equalTo(@-8);
    }];
    [self.lblTitle setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.lblTitle setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
//    self.lblTitle.text = @"02";
    self.lblTitle.font = [UIFont systemFontOfSize:12];
    self.lblTitle.textAlignment = NSTextAlignmentCenter;
    self.vTitle.cornerRadius = 10;
    [self setSelected:NO];
}

- (void)setTitle: (NSString*)title {
    self.lblTitle.text = title;
}

- (void)setIsSelected: (BOOL)isSelected {
    if (isSelected) {
        self.vTitle.backgroundColor = RGB(255, 131, 20);
        self.lblTitle.textColor = FNWhiteColor;
    } else {
        self.vTitle.backgroundColor = RGB(235, 235, 235);
        self.lblTitle.textColor = RGB(24, 24, 24);
    }
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
