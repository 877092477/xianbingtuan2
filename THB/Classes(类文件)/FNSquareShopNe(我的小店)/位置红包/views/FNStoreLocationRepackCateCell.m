//
//  FNStoreLocationRepackCateCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/23.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreLocationRepackCateCell.h"

@interface FNStoreLocationRepackCateCell()

@property (nonatomic, strong) UIImageView *imgIcon;
@property (nonatomic, strong) UILabel *lblTitle;

@property (nonatomic, strong) FNStoreLocationRepackCateModel *model;

@end

@implementation FNStoreLocationRepackCateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _imgIcon = [[UIImageView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    UIView *vLine = [[UIView alloc] init];
    
    [self.contentView addSubview:_imgIcon];
    [self.contentView addSubview:_lblTitle];
    [self.contentView addSubview:vLine];
    
    [_imgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.width.height.mas_equalTo(20);
        make.centerY.equalTo(@0);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgIcon.mas_right).offset(4);
        make.right.lessThanOrEqualTo(@-16);
        make.centerY.equalTo(@0);
    }];
    [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@36);
        make.right.equalTo(@-16);
        make.bottom.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _lblTitle.textColor = RGB(102, 102, 102);
    _lblTitle.font = kFONT16;
    
    vLine.backgroundColor = RGB(221, 221, 221);
}

- (void)setIsSelected: (BOOL)isSelected {
    _lblTitle.textColor = isSelected ? [UIColor colorWithHexString: _model.check_color] : [UIColor colorWithHexString: _model.color];
}

- (void)setModel: (FNStoreLocationRepackCateModel*)model {
    _model = model;
    [self.imgIcon sd_setImageWithURL: URL(model.ico)];
    self.lblTitle.text = model.catename;
    self.lblTitle.textColor = [UIColor colorWithHexString: model.color];
}

@end
