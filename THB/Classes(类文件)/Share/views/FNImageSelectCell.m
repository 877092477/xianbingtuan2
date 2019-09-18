//
//  FNImageSelectCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/4.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNImageSelectCell.h"

@interface FNImageSelectCell()

@property (nonatomic, strong) UIImageView *imgCheck;

@end

@implementation FNImageSelectCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _imageView = [[UIImageView alloc] init];
    _imgCheck = [[UIImageView alloc] init];
    
    [self.contentView addSubview:_imageView];
    [self.contentView addSubview:_imgCheck];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_imgCheck mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@4);
        make.right.equalTo(@-4);
    }];
    
    _imgCheck.image = IMAGE(@"public_share_check_normal");
}

- (void)setCheck: (BOOL)check {
    _imgCheck.image = check ? IMAGE(@"public_share_check_selected") : IMAGE(@"public_share_check_normal");
}

@end
