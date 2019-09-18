//
//  FNImageTableViewCell.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/21.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNImageTableViewCell.h"


@interface FNImageTableViewCell()

@property (nonatomic, strong) UIImageView *imgGoods;
@end

@implementation FNImageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}


- (void)configUI {
    self.imgGoods = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgGoods];
    [self.imgGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.equalTo(@0);
        make.width.mas_equalTo(XYScreenWidth);
        make.height.equalTo(self.imgGoods.mas_width).multipliedBy(1);
    }];
}

- (void) setImage: (UIImage*)image {
    self.imgGoods.image = image;
    CGFloat rate = image.size.width / image.size.height;
    [self.imgGoods mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.equalTo(@0);
        make.width.mas_equalTo(XYScreenWidth);
        make.height.equalTo(self.imgGoods.mas_width).dividedBy(rate);
        make.bottom.lessThanOrEqualTo(@0);
    }];
}

@end
