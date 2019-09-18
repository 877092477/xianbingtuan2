//
//  FNStoreManagerGoodsAttriView.m
//  新版嗨如意
//
//  Created by Weller on 2019/8/14.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNStoreManagerGoodsAttriView.h"
#import "FNStoreGoodsModel.h"
#import "FNStoreGoodsAttriTagCell.h"
#import "FNLeftItemsCollectionViewFlowLayout.h"
#import "FNLiveCouponeSearchHeaderReusableView.h"

@interface FNStoreManagerGoodsAttriView()

@property (nonatomic, strong) UIView *vContent;

//@property (nonatomic, strong) NSMutableArray<UIView*> *views;
@property (nonatomic, strong) UICollectionView *clvAttri;

@property (nonatomic, strong) NSArray<FNStoreGoodsSpecManagerModel*>* attris;

@end


@implementation FNStoreManagerGoodsAttriView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        _views = [[NSMutableArray alloc] init];
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
    
    FNLeftItemsCollectionViewFlowLayout* flowlayout = [FNLeftItemsCollectionViewFlowLayout new];
    flowlayout.headerReferenceSize = CGSizeMake(XYScreenWidth, 40);
    flowlayout.footerReferenceSize = CGSizeMake(XYScreenWidth, 40);
    flowlayout.sectionInset = UIEdgeInsetsMake(_jmsize_10, _jmsize_10, _jmsize_10, _jmsize_10);
    if (@available(iOS 10.0, *)) {
        flowlayout.itemSize = UICollectionViewFlowLayoutAutomaticSize;
        flowlayout.estimatedItemSize = CGSizeMake(44, 44);
    }
    flowlayout.estimatedItemSize = CGSizeMake(44, 44);
    flowlayout.minimumInteritemSpacing  = 5;
    flowlayout.minimumLineSpacing  = 5;
    _clvAttri = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowlayout];
    _clvAttri.backgroundColor=FNWhiteColor;
    _clvAttri.showsVerticalScrollIndicator=NO;
    _clvAttri.dataSource = self;
    _clvAttri.delegate = self;
    _clvAttri.emptyDataSetSource = nil;
    _clvAttri.emptyDataSetDelegate = nil;
    [_vContent addSubview:_clvAttri];
    [_clvAttri registerClass:[FNStoreGoodsAttriTagCell class] forCellWithReuseIdentifier:@"FNStoreGoodsAttriTagCell"];
    [_clvAttri registerClass:[FNLiveCouponeSearchHeaderReusableView class]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeader"];
    [_clvAttri registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"sectionFooter"];
    [_clvAttri mas_makeConstraints:^(MASConstraintMaker *make) {

        make.edges.equalTo(@0);
    }];
}

- (void)setAttris: (NSArray<FNStoreGoodsSpecManagerModel*>*)attris {
    _attris = attris;
    [self.clvAttri reloadData];
    if (attris.count > 0) {
        self.hidden = NO;
        [_clvAttri mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(@0);
            make.left.equalTo(@10);
            make.right.equalTo(@-10);
            make.height.mas_equalTo(self.clvAttri.collectionViewLayout.collectionViewContentSize);
        }];
    } else {
        self.hidden = YES;
        [_clvAttri mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(@0);
            make.left.equalTo(@10);
            make.right.equalTo(@-10);
            make.height.mas_equalTo(0);
        }];
    }
}

#pragma mark - Collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.attris[section].list.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.attris.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNStoreGoodsAttriTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNStoreGoodsAttriTagCell" forIndexPath:indexPath];
    cell.lblTag.text = self.attris[indexPath.section].list[indexPath.row].name;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind==UICollectionElementKindSectionHeader) {
        FNLiveCouponeSearchHeaderReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"sectionHeader" forIndexPath:indexPath];
        [reusableview setTitle:self.attris[indexPath.section].name isClearShow:NO];
        reusableview.lblTitle.font = kFONT12;
        reusableview.lblTitle.textColor = RGB(153, 153, 153);
        reusableview.delegate = self;
        return reusableview;
    }else{
        UICollectionReusableView* reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"sectionFooter" forIndexPath:indexPath];
        return reusableview;
    }
}
#pragma mark - Collection view delegate && flow layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString* string = self.attris[indexPath.section].list[indexPath.row].name;
    CGRect rect =  [string boundingRectWithSize:(CGSizeMake(JMScreenWidth-30, 22)) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:kFONT15} context:nil];
    CGFloat width = rect.size.width+20;
    if (width>=(JMScreenWidth-_jmsize_15*2)) {
        width = (JMScreenWidth-_jmsize_15*2);
    }
    CGSize size = CGSizeMake(round(width), 30);
    return size;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(JMScreenWidth, 32);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(JMScreenWidth, 0);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

@end
