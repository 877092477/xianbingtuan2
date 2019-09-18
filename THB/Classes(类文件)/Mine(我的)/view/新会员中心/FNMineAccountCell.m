//
//  FNMineAccountCell.m
//  THB
//
//  Created by Weller Zhao on 2018/12/25.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNMineAccountCell.h"

@interface FNMineAccountCenterView : UIView

@property (nonatomic) UIView *vContent;
@property (nonatomic) UILabel *lblTitle;
@property (nonatomic) UILabel *lblDesc;

@end

@implementation FNMineAccountCenterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _vContent = [[UIView alloc] init];
        [self addSubview:_vContent];
        _lblTitle = [[UILabel alloc] init];
        [_vContent addSubview:_lblTitle];
        _lblDesc = [[UILabel alloc] init];
        [_vContent addSubview:_lblDesc];
        [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.greaterThanOrEqualTo(@0);
            make.right.bottom.lessThanOrEqualTo(@0);
            make.center.equalTo(@0);
        }];
        [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.greaterThanOrEqualTo(@10);
            make.right.lessThanOrEqualTo(@-10);
            make.centerX.equalTo(@0);
            make.top.equalTo(@0);
        }];
        [_lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.greaterThanOrEqualTo(@10);
            make.right.lessThanOrEqualTo(@-10);
            make.centerX.equalTo(@0);
            make.top.equalTo(_lblTitle.mas_bottom).offset(8);
            make.bottom.equalTo(@0);
        }];
        _lblTitle.font = kFONT13;
        _lblDesc.font = kFONT11;
        
    }
    return self;
}

@end

@interface FNMineAccountCell()
@property (nonatomic, strong) UIView *vBackground;

@property (nonatomic, strong) UIView *vLine1;
@property (nonatomic, strong) UIView *vLine2;
@property (nonatomic, strong) UIView *vLine3;

@property (nonatomic, strong) UIView *vCenter;


@property (nonatomic, strong) NSMutableArray<FNMineAccountCenterView*>* centers;

@end

@implementation FNMineAccountCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _centers = [[NSMutableArray alloc] init];
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _vBackground = [[UIView alloc] init];
    _imgBackground = [[UIImageView alloc] init];
    _lblCommissionTitle = [[UILabel alloc] init];
    _lblCommission = [[UILabel alloc] init];
    _lblCommissionDesc = [[UILabel alloc] init];
    _vCommission = [[UIView alloc] init];
    _btnCommission = [[UIButton alloc] init];
    _vCenter = [[UIView alloc] init];
    _vBottomLeft = [[UIView alloc] init];
    UIView *vBL = [[UIView alloc] init];
    _lblBottomLeftTitle = [[UILabel alloc] init];
    _lblBottomLeft = [[UILabel alloc] init];
    _vBottomRight = [[UIView alloc] init];
    UIView *vBR = [[UIView alloc] init];
    _lblBottomRightTitle = [[UILabel alloc] init];
    _lblBottomRight = [[UILabel alloc] init];
    _vLine1 = [[UIView alloc] init];
    _vLine2 = [[UIView alloc] init];
    _vLine3 = [[UIView alloc] init];
    
    [self.contentView addSubview:_vBackground];
    [_vBackground addSubview:_imgBackground];
    [_vBackground addSubview:_lblCommissionTitle];
    [_vBackground addSubview:_lblCommission];
    [_vBackground addSubview:_lblCommissionDesc];
    [_vBackground addSubview:_vCommission];
    [_vBackground addSubview:_btnCommission];
    [_vBackground addSubview:_vCenter];
    [_vBackground addSubview:_vBottomLeft];
    [_vBottomLeft addSubview:vBL];
    [vBL addSubview:_lblBottomLeftTitle];
    [vBL addSubview:_lblBottomLeft];
    [_vBackground addSubview:_vBottomRight];
    [_vBottomRight addSubview:vBR];
    [vBR addSubview:_lblBottomRightTitle];
    [vBR addSubview:_lblBottomRight];
    [_vBackground addSubview:_vLine1];
    [_vBackground addSubview:_vLine2];
    [_vBackground addSubview:_vLine3];
    
    [_vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 10, 10, 10));
    }];
    [_imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
//        make.height.mas_equalTo(@180);
    }];
    [_lblCommissionTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vBackground).offset(18);
        make.top.equalTo(_vBackground).offset(18);
    }];
    [_lblCommission mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lblCommissionTitle.mas_right).offset(4);
        make.centerY.equalTo(_lblCommissionTitle);
        make.right.lessThanOrEqualTo(_btnCommission.mas_left);
    }];
    [_lblCommissionDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vBackground).offset(18);
        make.top.equalTo(_lblCommissionTitle.mas_bottom).offset(7);
        make.right.lessThanOrEqualTo(_btnCommission.mas_left);
    }];
    [_vCommission mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_btnCommission).offset(-10);
        make.right.equalTo(_btnCommission).offset(10);
        make.top.bottom.equalTo(_btnCommission);
    }];
    [_btnCommission mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_vBackground).offset(-15);
        make.top.equalTo(_vBackground).offset(20);
//        make.width.mas_equalTo(70);
        make.height.mas_equalTo(24);
    }];
    [_vLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@65);
        make.left.equalTo(_vBackground).offset(13);
        make.right.equalTo(_vBackground).offset(-13);
        make.height.mas_equalTo(1);
    }];
    [_vCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_vLine1.mas_bottom);
        make.height.mas_equalTo(@0);
        make.left.right.equalTo(@0);
    }];
    [_vLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_vCenter.mas_bottom);
//        make.bottom.equalTo(@-42);
        make.left.equalTo(_vBackground).offset(13);
        make.right.equalTo(_vBackground).offset(-13);
        make.height.mas_equalTo(1);
    }];
    [_vBottomLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(_vBackground).offset(18);
        make.right.lessThanOrEqualTo(_vBackground.mas_centerX).offset(-18);
//        make.centerX.equalTo(_vBackground.mas_width).dividedBy(4);
//        make.top.equalTo(_vLine3.mas_bottom);
        make.centerY.equalTo(self.vBackground.mas_bottom).offset(-21);
        make.bottom.equalTo(_vBackground);
        make.height.mas_equalTo(42);
    }];
    [vBL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@0);
        make.right.lessThanOrEqualTo(@0);
        make.center.equalTo(@0);
        make.top.bottom.equalTo(@0);
    }];
    [_lblBottomLeftTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.centerY.equalTo(@0);
    }];
    [_lblBottomLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lblBottomLeftTitle.mas_right).offset(4);
        make.centerY.equalTo(@0);
        make.right.equalTo(@0);
    }];
    [_vBottomRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(_vBackground.mas_centerX).offset(18);
        make.right.lessThanOrEqualTo(_vBackground).offset(-18);
//        make.centerX.equalTo(_vBackground.mas_width).multipliedBy(0.75);
        make.top.equalTo(_vLine3.mas_bottom);
        make.bottom.equalTo(_vBackground);
        make.height.mas_equalTo(42);
    }];
    [vBR mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@0);
        make.right.lessThanOrEqualTo(@0);
        make.center.equalTo(@0);
        make.top.bottom.equalTo(@0);
    }];
    [_lblBottomRightTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.centerY.equalTo(@0);
    }];
    [_lblBottomRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lblBottomRightTitle.mas_right).offset(4);
        make.centerY.equalTo(@0);
        make.right.equalTo(@0);
    }];
    
//    _vBackground.backgroundColor = UIColor.whiteColor;
//    _vBackground.cornerRadius = 10;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = UIColor.clearColor;
    
    _lblCommissionTitle.textColor = RGB(83, 92, 113);
    _lblCommissionTitle.font = kFONT14;
    
    _lblCommission.textColor = RGB(225, 75, 75);
    _lblCommission.font = kFONT14;
    
    _lblCommissionDesc.textColor = RGB(168, 173, 186);
    _lblCommissionDesc.font = kFONT10;
    
    [_btnCommission setTitle:@"立即提现" forState:UIControlStateNormal];
    [_btnCommission setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btnCommission.titleLabel.font = kFONT13;
    [_btnCommission addTarget:self action:@selector(onWithdrawClick)];
    _vCommission.backgroundColor = RGB(255, 60, 60);
    _vCommission.cornerRadius = 12;
    
    _vLine1.backgroundColor = RGB(242, 242, 242);
//    _vLine2.backgroundColor = RGB(242, 242, 242);
    _vLine3.backgroundColor = RGB(242, 242, 242);
    
    _lblBottomLeftTitle.textColor = RGB(83, 92, 113);
    _lblBottomLeftTitle.font = kFONT11;
    _lblBottomLeft.textColor = RGB(17, 185, 254);
    _lblBottomLeft.font = kFONT13;
    
    _lblBottomRightTitle.textColor = RGB(83, 92, 113);
    _lblBottomRightTitle.font = kFONT11;
    _lblBottomRight.textColor = RGB(48, 221, 220);
    _lblBottomRight.font = kFONT13;
    @weakify(self);
    [_lblBottomRight addJXTouch:^{
        @strongify(self);
        if ([self.delegate respondsToSelector:@selector(didInviterClick:)])
            [self.delegate didInviterClick:self];
    }];
}

- (void)onWithdrawClick {
    if (_delegate && [_delegate respondsToSelector:@selector(didWithdrawClick:)]) {
        [_delegate didWithdrawClick:self];
    }
}

- (void) setPadding: (CGFloat)padding {
    [_vBackground mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, padding, padding, padding));
    }];
}

- (void) setCenterWithTitles: (NSArray<NSString*>*)titles descs: (NSArray<NSString*>*)descs colors:(NSArray<UIColor*>*)colors {
    if (titles.count != descs.count || titles.count != colors.count || titles.count == 0) {
        return;
    }
    for (UIView *v in self.centers) {
        [v removeFromSuperview];
    }
    [self.centers removeAllObjects];
    //列
    NSInteger column = titles.count;
    if (titles.count >= 4) {
        column = 2;
    }
    //行
    CGFloat CENTER_HEIGHT = 80;
    NSInteger row = titles.count / column;
    [_vCenter mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CENTER_HEIGHT * row);
    }];
    NSString *unit = [FNCurrentVersion isEqualToString:Setting_checkVersion] ? @"" : @"￥";
    for (NSInteger index = 0; index < titles.count; index ++) {
        FNMineAccountCenterView *view = [[FNMineAccountCenterView alloc] init];
        view.lblTitle.text = [NSString stringWithFormat:@"%@%@", unit, titles[index]];
        view.lblDesc.text = [NSString stringWithFormat:@"%@%@", unit, descs[index]];
        view.lblTitle.textColor = colors[index];
        view.lblDesc.textColor = colors[index];
        [self.vCenter addSubview:view];
        [self.centers addObject:view];
        NSInteger i = index % column;
        NSInteger r = index / column;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.equalTo(@0);
            } else {
                make.left.equalTo(self.centers[index - 1].mas_right);
                make.width.equalTo(self.centers[index - 1]);
            }
            make.height.mas_equalTo(CENTER_HEIGHT);
            if (r == 0) {
                make.top.equalTo(@0);
            } else {
                make.top.equalTo(self.centers[index - column].mas_bottom);
            }
            if (i == column - 1) {
                make.right.equalTo(@0);
            }
        }];
        
    }
    
}

@end
