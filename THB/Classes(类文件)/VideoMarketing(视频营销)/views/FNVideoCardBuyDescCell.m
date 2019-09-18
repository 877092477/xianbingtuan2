//
//  FNVideoCardBuyDescCell.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/2.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNVideoCardBuyDescCell.h"

@interface FNVideoCardBuyDescCell ()

@property (nonatomic, strong) UILabel *lblDesc;

@end

@implementation FNVideoCardBuyDescCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _lblDesc = [[UILabel alloc] init];
        [self.contentView addSubview:_lblDesc];
        [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0).insets(UIEdgeInsetsMake(14, 30, 30, 47));
        }];
        
        _lblDesc.numberOfLines = 0;
        _lblDesc.textColor = RGB(153, 153, 153);
        _lblDesc.font = [UIFont systemFontOfSize:12];
        
        UIView *line = [[UIView alloc] init];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(@0);
            make.height.mas_equalTo(1);
        }];
        line.backgroundColor = RGB(240, 240, 240);
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

- (void)setDesc: (NSString*)desc {
    _lblDesc.text = desc;
}

@end
