//
//  FNFNGoodsSelectorTitle.m
//  THB
//
//  Created by Weller Zhao on 2019/1/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNFNGoodsSelectorTitle.h"

@interface FNFNGoodsSelectorTitle()

@property (nonatomic, strong) UILabel *lblTitle;

@end


@implementation FNFNGoodsSelectorTitle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _lblTitle = [[UILabel alloc] init];
    [self addSubview:_lblTitle];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(@0);
        make.right.lessThanOrEqualTo(@-10);
        make.height.mas_equalTo(40);
    }];
    
    _lblTitle.textColor = RGB(24, 24, 24);
    _lblTitle.font = kFONT14;
    
    [self.lblTitle setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.lblTitle setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}

- (void)setTitle: (NSString*)title {
    _lblTitle.text = title;
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGSize size = [self systemLayoutSizeFittingSize:layoutAttributes.size];
    CGRect cellFrame = layoutAttributes.frame;
    NSLog(@"%f  %f", size.width, size.height);
    NSLog(@"%f  %f", cellFrame.size.width, cellFrame.size.height);
    cellFrame.size = size;
    layoutAttributes.frame = cellFrame;
    return layoutAttributes;
}
@end
