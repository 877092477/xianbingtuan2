//
//  FNWithdrawView.m
//  SuperMode
//
//  Created by jimmy on 2017/6/15.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNWithdrawView.h"
#import "FNWithdrawViewModel.h"
#import "FNWithdrawContentView.h"

#import "FNWithdrawMOdel.h"
@interface FNWithdrawView ()
@property (nonatomic, strong)FNWithdrawViewModel* viewModel;

@property (nonatomic, strong) UIView* topView;
@property (nonatomic, strong) UIImageView* logoImage;
@property (nonatomic, strong) UIImageView*  topImgView;

@property (nonatomic, strong) FNWithdrawContentView* contentView;

@property (nonatomic, strong) UIView* bottomView;
@property (nonatomic, strong) UILabel* tipsLabel;
@property (nonatomic, strong) UIButton* submitBtn;
@end
@implementation FNWithdrawView
- (instancetype)initWithViewModel:(id<JMViewModelProtocol>)viewModel{
    self.viewModel = (FNWithdrawViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}
#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    self.backgroundColor = FNHomeBackgroundColor;
    _topView  = [UIView new];
    [self addSubview:_topView];
    
    _logoImage = [UIImageView new];
    _logoImage.image = Share_AppIcon;
    [_logoImage sizeToFit];
    _logoImage.size = CGSizeMake(50, 50);
    _logoImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.topView addSubview:_logoImage];
    if(![NSString isEmpty:[FNBaseSettingModel settingInstance].AppIcon]){
        [_logoImage setUrlImg:[FNBaseSettingModel settingInstance].AppIcon];
    }
    
    _topImgView = [UIImageView new];
    _topImgView.image = IMAGE(@"wd_into_alipay");
    [_topImgView sizeToFit];
    [self.topView addSubview:_topImgView];
    
    
    _contentView = [[FNWithdrawContentView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 0))];
    _contentView.backgroundColor = FNWhiteColor;
    
    [self addSubview:_contentView];
    
    _bottomView = [ UIView new];
    [self addSubview:_bottomView];
    
    _tipsLabel = [UILabel new];
    _tipsLabel.font = kFONT14;
    _tipsLabel.textColor  = FNGlobalTextGrayColor;
    [self.bottomView addSubview:_tipsLabel];
    
    _submitBtn = [UIButton buttonWithTitle:@"提交申请" titleColor:FNWhiteColor font:kFONT14 target:self action:@selector(submitBtnAction)];
    _submitBtn.cornerRadius = 5;
    _submitBtn.backgroundColor = FNMainGobalControlsColor;
    [self.bottomView addSubview:_submitBtn];
    
    //layout
    [_topView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:_jmsize_15*2];
    [_topView autoSetDimension:(ALDimensionWidth) toSize:_logoImage.width+_topImgView.width];
    [_topView autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
    [_topView autoSetDimension:(ALDimensionHeight) toSize:_logoImage.height+ _jmsize_15];
    
    [_logoImage autoSetDimensionsToSize:_logoImage.size];
    [_logoImage autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
    [_logoImage autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    
    [_topImgView autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_logoImage];
    [_topImgView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:_logoImage];
    [_topImgView autoSetDimensionsToSize:_topImgView.size];
    
    
    [_contentView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [_contentView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [_contentView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.topView];
    [_contentView autoSetDimension:(ALDimensionHeight) toSize:_contentView.height];
    
    [_bottomView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.contentView];
    [_bottomView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [_bottomView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    
    [_tipsLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(_jmsize_10, _jmsize_15, 0, _jmsize_15)) excludingEdge:(ALEdgeBottom)];
    
    [_submitBtn autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_tipsLabel withOffset:_jmsize_10];
    [_submitBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_15];
    [_submitBtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_15];
    [_submitBtn autoSetDimension:(ALDimensionHeight) toSize:40];
    
    [_bottomView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:_submitBtn];
    
    [self layoutIfNeeded];
    self.height = CGRectGetMaxY(_bottomView.frame) +_jmsize_15;
    
    
    
}

- (void)jm_bindViewModel{
    [SVProgressHUD show];
    [self.viewModel.refreshDataCommand execute:nil];
    @weakify(self);
    [self.viewModel.refreshUI subscribeNext:^(id x) {
        //
        [SVProgressHUD dismiss];
        @strongify(self);
        [self.topImgView setUrlImg:self.viewModel.model.topImg];
        self.tipsLabel.text = self.viewModel.tips;
        if ([self.viewModel.tips containsString:self.viewModel.model.wxStr]) {
            [self.tipsLabel addSingleAttributed:@{NSForegroundColorAttributeName:FNMainGobalControlsColor} ofRange:[self.viewModel.tips rangeOfString:self.viewModel.model.wxStr]];
        }
        self.contentView.viewModel = self.viewModel;
        [self layoutIfNeeded];
    }];
}
- (void)submitBtnAction{
    if (self.contentView.textField.text.length == 0 || self.contentView.textField.text.floatValue <= 0) {
        [FNTipsView showTips:@"请输入提现金额"];
        return;
    }
    if (self.contentView.textField.text.floatValue > self.viewModel.balance.floatValue) {
        [FNTipsView showTips:self.contentView.balanceLabel.text];
        [self.contentView.balanceLabel kr_shake];
        return;
    }
    if (self.contentView.textField.text.floatValue < self.viewModel.model.txXiaxian.floatValue) {
        [FNTipsView showTips:self.tipsLabel.text];
        [self.tipsLabel kr_shake];
        return;
    }
    [self.contentView.textField resignFirstResponder];
    [self.viewModel.confirmCommand execute:@{@"money":self.contentView.textField.text}];
}
@end
