//
//  FNLiveBroadcastGoodsImageCell.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNLiveBroadcastGoodsImageCell.h"

@interface FNLiveBroadcastGoodsImageCell()

@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UIImageView *imgContent;

@end

@implementation FNLiveBroadcastGoodsImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}


- (void)configUI {
    _imgHeader = [[UIImageView alloc] init];
    _vContent = [[UIView alloc] init];
    _imgContent = [[UIImageView alloc] init];
    
    [self.contentView addSubview:_imgHeader];
    [self.contentView addSubview:_vContent];
    [_vContent addSubview:_imgContent];
    
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@20);
        make.width.height.mas_equalTo(36);
        make.bottom.lessThanOrEqualTo(@-20);
    }];
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@70);
        make.top.equalTo(@20);
        make.right.equalTo(@-70);
        make.bottom.equalTo(@-20);
    }];
    [_imgContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(4, 4, 4, 4));
    }];
    
    _imgHeader.cornerRadius = 13;
    _imgHeader.contentMode = UIViewContentModeScaleToFill;
    
    _vContent.cornerRadius = 5;
    _vContent.borderColor = RGB(249, 240, 249);
    _vContent.borderWidth = 1;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    @weakify(self)
    [_imgContent addJXTouch:^{
        @strongify(self)
        if ([self.delegate respondsToSelector:@selector(onCell:imageClick:)]) {
            [self.delegate onCell:self imageClick:self.imgContent];
        }
    }];
}

- (void)setContentImage: (UIImage*)image {
    _imgContent.image = image;
    
    [_imgContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(10, 10, 10, 10));
        make.width.equalTo(self.imgContent.mas_height).dividedBy(image.size.height / image.size.width);;
    }];
}


@end
