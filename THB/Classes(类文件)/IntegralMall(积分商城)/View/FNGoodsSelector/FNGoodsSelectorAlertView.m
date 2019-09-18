//
//  FNGoodsSelectorAlertView.m
//  THB
//
//  Created by Weller Zhao on 2019/1/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNGoodsSelectorAlertView.h"
#import "FNGoodsSelectorCell.h"
#import "LeftAlignmentLayout.h"
#import "FNFNGoodsSelectorTitle.h"
#import "FNGoodsSelectorCountCell.h"

@interface FNGoodsSelectorAlertView()<UICollectionViewDelegate, UICollectionViewDataSource, FNGoodsSelectorCountCellDelegate>

@property (nonatomic, strong) UIView *vBackground;
@property (nonatomic, strong) UIView *vAlertView;

@property (nonatomic, strong) UILabel *lblCount;

@property (nonatomic, strong) UIView *vHeader;

@property (nonatomic, strong) UICollectionView *clvSelector;

@property (nonatomic, strong) NSArray<NSString*>* titles;
@property (nonatomic, strong) NSArray<NSArray<NSString*>*>* datas;

/// 记录每个属性的选择，-1表示未选
@property (nonatomic, strong) NSMutableArray<NSNumber*>* selectedArray;

@property (nonatomic, assign) int maxCount;

@end

@implementation FNGoodsSelectorAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectedArray = [[NSMutableArray alloc] init];
        [self configUI];
    }
    return self;
}

- (void) configUI {
    self.vBackground = [[UIView alloc] init];
    self.vAlertView = [[UIView alloc] init];
    self.vHeader = [[UIView alloc] init];
    self.imgHeader = [[UIImageView alloc] init];
    self.btnClose = [[UIButton alloc] init];
    self.lblPrice = [[UILabel alloc] init];
    self.lblCount = [[UILabel alloc] init];
    self.lblDesc = [[UILabel alloc] init];
    
    LeftAlignmentLayout *layout = [[LeftAlignmentLayout alloc] init];
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    if (@available(iOS 10.0, *)) {
        layout.itemSize = UICollectionViewFlowLayoutAutomaticSize;
        layout.estimatedItemSize = CGSizeMake(44, 26);
    }
    layout.estimatedItemSize = CGSizeMake(60, 26);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.footerReferenceSize = CGSizeMake(XYScreenWidth, 1);
    layout.headerReferenceSize = CGSizeMake(XYScreenWidth, 20);
    self.clvSelector = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.clvSelector registerClass:[FNGoodsSelectorCell class] forCellWithReuseIdentifier:@"FNGoodsSelectorCell"];
    [self.clvSelector registerClass:[FNGoodsSelectorCountCell class] forCellWithReuseIdentifier:@"FNGoodsSelectorCountCell"];
    [self.clvSelector registerClass:[FNFNGoodsSelectorTitle class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNFNGoodsSelectorTitle"];
    
    [self addSubview:self.vBackground];
    [self addSubview:self.vAlertView];
    [self.vAlertView addSubview:self.vHeader];
    [self.vHeader addSubview:self.imgHeader];
    [self.vAlertView addSubview:self.btnClose];
    [self.vAlertView addSubview:self.lblPrice];
    [self.vAlertView addSubview:self.lblCount];
    [self.vAlertView addSubview:self.lblDesc];
    [self.vAlertView addSubview:self.clvSelector];
    
    [self.vBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.vAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(self).multipliedBy(0);
    }];
    [self.vHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(110);
        make.left.equalTo(@20);
        make.top.equalTo(@-25);
    }];
    [self.imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(4, 4, 4, 4));
    }];
    [self.btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-20);
        make.top.equalTo(@20);
        make.width.height.mas_equalTo(20);
    }];
    [self.lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vHeader.mas_right).offset(20);
        make.top.equalTo(@20);
        make.right.lessThanOrEqualTo(self.btnClose).offset(-10);
    }];
    [self.lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vHeader.mas_right).offset(20);
        make.top.equalTo(self.lblPrice.mas_bottom).offset(10);
        make.right.lessThanOrEqualTo(self.btnClose).offset(-10);
    }];
    [self.lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vHeader.mas_right).offset(20);
        make.top.equalTo(self.lblCount.mas_bottom).offset(2);
        make.right.lessThanOrEqualTo(self.btnClose).offset(-10);
    }];
    [self.clvSelector mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(self.vHeader.mas_bottom).offset(20);
    }];
    
    _vBackground.backgroundColor = RGBA(0, 0, 0, 0.3);
    
    _vAlertView.backgroundColor = FNWhiteColor;
    _vHeader.backgroundColor = FNWhiteColor;
    _vHeader.cornerRadius = 4;
    
    _imgHeader.backgroundColor = UIColor.orangeColor;
    
    _lblPrice.text = @"24积分 + 16.9元";
    _lblPrice.textColor = RGB(255, 131, 20);
    _lblPrice.font = [UIFont systemFontOfSize:18];
    
    _lblCount.text = @"库存178件";
    _lblCount.textColor = RGB(24, 24, 24);
    _lblCount.font = kFONT13;
    
    _lblDesc.text = @"选择 颜色  尺码";
    _lblDesc.textColor = RGB(24, 24, 24);
    _lblDesc.font = kFONT13;
    
    self.clvSelector.backgroundColor = UIColor.whiteColor;
    self.clvSelector.delegate = self;
    self.clvSelector.dataSource = self;
    
    self.hidden = YES;
    self.layer.masksToBounds = YES;
    
    [self.btnClose setImage:IMAGE(@"integral_mall_button_close") forState:UIControlStateNormal];
    
    @weakify(self);
    [self.vBackground addJXTouch:^{
        @strongify(self);
        [self dismiss];
    }];
    [self.btnClose addTarget:self action:@selector(dismiss)];
}

- (void)show {
    if (self.hidden == NO)
        return;
    self.hidden = NO;
    @weakify(self);
    [UIView animateWithDuration:0.2 animations:^{
        @strongify(self);
        [self.vAlertView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(@0);
            make.height.equalTo(self).multipliedBy(0.6);
        }];
        [self layoutIfNeeded];
        [self.vAlertView layoutIfNeeded];
    }];
    
}
- (void)dismiss {
    @weakify(self);
    [UIView animateWithDuration:0.2 animations:^{
        @strongify(self);
        [self.vAlertView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(@0);
            make.height.equalTo(self).multipliedBy(0);
        }];
        [self layoutIfNeeded];
        [self.vAlertView layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.titles.count + 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section < self.titles.count) {
        return self.datas[section].count;
    }
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < self.titles.count) {
        FNGoodsSelectorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNGoodsSelectorCell" forIndexPath:indexPath];
        NSString *value = self.datas[indexPath.section][indexPath.row];
        [cell setTitle:value];
        cell.isSelected = self.selectedArray[indexPath.section].integerValue == indexPath.row;
        return cell;
    }
    FNGoodsSelectorCountCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNGoodsSelectorCountCell" forIndexPath:indexPath];
    cell.maxCount = _maxCount;
    cell.count = _count;
    cell.delegate = self;
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < self.titles.count) {
        self.selectedArray[indexPath.section] = @(indexPath.row);
        [collectionView reloadData];
    }
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(XYScreenWidth, 26);
//}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    FNFNGoodsSelectorTitle *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNFNGoodsSelectorTitle" forIndexPath:indexPath];
    if (indexPath.section < self.titles.count && [kind isEqualToString:UICollectionElementKindSectionHeader]) {
        [cell setTitle:self.titles[indexPath.section]];
    } else {
        [cell setTitle:@""];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(XYScreenWidth, 20);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(XYScreenWidth, 0);
}

- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    
    return YES;
    
}

#pragma mark - setter
- (void)setTitles: (NSArray<NSString*>*) titles withDatas: (NSArray<NSArray<NSString*>*>*) datas {
    if (titles.count != datas.count)
        return;
    self.titles = titles;
    self.datas = datas;
    [self.selectedArray removeAllObjects];
    for (NSInteger index = 0; index < self.titles.count; index++) {
        [self.selectedArray addObject:@(-1)];
    }
    [self.clvSelector reloadData];
}


- (void)setMaxCount: (int)maxCount withStock: (int)stock {
    self.lblCount.text = [NSString stringWithFormat:@"库存%d件", stock];
    _maxCount = maxCount;
    _count = 1;
    [self.clvSelector reloadData];
}

#pragma mark - getter
- (NSArray*) getSelectedArray {
    NSArray *array = [self.selectedArray mutableCopy];
    return array;
}

#pragma mark - FNGoodsSelectorCountCellDelegate
- (void) goodSelector: (FNGoodsSelectorCountCell*)cell didCountChange: (int)count {
    self.count = count;
}



@end
