//
//  FNVideoCoverCell.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNVideoCoverCell.h"

@interface FNVideoCoverCell()

@property (nonatomic, strong) UIImageView *imgCover;
@property (nonatomic, strong) UILabel *lblName;

@end

@implementation FNVideoCoverCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _imgCover = [[UIImageView alloc] init];
    _lblName = [[UILabel alloc] init];
    
    [self addSubview:_imgCover];
    [self addSubview:_lblName];
    
    [_imgCover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.height.equalTo(self.imgCover.mas_width).dividedBy(0.75);
    }];
    
    [_lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.lessThanOrEqualTo(@-10);
        make.top.equalTo(self.imgCover.mas_bottom).offset(8);
    }];
    
    self.backgroundColor = UIColor.whiteColor;
    self.lblName.textColor = RGB(51, 51, 51);
    self.lblName.font = kFONT14;
}

- (void)setImage: (NSString*)imageUrl withTitle: (NSString*)title {
    [self.imgCover sd_setImageWithURL:URL(imageUrl)];
    self.lblName.text = title;
}

@end
