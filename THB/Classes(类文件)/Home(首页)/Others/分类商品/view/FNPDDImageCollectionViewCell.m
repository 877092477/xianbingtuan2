//
//  FNPDDImageCollectionViewCell.m
//  THB
//
//  Created by Weller Zhao on 2019/3/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNPDDImageCollectionViewCell.h"

@interface FNPDDImageCollectionViewCell()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation FNPDDImageCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    _imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    _imgView.layer.masksToBounds = YES;
    
}

- (void)setImage: (UIImage*)image {
    _imgView.image = image;
}

@end
