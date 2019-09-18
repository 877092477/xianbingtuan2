//
//  FNImageTextCollectionViewCell.m
//  THB
//
//  Created by Weller Zhao on 2019/1/7.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNImageTextCollectionViewCell.h"

@interface FNImageTextCollectionViewCell()

@property (nonatomic, strong) UILabel *lblHeader;

@end

@implementation FNImageTextCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.imgHeader = [[UIImageView alloc] init];
    self.lblHeader = [[UILabel alloc] init];
    
    [self.contentView addSubview: self.imgHeader];
    [self.contentView addSubview: self.lblHeader];
    
    [self.imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@016);
        make.width.height.mas_equalTo(15);
        make.centerY.equalTo(@0);
        make.top.equalTo(@16);
        make.bottom.equalTo(@-16);
    }];

    [self.lblHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(6);
        make.right.equalTo(@-16);
        make.centerY.equalTo(@0);
        make.top.greaterThanOrEqualTo(@0);
        make.bottom.lessThanOrEqualTo(@0);
    }];

    
//    self.imgHeader.frame = CGRectMake(16, 0, 15, 15);
//    self.imgHeader.centerY = self.centerY;
//
//    self.lblHeader.frame = CGRectMake(40, 0, XYScreenWidth - 80, 44);
//    self.lblHeader.centerY = self.centerY;
    
    self.imgHeader.contentMode = UIViewContentModeScaleAspectFit;
    
    self.lblHeader.textColor = RGB(200, 200, 200);
    self.lblHeader.font = kFONT13;
    self.lblHeader.numberOfLines=2;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    self.imgHeader.centerY = self.contentView.bounds.size.height / 2;g
//    self.lblHeader.centerY = self.contentView.bounds.size.height / 2;
    
}

- (void)setText: (NSString*)text{
    self.lblHeader.text = text;
//    self.lblHeader.frame = CGRectMake(40, 0, XYScreenWidth - 80, 44);
//    [self.lblHeader sizeToFit];
//    self.lblHeader.centerY = self.contentView.bounds.size.height / 2;
//    self.contentView.frame.size = CGSizeMake(self.lblHeader.bounds.size.width + 40, 40);
}

- (CGFloat) getWidth {
    
    NSLog(@"%f", self.lblHeader.bounds.size.width);
    return self.lblHeader.bounds.size.width + 40;
}

@end
