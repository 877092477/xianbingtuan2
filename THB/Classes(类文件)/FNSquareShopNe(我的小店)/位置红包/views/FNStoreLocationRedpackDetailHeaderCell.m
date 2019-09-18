//
//  FNStoreLocationRedpackDetailHeaderCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/28.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreLocationRedpackDetailHeaderCell.h"

@interface FNStoreLocationRedpackDetailHeaderCell()

@property (nonatomic, strong) UIImageView *imgBg;
@property (nonatomic, strong) UIImageView *imgHeader;
@property (nonatomic, strong) UILabel *lblStore;
@property (nonatomic, strong) UIView *vLabels;
@property (nonatomic, strong) UILabel *lblStatus;
@property (nonatomic, strong) UILabel *lblDesc;

@property (nonatomic, strong) UIButton *btnLocation;
@property (nonatomic, strong) UIImageView *imgLocation;
@property (nonatomic, strong) UILabel *lblLocation;
@property (nonatomic, strong) UILabel *lblDistance;
@property (nonatomic, strong) UIImageView *imgRight;

@property (nonatomic, strong) NSMutableArray<UILabel*> *labels;

@end

@implementation FNStoreLocationRedpackDetailHeaderCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _labels = [[NSMutableArray alloc] init];
        [self configUI];
    }
    return self;
}

- (void) configUI {
    _imgBg = [[UIImageView alloc] init];
    _imgHeader = [[UIImageView alloc] init];
    _lblStore = [[UILabel alloc] init];
    _vLabels = [[UILabel alloc] init];
    _lblStatus = [[UILabel alloc] init];
    _lblDesc = [[UILabel alloc] init];
    _btnLocation = [[UIButton alloc] init];
    _imgLocation = [[UIImageView alloc] init];
    _lblLocation = [[UILabel alloc] init];
    _lblDistance = [[UILabel alloc] init];
    _imgRight = [[UIImageView alloc] init];
    
    [self.contentView addSubview:_imgBg];
    [self.contentView addSubview:_imgHeader];
    [self.contentView addSubview:_lblStore];
    [self.contentView addSubview:_vLabels];
    [self.contentView addSubview:_lblStatus];
    [self.contentView addSubview:_lblDesc];
    [self.contentView addSubview:_btnLocation];
    [self.contentView addSubview:_imgLocation];
    [self.contentView addSubview:_lblLocation];
    [self.contentView addSubview:_lblDistance];
    [self.contentView addSubview:_imgRight];
    
    [_imgBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lblStore.mas_top).offset(-10);
        make.centerX.equalTo(@0);
        make.height.width.mas_equalTo(54);
    }];
    [_lblStore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.vLabels.mas_top).offset(-10);
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
        make.centerX.equalTo(@0);
        make.height.mas_equalTo(18);
    }];
    [_vLabels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lblStatus.mas_top).offset(-16);
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
        make.height.mas_equalTo(20);
        make.centerX.equalTo(@0);
    }];
    [_lblStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lblDesc.mas_top).offset(-8);
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
        make.centerX.equalTo(@0);
        make.height.mas_equalTo(28);
    }];
    [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.btnLocation.mas_top).offset(-12);
        make.left.greaterThanOrEqualTo(@20);
        make.right.lessThanOrEqualTo(@-20);
        make.centerX.equalTo(@0);
        make.height.mas_equalTo(12);
    }];
    [_btnLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.bottom.equalTo(@-25);
        make.height.mas_equalTo(54);
    }];
    [_imgLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnLocation).offset(16);
        make.centerY.equalTo(self.btnLocation);
        make.width.height.mas_equalTo(16);
    }];
    [_lblLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgLocation.mas_right).offset(2);
        make.centerY.equalTo(self.btnLocation);
        make.right.lessThanOrEqualTo(self.lblDistance.mas_left).offset(-10);
    }];
    [_lblDistance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imgRight.mas_left).offset(-2);
        make.centerY.equalTo(self.btnLocation);
    }];
    [_imgRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btnLocation).offset(-10);
        make.centerY.equalTo(self.btnLocation);
    }];
    
    _imgBg.contentMode = UIViewContentModeScaleAspectFill;
    _imgBg.clipsToBounds = YES;
    
    _imgHeader.cornerRadius = 27;
    @weakify(self);
    [_imgHeader addJXTouch:^{
        @strongify(self);
        if ([_delegate respondsToSelector:@selector(headerCellDidHeaderClick:)]) {
            [_delegate headerCellDidHeaderClick:self];
        }
    }];
    
    _lblStore.font = [UIFont boldSystemFontOfSize:18];
    
    _lblStatus.font = [UIFont boldSystemFontOfSize:28];
    _lblDesc.font = kFONT12;
    
    [_btnLocation addTarget:self action:@selector(locationAction) forControlEvents:UIControlEventTouchUpInside];
    
    _imgLocation.contentMode = UIViewContentModeScaleAspectFit;
    _lblLocation.font = kFONT13;
    _lblDistance.font = kFONT13;
    _imgRight.contentMode = UIViewContentModeScaleAspectFit;
    
    _btnLocation.backgroundColor = RGB(230, 51, 48);
    _btnLocation.cornerRadius = 1;
}

- (void)locationAction {
    if ([_delegate respondsToSelector:@selector(headerCellDidLocationClick:)]) {
        [_delegate headerCellDidLocationClick:self];
    }
}

- (void)setModel: (FNStoreLocationRedpackReceiveDetailModel*)model {
    [_imgBg sd_setImageWithURL:URL(model.bjimg)];
    [_imgHeader sd_setImageWithURL:URL(model.store_img)];
    
    _lblStore.text = model.store_name;
    _lblStore.textColor = [UIColor colorWithHexString: model.store_name_color];
    _lblStatus.text = model.packet.price;
    _lblStatus.textColor = [UIColor colorWithHexString: model.packet.price_color];
    
    _lblDesc.text = model.packet.c_str;
    _lblDesc.textColor = [UIColor colorWithHexString: model.packet.price_color];
    
    [_imgLocation sd_setImageWithURL:URL(model.redpacket_store_msg.img)];
    _lblLocation.text = model.redpacket_store_msg.store_name;
    _lblLocation.textColor = [UIColor colorWithHexString: model.redpacket_store_msg.fontcolor];
    _lblDistance.text = model.redpacket_store_msg.str;
    _lblDistance.textColor = [UIColor colorWithHexString: model.redpacket_store_msg.fontcolor];
    
    
    for (UILabel *label in _labels) {
        [label removeFromSuperview];
    }
    [_labels removeAllObjects];
    for (NSInteger index = 0; index < model.label.count; index++) {
        UILabel *label = [[UILabel alloc] init];
        
        FNStoreLocationRedpackDetailLabelModel *tag = model.label[index];
        [self.labels addObject:label];
        [self.vLabels addSubview: label];
        
        label.text = tag.str;
        label.textColor = [UIColor colorWithHexString:tag.color];
        label.font = kFONT11;
        label.cornerRadius = 10;
        label.layer.borderWidth = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.borderColor = [UIColor colorWithHexString:tag.color].CGColor;
        
        NSString* string = tag.str;
        CGRect rect = [string boundingRectWithSize:(CGSizeMake(JMScreenWidth-60, 20)) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:kFONT11} context:nil];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (index == 0) {
                make.left.equalTo(@0);
            } else {
                make.left.equalTo(self.labels[index - 1].mas_right).offset(4);
            }
            make.right.lessThanOrEqualTo(@0);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(rect.size.width + 10);
        }];
        
    }
}

@end
