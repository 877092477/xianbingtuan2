//
//  JMMemberUpgradeHeader.m
//  THB
//
//  Created by jimmy on 2017/4/1.
//  Copyright © 2017年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */
#import "JMMemberUpgradeHeader.h"
#import "JMMemberDisplayModel.h"
@interface JMMemberUpgradeHeader ()
@property (nonatomic, weak) UIView* avatarView;
@property (nonatomic, weak) UIImageView*    avatarImgView;
@property (nonatomic, weak) UILabel* IDLabel;
@property (nonatomic, weak) UILabel* restDateLabel;//会员续费


@property (nonatomic, weak) UIView* memberView;
@property (nonatomic, weak) UIImageView* iconImgView;
@property (nonatomic, weak) UILabel* titleLabel;
@property (nonatomic, weak) UILabel* priceLabel;
@property (nonatomic, weak) UILabel* expiredDateLabel;

@property (nonatomic, weak) UIView* codeView;



@property (nonatomic, strong) NSLayoutConstraint *consHeight;
@end
@implementation JMMemberUpgradeHeader
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    [self setUpAvatarView];
    [self setUpMemberView];
    
    UIView *view = [[UIView alloc]initWithFrame:(CGRectMake(0, CGRectGetMaxY(_memberView.frame), FNDeviceWidth, 44))];
    view.backgroundColor = FNWhiteColor;
    view.borderColor = FNHomeBackgroundColor;
    view.borderWidth = 1.0;
    [self addSubview:view];
    _codeView = view;
    
    UITextField* codeTextField =  [[UITextField alloc]init];
    codeTextField.font = kFONT14;
    codeTextField.placeholder = @"请输入邀请码(选填)";
    [view addSubview:codeTextField];
    _codeTextField = codeTextField;
    
    [_codeTextField autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, LeftSpace, 0, 0))];
    [view autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeTop)];
    [view autoSetDimension:(ALDimensionHeight) toSize:44];
    
    self.height = CGRectGetMaxY(view.frame)+10;
    self.backgroundColor = FNHomeBackgroundColor;
}
- (void)setUpAvatarView{
    UIView* avatarView = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 0))];
    avatarView.backgroundColor = RED;
    [self addSubview:avatarView];
    _avatarView = avatarView;
    
    UIImageView* avatarImgView  = [UIImageView new];
    avatarImgView.cornerRadius = 40;
    avatarImgView.borderColor = FNWhiteColor;
    avatarImgView.borderWidth = 1.5;
    [_avatarView addSubview:avatarImgView];
    _avatarImgView = avatarImgView;
    
    UILabel*   IDLabel = [UILabel new];
    IDLabel.textColor = FNWhiteColor;
    IDLabel.font = kFONT14;
    IDLabel.textAlignment = NSTextAlignmentCenter;
    [_avatarView addSubview:IDLabel];
    _IDLabel = IDLabel;
    
    UILabel*   restDateLabel = [UILabel new];
    restDateLabel.textColor = FNWhiteColor;
    restDateLabel.font = kFONT14;
    restDateLabel.textAlignment = NSTextAlignmentCenter;
    [_avatarView addSubview:restDateLabel];
    _restDateLabel = restDateLabel;
    
    CGFloat imgHeight = 80;
    
    [_avatarImgView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:2*10];
    [_avatarImgView autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
    [_avatarImgView autoSetDimensionsToSize:(CGSizeMake(imgHeight, imgHeight))];
    
    [_IDLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_avatarImgView withOffset:LeftSpace];
    [_IDLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:LeftSpace];
    [_IDLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:LeftSpace];
    
    [_restDateLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_IDLabel withOffset:10];
    [_restDateLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:LeftSpace];
    [_restDateLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:LeftSpace];
    
    _avatarView.height = imgHeight+2*(10+LeftSpace) + 16;
    
    [_avatarView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    self.consHeight = [_avatarView autoSetDimension:(ALDimensionHeight) toSize:_avatarView.height ];
    
}

- (void)setUpMemberView{
    UIView *memberView = [[UIView alloc]initWithFrame:(CGRectMake(0, CGRectGetMaxY(_avatarView.frame), FNDeviceWidth, 0))];
    memberView.backgroundColor = FNWhiteColor;
    [self addSubview:memberView];
    _memberView = memberView;
    
    UIImageView* iconImgView = [UIImageView new];
    iconImgView.contentMode = UIViewContentModeScaleAspectFit;
    [_memberView addSubview:iconImgView];
    _iconImgView = iconImgView;
    
    UILabel*    titleLabel = [UILabel new];
    titleLabel.font  = kFONT14;
    [_memberView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    UILabel *priceLabel = [UILabel new];
    priceLabel.font = kFONT14;
    priceLabel.textColor = RED;
    [_memberView addSubview:priceLabel];
    _priceLabel = priceLabel;
    
    UILabel *expiredDateLabel = [UILabel new];
    expiredDateLabel.font = kFONT14;
    expiredDateLabel.textColor = FNMainTextNormalColor;
    [_memberView addSubview:expiredDateLabel];
    _expiredDateLabel = expiredDateLabel;
    
    CGFloat iconHeight = 80;
    [_iconImgView autoSetDimensionsToSize:(CGSizeMake(iconHeight, iconHeight))];
    [_iconImgView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:LeftSpace];
    [_iconImgView autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [_titleLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:LeftSpace];
    [_titleLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeTop) ofView:_iconImgView];
    [_titleLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_iconImgView withOffset:10];
    
    [_priceLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_iconImgView withOffset:10];
    [_priceLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [_priceLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:LeftSpace];
    
    [_expiredDateLabel autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:_iconImgView];
    [_expiredDateLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_iconImgView withOffset:10];
    [_expiredDateLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:LeftSpace];
    
    _memberView.height = iconHeight+10*2;
    
    [_memberView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [_memberView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [_memberView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_avatarView];
    [_memberView autoSetDimension:(ALDimensionHeight) toSize:_memberView.height];
    
}

#pragma mark - setter
-(void)setModel:(JMMemberDisplayModel *)model{
    _model = model;
    if (_model) {
        [_avatarImgView setUrlImg:_model.head_img];
        _IDLabel.text = [NSString stringWithFormat:@"ID: %@",_model.userid];
        
        //
        [_iconImgView setUrlImg:_model.vip_img];
        _titleLabel.text = _model.vip_name;
        _priceLabel.text = [NSString stringWithFormat:@"￥%@",_model.vip_price];
        _expiredDateLabel.text = [NSString stringWithFormat:@"使用期限：%@天",_model.vip_time];
        if (_model.is_yqbt.boolValue) {
            _codeTextField.placeholder = @"请输入邀请码(必填)";
        }else{
            _codeTextField.placeholder = @"请输入邀请码(选填)";
        }
    }
}
- (void)setLessDate:(NSString *)lessDate{
    _lessDate = lessDate;
    _restDateLabel.text = _lessDate;
    
    _codeView.hidden = YES;
    _titleLabel.text = [NSString stringWithFormat:@"购买日期：%@",[NSString getTimeStr:_model.buy_time]];
    _priceLabel.text = [NSString stringWithFormat:@"购买价格：%@",_model.vip_price];
    _titleLabel.textColor  =FNMainTextNormalColor;
    _priceLabel.textColor  =FNMainTextNormalColor;
    
    self.consHeight.constant = 80 +2*(10+LeftSpace) + 16 + 16 +LeftSpace;
    
    self.height = self.consHeight.constant + 80 + 10*2;
}
@end
