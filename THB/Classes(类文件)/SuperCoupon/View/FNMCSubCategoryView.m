//
//  FNMCSubCategoryView.m
//  THB
//
//  Created by jimmy on 2017/10/31.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNMCSubCategoryView.h"

#import "FNCombinedButton.h"
#import "XYTitleModel.h"
#define MCSCELL_WIDTH FNDeviceWidth*0.2
#define MCSCELL_HEIGHT FNDeviceWidth*0.2+16+10
const CGFloat _SBC_margin = 2;
@interface FNMCSubCategoryCell:UICollectionViewCell
@property (nonatomic, strong)UIView* bgview;
@property (nonatomic, strong)UIImageView* imgview;
@property (nonatomic, strong)UILabel* titleLabel;
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation FNMCSubCategoryCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (UIImageView *)imgview{
    if (_imgview == nil) {
        _imgview = [[UIImageView alloc]initWithFrame:(CGRectMake(0, 0, MCSCELL_WIDTH-20, MCSCELL_WIDTH-20))];

    }
    return _imgview;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.font = kFONT13;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UIView *)bgview{
    if (_bgview == nil) {
        _bgview = [UIView new];
        
        [_bgview addSubview:self.imgview];
        [self.imgview autoSetDimensionsToSize:self.imgview.size];
        [self.imgview autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
        [self.imgview autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
        
        [_bgview addSubview:self.titleLabel];
        [self.titleLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.imgview];
        [self.titleLabel autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:self.imgview];
        [self.titleLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.imgview withOffset:_jm_margin10];
        
    }
    return _bgview;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    [self.contentView addSubview:self.bgview];
    [self.bgview autoCenterInSuperview];
    [self.bgview autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:self.imgview];
    [self.bgview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.titleLabel];
}
//class method: get cell instance
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNMCSubCategoryCell";
    FNMCSubCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}
@end
@interface FNMCSubCategoryView()<JMTitleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong)NSMutableArray* btns;

@end
@implementation FNMCSubCategoryView
- (NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray new];
    }
    return _btns;
}
- (JMTitleScrollView *)titleView{
    if (_titleView == nil) {
        _titleView = [[JMTitleScrollView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 40)) titleArray:@[] fontSize:14 _textLength:4 andButtonSpacing:0 type:(VariableType)];
        _titleView.borderColor = FNHomeBackgroundColor;
        _titleView.borderWidth= 1.0;
        _titleView.tDelegate  =self;
    }
    return _titleView;
}
- (UICollectionView *)collectionview{
    if (_collectionview == nil) {
        UICollectionViewFlowLayout * flowlayout = [UICollectionViewFlowLayout new];
        flowlayout.minimumLineSpacing = 0;
        flowlayout.minimumInteritemSpacing = 0;
        flowlayout.sectionInset = UIEdgeInsetsZero;
        flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionview = [[UICollectionView alloc]initWithFrame:(CGRectZero) collectionViewLayout:flowlayout];
        _collectionview.showsHorizontalScrollIndicator = NO;
        _collectionview.dataSource = self;
        _collectionview.backgroundColor = FNWhiteColor;
        _collectionview.delegate = self;
        [_collectionview registerClass:[FNMCSubCategoryCell class] forCellWithReuseIdentifier:@"FNMCSubCategoryCell"];
        
    }
    return _collectionview;
}

- (UIView *)filterview{
    if (_filterview == nil) {
        _filterview = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 40))];
        _filterview.backgroundColor = FNWhiteColor;
        if (self.btns.count>=1) {
            [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self.btns removeAllObjects];
        }
        NSArray* titles = @[@"综合",@"销量",@"最新",@"到手价"];
        CGFloat width = FNDeviceWidth*0.25;
        [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIView* tmpview = nil;
            if (idx<titles.count-1) {
                UIButton* btn = [UIButton buttonWithTitle:obj titleColor:FNBlackColor font:kFONT13 target:self action:@selector(btnClicked:)];
                [btn setTitleColor:FNMainGobalControlsColor forState:(UIControlStateSelected)];
                
                [_filterview addSubview:btn];
                tmpview  = btn;
            }else{
                FNCombinedButton* btn = [[FNCombinedButton alloc]initWithImage:IMAGE(@"high_price_off") selectedImage:IMAGE(@"high_price_down") title:obj font:kFONT13 titleColor:FNBlackColor selectedTitleColor:FNMainGobalControlsColor target:self action:@selector(btnClicked:)];
                [_filterview addSubview:btn];
                tmpview  = btn;
            }
            [tmpview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, width*idx, 0, 0)) excludingEdge:(ALEdgeRight)];
            [tmpview autoSetDimension:(ALDimensionWidth) toSize:width];
            tmpview.tag = idx+100;
            [self.btns addObject:tmpview];
        }];
    }
    return _filterview;
}
#pragma mark - action
- (void)btnClicked:(id)sender{
    UIView *tmp =nil;
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton* btn = sender;
        tmp= btn;
        NSInteger tag = btn.tag-100;
        if (tag == 0) {
            self.type = SCFilterTypeComplex;
        }else if (tag== 1){
            self.type = SCFilterTypeSale;
        }else{
            self.type = SCFilterTypeNew;
        }
        
    }else{
        FNCombinedButton* btn = [self.btns lastObject];
        btn.selected = YES;
        tmp = btn;
        if (self.type == SCFilterTypePriceDescending) {
            self.type = SCFilterTypePriceAscending;
            [btn.titleLabel setImage:IMAGE(@"high_price_up") forState:(UIControlStateSelected)];
        }else{
            self.type = SCFilterTypePriceDescending;
            [btn.titleLabel setImage:IMAGE(@"high_price_down") forState:(UIControlStateSelected)];
        }
    }
    [self.btns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx<self.btns.count) {
            UIButton* btn = obj;
            btn.selected = btn==tmp;
        }else{
            FNCombinedButton* btn = obj;
            btn.selected = btn==tmp;
        }
    }];
    if (self.filterbtnClicked) {
        self.filterbtnClicked(self.type);
    }
    
   
}
#pragma mark - initializedSubviews

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self jm_setupViews];
    }
    return self;
}
- (void)jm_setupViews
{
    self.backgroundColor = FNHomeBackgroundColor;
    [self addSubview:self.titleView];
//    [self.titleView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(5, 0, 0, 0)) excludingEdge:(ALEdgeBottom)];
//    [self.titleView autoSetDimension:(ALDimensionHeight) toSize:self.titleView.height];
    
    self.collectionview.frame = CGRectMake(0, self.titleView.height+_SBC_margin, JMScreenWidth, MCSCELL_HEIGHT);
    [self addSubview:self.collectionview];
//    [self.collectionview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
//    [self.collectionview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
//    [self.collectionview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.titleView withOffset:5];
//    [self.collectionview autoSetDimension:(ALDimensionHeight) toSize:MCSCELL_HEIGHT];
    
    
    [self addSubview:self.filterview];
//    [self.filterview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
//    [self.filterview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
//    [self.filterview autoSetDimension:(ALDimensionHeight) toSize:self.filterview.height];
//    [self.filterview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.collectionview withOffset:5];
    
    [self changeHeight];
}
- (void)changeHeight{
    self.collectionview.y = self.titleView.height+_SBC_margin;
    self.filterview.y = self.titleView.height+self.collectionview.height+(self.subcates.count>=1?_SBC_margin*2:_SBC_margin);
    self.height = (self.subcates.count>=1?_SBC_margin:0)+self.titleView.height+self.collectionview.height+_SBC_margin+self.filterview.height+1;
}
#pragma mark - Collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.subcates.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNMCSubCategoryCell* cell = [FNMCSubCategoryCell cellWithCollectionView:collectionView atIndexPath:indexPath];
    [cell.imgview setUrlImg:self.subcates[indexPath.row].img];
    cell.titleLabel.text = self.subcates[indexPath.row].catename;

    return cell;
}

#pragma mark - Collection view delegate && flow layout
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cateDelegate && [self.cateDelegate respondsToSelector:@selector(clickedTitleView:atIndex:)]) {
        [self.cateDelegate clickedTitleView:nil atIndex:indexPath.row];
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeMake(MCSCELL_WIDTH, MCSCELL_HEIGHT);
    return size;
}
- (void)setCates:(NSArray *)cates{
    _cates = cates;
    self.titleView.titleArray = _cates;
    [self.titleView setBottomViewAtIndex:0];
}
- (void)setSubcates:(NSArray<XYTitleModel *> *)subcates{
    _subcates = subcates;
    if (_subcates.count>=1) {
        self.collectionview.height = MCSCELL_HEIGHT;
        self.collectionview.hidden = NO;
        [self.collectionview reloadData];
    }else{
        self.collectionview.hidden = YES;
        self.collectionview.height = 0;
    }
    [self changeHeight];
    
}

#pragma mark - JMTitleScrollViewDelegate
- (void)clickedTitleView:(JMTitleScrollView *)titleView atIndex:(NSInteger)index{
    if (self.cateDelegate && [self.cateDelegate respondsToSelector:@selector(clickedTitleView:atIndex:)]) {
        [self.cateDelegate clickedTitleView:titleView atIndex:index];
    }
}
@end
