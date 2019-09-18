//
//  FNDouQuanVideoCell.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNDouQuanVideoCell.h"

@implementation FNDouQuanVideoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    _videoPlayView = [[UIImageView alloc] init];
    _videoPlayView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_videoPlayView];
    [_videoPlayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    self.backgroundColor = UIColor.clearColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
