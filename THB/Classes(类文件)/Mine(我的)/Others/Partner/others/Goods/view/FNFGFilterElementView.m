//
//  FNFGFilterElementView.m
//  SuperMode
//
//  Created by jimmy on 2017/10/19.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNFGFilterElementView.h"
const CGFloat _fev_top_height = 50;
const CGFloat _fev_mid_height = 34;
const CGFloat _fev_cell_height = 30;
const CGFloat _fev_btm_height = 44;
@interface FNFGFilterElementView()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, strong)UIView * topview;
@property (nonatomic, strong)UITextField* lowpriceTF;
@property (nonatomic, strong)UITextField* highpriceTF;

@property (nonatomic, strong)UIView*  midview;

@property (nonatomic, strong)UIView*  btmview;
@property (nonatomic, strong)UIButton* resetBtn;
@property (nonatomic, strong)UIButton* confirmbtn;

@property (nonatomic, strong)NSLayoutConstraint* collectionConsH;
@end
@implementation FNFGFilterElementView
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
        tmpLabel.text = @"宝贝类型";
        tmpLabel.textColor = FNGlobalTextGrayColor;
        tmpLabel.font = kFONT14;
        [_midview addSubview:tmpLabel];
        [tmpLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jmsize_10];
        [tmpLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
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
    [self.topview autoSetDimension:(ALDimensionHeight) toSize:_fev_top_height];
    
    [self addSubview:self.midview];
    [self.midview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.topview];
    [self.midview autoSetDimension:(ALDimensionHeight) toSize:_fev_mid_height];
    [self.midview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [self.midview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.sectionInset = UIEdgeInsetsMake(0, _jmsize_10, _jmsize_10, _jmsize_10);
    flowlayout.minimumLineSpacing = _jmsize_10;
    flowlayout.minimumInteritemSpacing = _jmsize_10;
    
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:(CGRectZero) collectionViewLayout:flowlayout];
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.dataSource = self;
    
    [self addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.jm_collectionview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [self.jm_collectionview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [self.jm_collectionview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.midview];
    self.collectionConsH = [self.jm_collectionview autoSetDimension:(ALDimensionHeight) toSize:0];
    
    [self addSubview:self.btmview];
    [self.btmview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    [self.btmview autoSetDimension:(ALDimensionHeight) toSize:_fev_btm_height];
    
    self.height = _fev_btm_height +_fev_mid_height+_fev_top_height + self.collectionConsH.constant;
    self.backgroundColor = FNWhiteColor;
    
    self.selectedIndex = -1;
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
    self.selectedIndex = -1;
    if (self.btnClickedAction) {
        self.btnClickedAction();
    }
}


#pragma mark - Collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.types.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    if (cell.contentView.subviews.count>=1) {
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    UIButton* btn = [UIButton buttonWithTitle:self.types[indexPath.item] titleColor:self.selectedIndex == indexPath.item ? FNMainGobalControlsColor:FNGlobalTextGrayColor font:kFONT14 target:self action:nil];
    btn.userInteractionEnabled  = NO;
    btn.cornerRadius = 5;
    if (self.selectedIndex == indexPath.item) {
        btn.borderColor = FNMainGobalControlsColor;
        btn.borderWidth = 1;
        btn.backgroundColor = FNWhiteColor;
    }else{
        btn.borderColor = FNHomeBackgroundColor;
        btn.borderWidth = 1;
        btn.backgroundColor = FNHomeBackgroundColor;
    }
    [cell.contentView addSubview:btn];
    [btn autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    return cell;
}

#pragma mark - Collection view delegate && flow layout
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectedIndex == indexPath.item) {
        self.selectedIndex = -1;
    }else{
        self.selectedIndex = indexPath.item;
    }
    [self.jm_collectionview reloadData];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (JMScreenWidth-_jmsize_10*4)/3.0;
    CGFloat height = _fev_cell_height;
    CGSize size = CGSizeMake(width, height);
    return size;
}
- (void)setTypes:(NSArray *)types{
    _types = types;
    if (_types.count >=1) {
        self.midview.hidden=NO;
        self.jm_collectionview.hidden=NO;
        [self.jm_collectionview reloadData];
        NSInteger count =ceil(_types.count/3.0);
        if (count>=5) {
            count = 5;
        }
        self.collectionConsH.constant = count*(_fev_cell_height+_jmsize_10);
        self.height = _fev_btm_height +_fev_mid_height+_fev_top_height + self.collectionConsH.constant;
    }else{
        self.midview.hidden=YES;
        self.jm_collectionview.hidden=YES;
        self.height = _fev_btm_height+_fev_top_height;
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
