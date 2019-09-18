//
//  FNVideoCardCell.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNVideoCardCell.h"

@interface FNVideoCardCell()

@end

@implementation FNVideoCardCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _imgBackground = [[UIImageView alloc] init];
    _btnMore = [[UIButton alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    
    [self addSubview:_imgBackground];
    [self addSubview:_btnMore];
    [self addSubview:_lblTitle];
    [self addSubview:_lblDesc];
    
    [_imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(0, 15, 10, 15));
    }];
    
    [_btnMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imgBackground).offset(-10);
        make.bottom.equalTo(self.imgBackground).offset(-10);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(42);
    }];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgBackground).offset(10);
        make.top.equalTo(self.imgBackground).offset(20);
        
    }];
    
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imgBackground).offset(-10);
        make.top.equalTo(self.imgBackground).offset(20);
        make.left.greaterThanOrEqualTo(self.lblTitle.mas_right).offset(10);
    }];
    
    self.backgroundColor = UIColor.whiteColor;
    
    _btnMore.titleLabel.font = kFONT12;
    _btnMore.enabled = NO;
    
    _lblTitle.font = [UIFont systemFontOfSize:18];
    
    _lblDesc.font = kFONT11;
    _lblDesc.numberOfLines = 0;
    
//    [_imgBackground sd_setImageWithURL:URL(@"http://www.hairuyi.com/Upload/slide/1553839550_1_1.png")];
//    [_btnMore sd_setBackgroundImageWithURL:URL(@"http://www.hairuyi.com/Upload/slide/1553839550_1_4.png") forState:UIControlStateNormal];
//    [_btnMore setTitle:@"激活卡密" forState:UIControlStateNormal];
//    [_btnMore setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
}

@end
