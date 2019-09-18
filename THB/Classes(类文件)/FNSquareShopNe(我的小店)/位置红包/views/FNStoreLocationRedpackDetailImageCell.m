//
//  FNStoreLocationRedpackDetailImageCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/29.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreLocationRedpackDetailImageCell.h"

@interface FNStoreLocationRedpackDetailImageCell()



@end

@implementation FNStoreLocationRedpackDetailImageCell

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
    [self.contentView addSubview:_imageView];
    self.backgroundColor = UIColor.whiteColor;
    
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(164);
        make.center.equalTo(@0);
        
    }];
}

@end
