//
//  JMProductDetailToolView.m
//  THB
//
//  Created by jimmy on 2017/5/25.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMProductDetailToolView.h"
#import "FNAPIHome.h"

#import "FNBaseProductModel.h"

static const CGFloat _tool_height = 44;
@implementation JMProductDetailToolView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

#pragma mark - api request
-(void)deleteMyLikeMethod:(NSString *)goodsId{
    @WeakObj(self);
    if (goodsId == nil) {
        return;
    }
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{
                                                  @"time":[NSString GetNowTimes],
                                                  @"goodsid":goodsId,
                                                  @"token":UserAccessToken
                                                  }];
    params[SignKey] = [NSString getSignStringWithDictionary:params];
    
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:params url:_api_home_deletemylike successBlock:^(id responseBody) {
        NSDictionary *dict = responseBody;
        XYLog(@"responseBody is %@",responseBody);
        if ([[dict objectForKey:XYSuccess]  isEqual: @1]) {
            selfWeak.likeView.button.selected = NO;
            [FNTipsView showTips:XYDeleteLikeMsg];
        }else {
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
        
    } failureBlock:^(NSString *error) {
        [XYNetworkAPI cancelAllRequest];
        
    }];
    
}
-(void)addMyLikeMethod:(NSString *)goodsId{
    if (goodsId == nil) {
        return;
    }
    @WeakObj(self);
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                                 @"goodsid":goodsId,
                                                                                 @"token":UserAccessToken}];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_home_addmylike successBlock:^(id responseBody) {
        NSDictionary *dict = responseBody;
        XYLog(@"responseBody is %@",responseBody);
        if ([[dict objectForKey:XYSuccess]  isEqual: @1]) {
            
            selfWeak.likeView.button.selected = YES;
            [FNTipsView showTips:XYAddLikeMsg];
        }else {
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
        
    } failureBlock:^(NSString *error) {
        
        [XYNetworkAPI cancelAllRequest];
    }];
    
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    @WeakObj(self);
    _likeView = [[FNFunctionBtnView alloc]initWithFrame:(CGRectMake(0, 0, _tool_height, _tool_height)) btnImage:IMAGE(@"good_love_off") andTitle:@"喜欢"];
    [_likeView addJXTouch:^{
        [selfWeak collectedAction];
    }];
    _likeView.selectedImage = IMAGE(@"good_love_on");
    [self addSubview:_likeView];
    
    _helpBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_helpBtn setImage:IMAGE(@"good_help") forState:UIControlStateNormal];
    [_helpBtn sizeToFit];
    [self addSubview: _helpBtn];
    
    _desLabel = [UILabel new];
    _desLabel.textColor = FNGlobalTextGrayColor;
    _desLabel.font = kFONT14;
    _desLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_desLabel];
    
    //layout
    [_likeView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, _jm_leftMargin, 0, 0)) excludingEdge:(ALEdgeRight)];
    [NSLayoutConstraint constraintWithItem:_likeView attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:_likeView attribute:(NSLayoutAttributeHeight) multiplier:1.0 constant:0].active = YES;
    
    [_helpBtn autoSetDimensionsToSize:CGSizeMake(_helpBtn.width+10, _helpBtn.height+10)];
    [_helpBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_leftMargin];
    [_helpBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [_desLabel autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeLeft) ofView:_helpBtn withOffset:-_jm_margin10*0.5];
    [_desLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_likeView withOffset:_jm_margin10];
    [_desLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    
    
}
- (void)setModel:(JMProductDetailModel *)model{
    _model = model;
    if (_model) {
        self.likeView.button.selected = _model.is_collect.boolValue;
        _desLabel.text = _model.str;
        [_desLabel addSingleAttributed:@{NSForegroundColorAttributeName:RED} ofRange:[_model.str rangeOfString:_model.commission]];
        
    }
}

- (void)collectedAction{
    NSString *token = UserAccessToken;
    if (token == nil  || token.length == 0) {
        //warn user to login
        [FNTipsView showTips:@"登录之后才可以喜欢商品"];
    }else{
        if (self.likeView.button.selected) {
            [self deleteMyLikeMethod:self.model.ID];
        }else{
            [self addMyLikeMethod:self.model.ID];
        }
    }
}
@end
