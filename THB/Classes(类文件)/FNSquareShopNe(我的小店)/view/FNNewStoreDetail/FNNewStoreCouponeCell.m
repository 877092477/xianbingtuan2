//
//  FNNewStoreCouponeCell.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/24.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStoreCouponeCell.h"

@interface FNNewStoreCouponeCell()

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIImageView *btnMore;
@property (nonatomic, strong) UIView *vCoupone;

@property (nonatomic, strong) NSMutableArray<UIView*> *array;

@end

@implementation FNNewStoreCouponeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _array = [[NSMutableArray alloc] init];
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _lblTitle = [[UILabel alloc] init];
    _btnMore = [[UIImageView alloc] init];
    _vCoupone = [[UIView alloc] init];
    
    [self.contentView addSubview:_lblTitle];
    [self.contentView addSubview:_btnMore];
    [self.contentView addSubview:_vCoupone];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.centerY.equalTo(@0);
        make.width.mas_equalTo(30);
    }];
    [_btnMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-20);
        make.centerY.equalTo(@0);
//        make.width.height.mas_equalTo(20);
    }];
    [_vCoupone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblTitle.mas_right).offset(10);
        make.right.equalTo(self.btnMore.mas_left).offset(-10);
        make.top.bottom.equalTo(@0);
    }];
    
    self.backgroundColor = UIColor.whiteColor;
    
    _lblTitle.text = @"领券";
    _lblTitle.textColor = RGB(51, 51, 51);
    _lblTitle.font = [UIFont boldSystemFontOfSize:14];
    
//    [_btnMore setImage: IMAGE(@"store_coupone_more_image") forState: UIControlStateNormal];
    _btnMore.image = IMAGE(@"store_coupone_more_image");
//    _btnMore.
}

- (void)setModel: (NSArray<FNstoreCouponeModel*>*)yhq_list {
    
    for (UIView *v in _array) {
        [v removeFromSuperview];
    }
    [_array removeAllObjects];
    
    for (NSInteger index = 0; index < yhq_list.count; index ++) {
        FNstoreCouponeModel* coupone = yhq_list[index];
        
        UIImageView *imgCoupone = [[UIImageView alloc] init];
        [_vCoupone addSubview: imgCoupone];
        [_array addObject: imgCoupone];
        [imgCoupone sd_setImageWithURL: URL(coupone.s_bj_img)];
        
        [imgCoupone mas_makeConstraints:^(MASConstraintMaker *make) {
            if (index == 0) {
                make.left.equalTo(@0);
            } else {
                make.left.equalTo(self.array[index - 1].mas_right).offset(10);
            }
            make.height.mas_equalTo(16);
            make.centerY.equalTo(@0);
        }];
        
        UILabel *lblCoupone = [[UILabel alloc] init];
        [imgCoupone addSubview: lblCoupone];
        [lblCoupone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@8);
            make.right.equalTo(@-8);
            make.centerY.equalTo(@0);
        }];
        
        lblCoupone.text = coupone.title;
        lblCoupone.textColor = [UIColor colorWithHexString: coupone.s_color];
        lblCoupone.font = kFONT10;
    }
}

@end
