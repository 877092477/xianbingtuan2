//
//  FNFindOrderView.m
//  SuperMode
//
//  Created by jimmy on 2017/8/3.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNFindOrderView.h"
#import "JMTitleScrollView.h"
#import "FNFindAutoView.h"

@interface FNFindOrderView ()<JMTitleScrollViewDelegate>

@property (nonatomic, strong)JMTitleScrollView* titleView;

@property (nonatomic, strong)UIView* autoView;

@property (nonatomic, strong)UIScrollView* handView;
@property (nonatomic, strong)UITextField* textField;
@property (nonatomic, strong) UIImageView* guideImgView;
@end
@implementation FNFindOrderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self jm_setupViews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    self.titleView  = [[JMTitleScrollView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 40)) titleArray:@[@"自动找回",@"手动找回"] fontSize:14 _textLength:4 andButtonSpacing:10 type:(StableType)];
    self.titleView.tDelegate = self;
    [self addSubview:self.titleView];
    [self.titleView setBottomViewAtIndex:0];
    [self.titleView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [self.titleView autoSetDimension:(ALDimensionHeight) toSize:40];
    [self setupautoView];
    [self setuphandView];
    
}
- (void)setupautoView{
    _autoView = [UIView new];
    _autoView.backgroundColor = FNHomeBackgroundColor;
    [self addSubview:_autoView];
    [_autoView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    [_autoView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.titleView];
    

    
    FNFindAutoView* auView = [[FNFindAutoView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 277))];
    [auView.autoBtn addTarget:self action:@selector(autoBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    auView.backgroundColor = FNWhiteColor;
    [self.autoView addSubview:auView];
    [auView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [auView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:auView.btmLabel withOffset:15];
    
    
}
- (void)setuphandView{
    _handView = [UIScrollView new];
    _handView.alpha = 0.0;
    _handView.backgroundColor = FNHomeBackgroundColor;
    [self addSubview:_handView];
    [_handView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    [_handView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.titleView];
    
    UIView* topView = [UIView new];
    topView.backgroundColor = FNWhiteColor;
    [self.handView addSubview:topView];
    [topView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [topView autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
    [topView autoSetDimension:(ALDimensionWidth) toSize:FNDeviceWidth];
    
    CGFloat btnH = 40;
    UIView* tView = [UIView new];
    tView.backgroundColor = FNHomeBackgroundColor;
    [topView addSubview:tView];
    [tView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(10, 15, 10, 15)) excludingEdge:(ALEdgeBottom)];
    [tView autoSetDimension:(ALDimensionHeight) toSize:btnH];
    
    UIImageView* icon = [UIImageView new];
    icon.image = IMAGE(@"found_order");
    [icon sizeToFit];
    [tView addSubview:icon];
    [icon autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:15];
    [icon autoSetDimensionsToSize:icon.size];
    [icon autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    _textField = [UITextField new];
    _textField.placeholder = @"请输入淘宝／商城的订单号";
    _textField.font = kFONT14;
    [tView addSubview:_textField];
    [_textField autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, 0, 0, 10)) excludingEdge:(ALEdgeLeft)];
    [_textField autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:icon withOffset:10];
    
    UIButton* confirmBtn = [UIButton buttonWithTitle:@"确定" titleColor:FNWhiteColor font:kFONT14 target:self action:@selector(confirmBtnAction)];
    confirmBtn.backgroundColor = FNMainGobalControlsColor;
    confirmBtn.cornerRadius = 5;
    [topView addSubview:confirmBtn];
    [confirmBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:15];
    [confirmBtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:15];
    [confirmBtn autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:tView withOffset:10];
    [confirmBtn autoSetDimension:(ALDimensionHeight) toSize:btnH];
    
    UILabel *tmpLabel = [UILabel new];
    tmpLabel.text = @"系统订单存入存在一定延时，请下单后十分钟再提交";
    tmpLabel.font = kFONT14;
    tmpLabel.numberOfLines = 0;
    tmpLabel.textColor = FNMainGobalControlsColor;
    [topView addSubview:tmpLabel];
    [tmpLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:15];
    [tmpLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:15];
    [tmpLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:confirmBtn withOffset:10];
    
    [topView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:tmpLabel withOffset:10];
    
    
    _guideImgView = [UIImageView new]    ;
    _guideImgView.image = IMAGE(@"found_pic");
    [_guideImgView sizeToFit];
    [self.handView addSubview:_guideImgView];
    
    CGFloat rate = _guideImgView.height/_guideImgView.width;
    
    [_guideImgView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:30];
    [_guideImgView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:topView withOffset:15];
    [_guideImgView autoSetDimension:(ALDimensionWidth) toSize:[UIScreen mainScreen].bounds.size.width-60];
    [_guideImgView autoMatchDimension:(ALDimensionHeight) toDimension:(ALDimensionWidth) ofView:_guideImgView withMultiplier:rate];
    
    [self.handView layoutIfNeeded];
    if (CGRectGetMaxY(_guideImgView.frame) >= FNDeviceHeight-64-40) {
        self.handView.contentSize = CGSizeMake(FNDeviceWidth, CGRectGetMaxY(_guideImgView.frame));
    }
    
}
- (void)autoBtnAction{
    if (self.autoFineOrderBlock) {
        self.autoFineOrderBlock();
    }
}
- (void)confirmBtnAction{
    if (![_textField.text kr_isNotEmpty]) {
        [_textField kr_shake];
        [FNTipsView showTips:@"请输入您要找回的淘宝订单号~"];
        return;
    }
    [self apiRequestFindOrder];
}
- (void)apiRequestFindOrder{
    [FNTipsView showTips:@"正在找回订单，请稍等..."];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"oid":self.textField.text}];
    params[@"t"] = @"1";
    params [TokenKey] = UserAccessToken;
    [FNRequestTool requestWithParams:params api:_api_mine_reorder respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        
        [FNTipsView showTips:@"找回成功，请稍后到我的返利查看订单信息~"];
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
#pragma mark - JMTitleScrollViewDelegate
- (void)clickedTitleView:(JMTitleScrollView *)titleView atIndex:(NSInteger)index{
    UIView *view = [UIView new];
    UIView *otherview = [UIView new];
    if (index == 0) {
        view = self.autoView;
        otherview = self.handView;
    }else{
        view = self.handView;
        otherview = self.autoView;
        
    }
    [UIView animateWithDuration:0.5 animations:^{
        view.alpha = 1.0;
        otherview.alpha = 0.0;
    }];
}
@end
