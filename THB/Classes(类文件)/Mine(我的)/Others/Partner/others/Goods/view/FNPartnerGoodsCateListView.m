//
//  FNPartnerGoodsCateListView.m
//  SuperMode
//
//  Created by jimmy on 2017/10/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPartnerGoodsCateListView.h"
const CGFloat _pgcl_cell_height = 34;
@interface FNPartnerGoodsCateListCell:UICollectionViewCell
@property (nonatomic, strong)UIButton* btn;
@property (nonatomic, strong)UIImageView* iconimgview;
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end
@implementation FNPartnerGoodsCateListCell
- (UIButton *)btn{
    if (_btn == nil) {
        _btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _btn.titleLabel.font = kFONT14;
        [_btn setTitleColor:FNGlobalTextGrayColor forState:(UIControlStateNormal)];
        [_btn setTitleColor:FNMainGobalControlsColor forState:(UIControlStateSelected)];
        _btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _btn.userInteractionEnabled = NO;
    }
    return _btn;
}
- (UIImageView *)iconimgview{
    if (_iconimgview == nil) {
        _iconimgview = [[UIImageView alloc]initWithImage:IMAGE(@"partner_choose")];
    }
    return _iconimgview;
}
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
    [self.contentView addSubview:self.iconimgview];
    [self.iconimgview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10*2];
    [self.iconimgview autoSetDimensionsToSize:self.iconimgview.size];
    [self.iconimgview autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [self.contentView addSubview:self.btn];
    [self.btn autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, _jmsize_10*2, 0, 0 )) excludingEdge:(ALEdgeRight)];
    [self.btn autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeLeft) ofView:self.iconimgview withOffset:-_jmsize_10];
    
    
}
//class method: get cell instance
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNPartnerGoodsCateListCell";
    FNPartnerGoodsCateListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}
@end
@interface FNPartnerGoodsCateListView()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@end
@implementation FNPartnerGoodsCateListView
#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    UICollectionViewFlowLayout * flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:(CGRectZero) collectionViewLayout:flowlayout];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    [self addSubview:self.jm_collectionview];
    [self.jm_collectionview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
    [self.jm_collectionview registerClass:[FNPartnerGoodsCateListCell class] forCellWithReuseIdentifier:@"FNPartnerGoodsCateListCell"];
}

#pragma mark - Collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.list.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNPartnerGoodsCateListCell* cell = [FNPartnerGoodsCateListCell cellWithCollectionView:collectionView atIndexPath:indexPath];
    [cell.btn setTitle:self.list[indexPath.row] forState:(UIControlStateNormal)];
   
    cell.iconimgview.hidden = indexPath.item != self.selectedIndex;
    cell.btn.selected = indexPath.item == self.selectedIndex;
    return cell;
}

#pragma mark - Collection view delegate && flow layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeMake(JMScreenWidth*0.5, _pgcl_cell_height);
    return size;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedIndex = indexPath.item;
    if (self.selectedBlock) {
        self.selectedBlock(self.selectedIndex, self.selectedIndex>=0? self.list[self.selectedIndex]:nil);
    }
}
- (void)setList:(NSArray *)list{
    _list = list;
    if (_list.count>=1) {
        [self.jm_collectionview reloadData];
        NSInteger max = 8;
        NSInteger count = ceil(self.list.count/2.0);
        if (count>=max) {
            count = max;
        }
        self.height = count*_pgcl_cell_height;
        
    }
}
@end
