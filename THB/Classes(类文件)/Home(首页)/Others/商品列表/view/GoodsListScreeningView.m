//
//  GoodsListScreeningView.m
//  THB
//
//  Created by Fnuo-iOS on 2018/5/7.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "GoodsListScreeningView.h"

const CGFloat _Scr_top_height = 50;
const CGFloat _Scr_mid_height = 50;
const CGFloat _Scr_btm_height = 44;

@interface GoodsListScreeningView()
@property (nonatomic, strong)UIView * topview;
@property (nonatomic, strong)UITextField* lowpriceTF;
@property (nonatomic, strong)UITextField* highpriceTF;

@property (nonatomic, strong)UIView*  midview;
@property (nonatomic, weak)UIButton* TypeBtn;

@property (nonatomic, strong)UIView*  btmview;
@property (nonatomic, strong)UIButton* resetBtn;
@property (nonatomic, strong)UIButton* confirmbtn;

@end

@implementation GoodsListScreeningView

- (UITextField *)lowpriceTF{
    if (_lowpriceTF == nil) {
        _lowpriceTF = [UITextField new];
        _lowpriceTF.borderColor = FNHomeBackgroundColor;
        _lowpriceTF.borderWidth = 1;
        _lowpriceTF.font = kFONT14;
        _lowpriceTF.keyboardType = UIKeyboardTypePhonePad;
        _lowpriceTF.placeholder = @"最低价";
        _lowpriceTF.textAlignment = NSTextAlignmentCenter;
    }
    return _lowpriceTF;
}
- (UITextField *)highpriceTF{
    if (_highpriceTF == nil) {
        _highpriceTF = [UITextField new];
        _highpriceTF.borderColor = FNHomeBackgroundColor;
        _highpriceTF.borderWidth = 1;
        _highpriceTF.font = kFONT14;
        _highpriceTF.placeholder = @"最高价";
        _highpriceTF.keyboardType = UIKeyboardTypePhonePad;
        _highpriceTF.textAlignment = NSTextAlignmentCenter;
    }
    return _highpriceTF;
}

- (UIView *)topview{
    if (_topview == nil) {
        _topview = [UIView new];
        
        UILabel* tmpLabel = [UILabel new];
        tmpLabel.text = @"价格区间(元)";
        tmpLabel.font = kFONT14;
        tmpLabel.textColor = FNGlobalTextGrayColor;
        [_topview addSubview:tmpLabel];
        [tmpLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
        [tmpLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        
        [_topview addSubview:self.lowpriceTF];
        [self.lowpriceTF autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:tmpLabel withOffset:_jmsize_10];
        [self.lowpriceTF autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_topview withMultiplier:0.25];
        [self.lowpriceTF autoSetDimension:(ALDimensionHeight) toSize:34];
        [self.lowpriceTF autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        
        UIView * line = [UIView new];
        line.backgroundColor = FNHomeBackgroundColor;
        [_topview addSubview:line];
        [line autoSetDimension:(ALDimensionWidth) toSize:_jmsize_10];
        [line autoSetDimension:(ALDimensionHeight) toSize:1];
        [line autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [line autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.lowpriceTF withOffset:_jmsize_10];
        
        [_topview addSubview:self.highpriceTF];
        
        [self.highpriceTF autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:line withOffset:_jmsize_10];
        [self.highpriceTF autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_topview withMultiplier:0.25];
        [self.highpriceTF autoSetDimension:(ALDimensionHeight) toSize:34];
        [self.highpriceTF autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    }
    return _topview;
}
- (UIView *)midview{
    if (_midview == nil) {
        _midview = [UIView new];
        
        UILabel* tmpLabel = [UILabel new];
        tmpLabel.text = @"商家类型";
        tmpLabel.textColor = FNGlobalTextGrayColor;
        tmpLabel.font = kFONT14;
        [_midview addSubview:tmpLabel];
        [tmpLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
        [tmpLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        
        UIButton *TypeBtn=[[UIButton alloc] init];
        TypeBtn.titleLabel.font = kFONT14;
        TypeBtn.borderColor = FNHomeBackgroundColor;
        TypeBtn.borderWidth = 1;
        [TypeBtn setTitleColor:FNGlobalTextGrayColor forState:UIControlStateNormal];
        [TypeBtn setTitleColor:FNMainGobalControlsColor forState:UIControlStateSelected];
        [TypeBtn addTarget:self action:@selector(TypeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_midview addSubview:TypeBtn];
        self.TypeBtn=TypeBtn;
        [_TypeBtn autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:tmpLabel withOffset:_jmsize_10];
        [_TypeBtn autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_midview withMultiplier:0.25];
        [_TypeBtn autoSetDimension:(ALDimensionHeight) toSize:34];
        [_TypeBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    }
    return _midview;
}

- (UIButton *)resetBtn{
    if (_resetBtn == nil) {
        _resetBtn = [UIButton buttonWithTitle:@"重置" titleColor:FNGlobalTextGrayColor font:kFONT15 target:self action:@selector(resetBtnAction)];
        _resetBtn.backgroundColor = FNHomeBackgroundColor;
        
    }
    return _resetBtn;
}
- (UIButton *)confirmbtn{
    if (_confirmbtn == nil) {
        
        _confirmbtn = [UIButton buttonWithTitle:@"确定" titleColor:FNWhiteColor font:kFONT15 target:self action:@selector(confirmbtnAction)];
        _confirmbtn.backgroundColor = FNMainGobalControlsColor;
        
    }
    return _confirmbtn;
}
- (UIView *)btmview{
    if (_btmview == nil) {
        _btmview = [UIView new];
        
        [_btmview addSubview:self.resetBtn];
        [self.resetBtn autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeRight)];
        [self.resetBtn autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_btmview withMultiplier:0.5];
        
        [_btmview addSubview:self.confirmbtn];
        [self.confirmbtn autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeLeft)];
        [self.confirmbtn autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_btmview withMultiplier:0.5];
        
    }
    return _btmview;
}
#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    //
    [self addSubview:self.topview];
    [self.topview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.topview autoSetDimension:(ALDimensionHeight) toSize:_Scr_top_height];
    
    [self addSubview:self.midview];
    [self.midview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.topview];
    [self.midview autoSetDimension:(ALDimensionHeight) toSize:_Scr_mid_height];
    [self.midview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [self.midview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    
    [self addSubview:self.btmview];
    [self.btmview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    [self.btmview autoSetDimension:(ALDimensionHeight) toSize:_Scr_btm_height];
    
    self.height = _Scr_btm_height+_Scr_mid_height+_Scr_top_height;
    self.backgroundColor = FNWhiteColor;
}

#pragma mark - action
- (void)confirmbtnAction{
    self.lowprice = self.lowpriceTF.text;
    self.highprice = self.highpriceTF.text;
    
    if (self.btnClickedAction) {
        self.btnClickedAction();
    }
}
- (void)resetBtnAction{
    self.lowprice = nil;
    self.highprice = nil;
    if (self.btnClickedAction) {
        self.btnClickedAction();
    }
}
- (void)TypeBtnAction:(UIButton *)sender{
    sender.selected=!sender.selected;
    if ([self.types isEqualToString:@"仅看天猫"]) {
        if (sender.selected==NO) {
            _TypeBtn.borderColor = FNHomeBackgroundColor;
            self.is_tm=0;
        }else{
            _TypeBtn.borderColor = FNMainGobalControlsColor;
            self.is_tm=1;
        }
    }else{
        if (sender.selected==NO) {
            _TypeBtn.borderColor = FNHomeBackgroundColor;
            self.isJdSale=0;
        }else{
            _TypeBtn.borderColor = FNMainGobalControlsColor;
            self.isJdSale=1;
        }
    }
}

- (void)setTypes:(NSString *)types{
    _types=types;
    if (_types.length==0) {
        self.midview.hidden=YES;
        self.height = _Scr_btm_height+_Scr_top_height;
    }else{
        self.midview.hidden=NO;
        self.height = _Scr_btm_height+_Scr_mid_height+_Scr_top_height;
        [self.TypeBtn setTitle:types forState:UIControlStateNormal];
        if ([self.types isEqualToString:@"仅看天猫"]) {
            if (self.is_tm==1) {
                self.TypeBtn.selected=YES;
                _TypeBtn.borderColor = FNMainGobalControlsColor;
            }else{
                self.TypeBtn.selected=NO;
                _TypeBtn.borderColor = FNHomeBackgroundColor;
            }
        }else{
            if (self.isJdSale==1) {
                self.TypeBtn.selected=YES;
                _TypeBtn.borderColor = FNMainGobalControlsColor;
            }else{
                self.TypeBtn.selected=NO;
                _TypeBtn.borderColor = FNHomeBackgroundColor;
            }
        }
    }
}
- (void)setLowprice:(NSString *)lowprice{
    _lowprice = lowprice;
    self.lowpriceTF.text = _lowprice;
}
- (void)setHighprice:(NSString *)highprice{
    _highprice = highprice;
    self.highpriceTF.text = _highprice;
}

@end

