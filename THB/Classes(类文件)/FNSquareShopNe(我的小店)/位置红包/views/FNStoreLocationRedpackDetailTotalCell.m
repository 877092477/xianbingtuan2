//
//  FNStoreLocationRedpackDetailTotalCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/28.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreLocationRedpackDetailTotalCell.h"

@interface FNStoreLocationRedpackDetailTotalCell()

@property (nonatomic, strong) UILabel *lblTotal;
@property (nonatomic, strong) UIScrollView *vHeaders;
@property (nonatomic, strong) UIButton *btnRight;
@property (nonatomic, strong) UIButton *btnShare;

@property (nonatomic, strong) NSMutableArray<UIImageView*> *headers;

@end

@implementation FNStoreLocationRedpackDetailTotalCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _headers = [[NSMutableArray alloc] init];
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _lblTotal = [[UILabel alloc] init];
    _vHeaders = [[UIScrollView alloc] init];
    _btnRight = [[UIButton alloc] init];
    _btnShare = [[UIButton alloc] init];
    
    [self.contentView addSubview:_lblTotal];
    [self.contentView addSubview:_vHeaders];
    [self.contentView addSubview:_btnRight];
    [self.contentView addSubview:_btnShare];
    

    [_lblTotal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@6);
        make.right.lessThanOrEqualTo(@-20);
        make.height.mas_equalTo(12);
    }];
    [_vHeaders mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(self.lblTotal.mas_bottom).offset(20);
        make.height.mas_equalTo(34);
        make.right.equalTo(self.btnRight.mas_left).offset(-4);
    }];
    [_btnRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.vHeaders);
        make.right.equalTo(@-20);
        make.width.height.mas_equalTo(20);
    }];
    [_btnShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(38);
        make.bottom.equalTo(@-12);
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
    }];
    
    self.backgroundColor = UIColor.whiteColor;
    
    _lblTotal.textColor = RGB(153, 153, 153);
    _lblTotal.font = kFONT11;
    
    _vHeaders;
    [_btnRight setImage:IMAGE(@"shop_right") forState: UIControlStateNormal];
    
    _btnShare.cornerRadius = 4;
    _btnShare.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    _btnShare.layer.borderWidth = 1;
    _btnShare.hidden = YES;
    
    [_btnRight addTarget:self action:@selector(onRightClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setModel: (FNStoreLocationRedpackReceiveDetailModel*)model {
    _lblTotal.text = model.packet_total.str;
    
    _btnShare.layer.borderColor = [UIColor colorWithHexString:model.packet_total.btn_color].CGColor;
    [_btnShare setTitle: model.packet_total.btn_str forState: UIControlStateNormal];
    [_btnShare setTitleColor: [UIColor colorWithHexString:model.packet_total.btn_color] forState: UIControlStateNormal];
    
    for (UIImageView *imageview in _headers) {
        [imageview removeFromSuperview];
    }
    [_headers removeAllObjects];
    
    NSArray *list = model.packet_total.user_list;
    for (NSInteger index = 0; index < list.count; index ++) {
        UIImageView *imageview = [[UIImageView alloc] init];
        [_vHeaders addSubview:imageview];
        [_headers addObject:imageview];
        
        [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            if (index == 0) {
                make.left.equalTo(@0);
            } else {
                make.left.equalTo(self.headers[index - 1].mas_right).offset(12);
            }
            make.right.lessThanOrEqualTo(@0);
            make.top.bottom.equalTo(@0);
            make.width.height.mas_equalTo(34);
        }];
        
        [imageview sd_setImageWithURL:URL(list[index])];
        imageview.cornerRadius = 17;
    }
    
}

- (void)onRightClick {
    if ([_delegate respondsToSelector:@selector(didTotalCellMoreClick:)]) {
        [_delegate didTotalCellMoreClick:self];
    }
}

@end
