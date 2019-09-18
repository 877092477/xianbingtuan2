//
//  FNMNineTitleView.m
//  LikeKaGou
//
//  Created by jimmy on 16/10/8.
//  Copyright © 2016年 方诺科技. All rights reserved.
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

#import "FNMNineTitleView.h"
#define MNTVCellWidth (self.width-50)*0.25
#define MNTVCellHeight 34
@interface FNMNineTitleViewCell : UICollectionViewCell
@property (nonatomic, weak) UIButton* btn;
@end
@implementation FNMNineTitleViewCell

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
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"rebate_btn"] forState:UIControlStateSelected];
    [btn setTitleColor:RED forState:UIControlStateSelected];
    btn.titleLabel.font = kFONT12;
    [btn setTitleColor:FNBlackColor forState:UIControlStateNormal];
    btn.userInteractionEnabled = NO;
    [btn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
    _btn = btn;
    [_btn autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
}
- (void)test{
    XYLog(@"ts");
}
//class method: get cell instance
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNMNineTitleViewCell";
    FNMNineTitleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}

@end
@interface FNMNineTitleView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView* collectionView;
@end
@implementation FNMNineTitleView
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
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize = CGSizeMake(MNTVCellWidth, MNTVCellHeight);
    
    CGFloat y = 0 ;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, y, self.width, 0) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = FNWhiteColor;
    [collectionView registerClass:[FNMNineTitleViewCell class] forCellWithReuseIdentifier:@"FNMNineTitleViewCell"];
    [self addSubview:collectionView];
    _collectionView = collectionView;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titles.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNMNineTitleViewCell *cell = [FNMNineTitleViewCell cellWithCollectionView:collectionView atIndexPath:indexPath];
    [cell.btn setTitle:self.titles[indexPath.item] forState:UIControlStateNormal];
    if (indexPath.item == self.selectedIndex) {
        cell.btn.selected = YES;
    }else {
        cell.btn.selected = NO;
    }
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    FNMNineTitleViewCell *cell =(FNMNineTitleViewCell *) [self collectionView:collectionView cellForItemAtIndexPath:indexPath];
//    cell.btn.selected = YES;
    self.selectedIndex = indexPath.item;
    
    if ([self.delegate respondsToSelector:@selector(titleViewCategoryOnclickAtIndex:)]) {
        [self.delegate titleViewCategoryOnclickAtIndex:indexPath.item];
    }
}


#pragma mark - override method
- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    if (_titles && _titles.count>0) {
        CGFloat height = 0;
        if (_titles.count/4 >= 4) {
            height = 5*10+ MNTVCellHeight*4;
        }else {
            NSInteger rows = 0;
            if (_titles.count>4) {
                rows = abs((int)_titles.count/4);
                if (_titles.count%4>0) {
                    rows++;
                }
            }else {
                rows = 1;
            }
            height = (rows +1)*10+MNTVCellHeight*rows;
        }
        _collectionView.height = height;
        self.height = height;
        [_collectionView reloadData];
        
    }
}
- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    [_collectionView reloadData];
}
@end
