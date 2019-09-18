//
//  FNStoreManagerCateCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/9.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreManagerCateCell.h"

@interface FNStoreManagerCateCell()

@property (nonatomic, strong) UIView *vCount;
@property (nonatomic, strong) UILabel *lblCount;

@end

@implementation FNStoreManagerCateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}


- (void)configUI {
    _lblTitle = [[UILabel alloc] init];
    
    [self.contentView addSubview:_lblTitle];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.left.greaterThanOrEqualTo(@4);
        make.right.lessThanOrEqualTo(@-4);
    }];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.font = kFONT14;
    
    _vCount = [[UIView alloc] init];
    _lblCount = [[UILabel alloc] init];
    [self.contentView addSubview:_vCount];
    [_vCount addSubview:_lblCount];
    
    [_vCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(@0);
        make.height.mas_equalTo(12);
    }];
    [_lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.left.equalTo(@6);
        make.right.equalTo(@-6);
    }];
    
    _vCount.cornerRadius = 6;
    _vCount.backgroundColor = RGB(251, 177, 0);
    _vCount.hidden = YES;
    
    _lblCount.textColor = UIColor.whiteColor;
    _lblCount.font = [UIFont systemFontOfSize:9];
}

- (void)setIsSelected:(BOOL)selected{
    
    _lblTitle.textColor = selected ? RGB(255, 102, 102) : RGB(51, 51, 51);
    self.backgroundColor = selected ? UIColor.whiteColor : UIColor.clearColor;

}

- (void)setCount: (int)count {
    _vCount.hidden = YES;
    if (count > 0) {
        _lblCount.text = [NSString stringWithFormat: @"%d", count];
        _vCount.hidden = NO;
    }
}

@end
