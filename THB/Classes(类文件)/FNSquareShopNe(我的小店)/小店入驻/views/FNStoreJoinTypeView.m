//
//  FNStoreJoinTypeView.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/20.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreJoinTypeView.h"
#import "FNStoreJoinTypeCell.h"
#import "FNLeftItemsCollectionViewFlowLayout.h"

@interface FNStoreJoinTypeView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIView *vContent;

@property (nonatomic, strong) UICollectionView *clvCates;

@property (nonatomic, strong) NSArray<NSString*>* tags;
@property (nonatomic, strong) NSArray<NSString*>* selecteds;

@end

@implementation FNStoreJoinTypeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _vContent = [[UIView alloc] init];
    
    [self addSubview:_vContent];
    
    [_vContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    _vContent.backgroundColor = UIColor.whiteColor;
    
    _lblTitle = [[UILabel alloc] init];
    _lblTitle.textColor = RGB(24, 24, 24);
    _lblTitle.font = kFONT12;
    [_vContent addSubview:_lblTitle];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@0);
        make.right.lessThanOrEqualTo(@-20);
    }];
    
    FNLeftItemsCollectionViewFlowLayout* flowlayout = [FNLeftItemsCollectionViewFlowLayout new];
    flowlayout.headerReferenceSize = CGSizeMake(XYScreenWidth, 40);
    flowlayout.footerReferenceSize = CGSizeMake(XYScreenWidth, 40);
    flowlayout.sectionInset = UIEdgeInsetsMake(_jmsize_10, _jmsize_10, _jmsize_10, _jmsize_10);
    if (@available(iOS 10.0, *)) {
        flowlayout.itemSize = UICollectionViewFlowLayoutAutomaticSize;
        flowlayout.estimatedItemSize = CGSizeMake(44, 44);
    }
    flowlayout.estimatedItemSize = CGSizeMake(44, 44);
    flowlayout.minimumInteritemSpacing  = 10;
    flowlayout.minimumLineSpacing  = 10;
    _clvCates = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowlayout];
    _clvCates.backgroundColor=FNWhiteColor;
    _clvCates.showsVerticalScrollIndicator=NO;
    _clvCates.dataSource = self;
    _clvCates.delegate = self;
    _clvCates.emptyDataSetSource = nil;
    _clvCates.emptyDataSetDelegate = nil;
    [_vContent addSubview:_clvCates];
    [_clvCates registerClass:[FNStoreJoinTypeCell class] forCellWithReuseIdentifier:@"FNStoreJoinTypeCell"];
//    [_clvCates registerClass:[FNLiveCouponeSearchHeaderReusableView class]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeader"];
//    [_clvCates registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"sectionFooter"];
    [_clvCates mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(self.lblTitle.mas_bottom).offset(4);
        make.height.mas_equalTo(0);
    }];
}

- (void)setTags: (NSArray<NSString*>*)tags isSelecteds: (NSArray<NSString*>*)isSeleteds{
    if (tags.count != isSeleteds.count) {
        _tags = @[];
        _selecteds = @[];
        [self.clvCates reloadData];
        return;
    }
    _tags = tags;
    _selecteds = isSeleteds;
    [self.clvCates reloadData];
    
    if (tags.count > 0) {
        self.hidden = NO;
        [_clvCates mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.clvCates.collectionViewLayout.collectionViewContentSize);
        }];
    } else {
        self.hidden = YES;
        [_clvCates mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
}

#pragma mark - Collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.tags.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNStoreJoinTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNStoreJoinTypeCell" forIndexPath:indexPath];
    cell.lblTag.text = self.tags[indexPath.row];
    [cell setSelected: [self.selecteds[indexPath.row] isEqualToString:@"1"]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    return [[UIView alloc] init];
}
#pragma mark - Collection view delegate && flow layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString* string = self.tags[indexPath.row];
    CGRect rect =  [string boundingRectWithSize:(CGSizeMake(JMScreenWidth-32, 32)) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:kFONT12} context:nil];
    CGFloat width = rect.size.width+33;
    if (width>=(JMScreenWidth-32)) {
        width = (JMScreenWidth-32);
    }
    CGSize size = CGSizeMake(round(width), 32);
    return size;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(JMScreenWidth, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(JMScreenWidth, 0);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([_delegate respondsToSelector:@selector(typeView:didSelectAt:)]) {
        [_delegate typeView: self didSelectAt:indexPath.row];
    }
}


@end
