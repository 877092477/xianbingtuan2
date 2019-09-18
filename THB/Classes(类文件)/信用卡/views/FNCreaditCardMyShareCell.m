//
//  FNCreaditCardMyShareCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/6/21.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNCreaditCardMyShareCell.h"

@interface FNCreaditCardMyShareCell()

@property (nonatomic, strong) NSMutableArray<UIButton*> *tagButtons;
@property (nonatomic, strong) NSMutableArray<UILabel*> *tagLabels;

@end

@implementation FNCreaditCardMyShareCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void) configUI {
    
    _tagButtons = [[NSMutableArray alloc] init];
    _tagLabels = [[NSMutableArray alloc] init];
    
    _imgBackground = [[UIImageView alloc] init];
    _imgHeader = [[UIImageView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblName = [[UILabel alloc] init];
    _vTag = [[UIView alloc] init];
    _lblCommission = [[UILabel alloc] init];
    _lblTime = [[UILabel alloc] init];
    _imgStatus = [[UIImageView alloc] init];
    
    [self.contentView addSubview:_imgBackground];
    [self.contentView addSubview:_imgHeader];
    [self.contentView addSubview:_lblTitle];
    [self.contentView addSubview:_lblName];
    [self.contentView addSubview:_vTag];
    [self.contentView addSubview:_lblCommission];
    [self.contentView addSubview:_lblTime];
    [self.contentView addSubview:_imgStatus];
    
    [_imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(10, 10, 0, 10));
        make.height.mas_equalTo(94);
    }];
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgBackground).offset(14);
        make.centerY.equalTo(@0);
        make.width.height.mas_equalTo(48);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(20);
        make.top.equalTo(self.imgHeader);
        make.right.lessThanOrEqualTo(self.imgBackground).offset(-60);
    }];
    [_lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(20);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(4);
        make.right.lessThanOrEqualTo(self.lblCommission.mas_left).offset(-10);
    }];
    [_vTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgHeader.mas_right).offset(20);
        make.top.equalTo(self.lblName.mas_bottom).offset(8);
        make.height.mas_equalTo(20);
    }];
    [_lblCommission mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imgBackground).offset(-30);
        make.top.equalTo(@40);
//        make.height.mas_equalTo(20);
    }];
    [_lblTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.vTag);
        make.right.equalTo(self.imgBackground).offset(-30);
    }];
    [_imgStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imgBackground);
        make.top.equalTo(self.imgBackground).offset(10);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(0);
    }];
    
    self.backgroundColor = UIColor.clearColor;
    
    _imgBackground.backgroundColor = UIColor.whiteColor;
    _imgBackground.cornerRadius = 10;
    
    _imgHeader.contentMode = UIViewContentModeScaleAspectFill;
    _imgHeader.cornerRadius = 24;
    
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.font = kFONT14;
    
    _lblName.textColor = RGB(153, 153, 153);
    _lblName.font = kFONT10;
    
    _lblCommission.textColor = RGB(30, 130, 254);
    _lblCommission.font = kFONT15;
    
    _lblTime.textColor = RGB(153, 153, 153);
    _lblTime.font = [UIFont systemFontOfSize:9];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setState: (NSString*)stateUrl {
    
    @weakify(self)
    [_imgStatus sd_setImageWithURL:URL(stateUrl) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self)
        if (image) {
            
            [self.imgStatus mas_updateConstraints: ^(MASConstraintMaker *make) {
                make.width.mas_equalTo(15 * image.size.width / image.size.height);
            }];
            [self layoutIfNeeded];
        }
    }];
}

- (void) setTags: (NSArray<NSString*> *)tags withColor: (UIColor*)color andBg: (NSString*)bg {
    
    [self.tagButtons removeAllObjects];
    [self.tagLabels removeAllObjects];
    
    for (NSInteger index = 0 ; index < tags.count; index++) {
        
        NSString *tag = tags[index];
        UIButton *btnTag = [[UIButton alloc] init];
        UILabel *lblTag = [[UILabel alloc] init];
        
        [self.vTag addSubview: btnTag];
        [self.vTag addSubview: lblTag];
        
        [self.tagButtons addObject: btnTag];
        [self.tagLabels addObject: lblTag];
        
        [btnTag mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.equalTo(@0);
            if (index == 0) {
                make.left.equalTo(@0);
            } else {
                make.left.equalTo(self.tagButtons[index - 1].mas_right).offset(5);
            }
        }];
        
        [lblTag mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(btnTag);
            make.left.equalTo(btnTag).offset(4);
            make.right.equalTo(btnTag).offset(-4);
        }];
        
        lblTag.textColor = color;
        lblTag.font = kFONT10;
        lblTag.text = tag;
        [btnTag sd_setBackgroundImageWithURL:URL(bg) forState:UIControlStateNormal];
    }
}


@end
