//
//  FNcategoryShowDeView.m
//  THB
//
//  Created by Jimmy on 2018/12/17.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNcategoryShowDeView.h"
//view
#import "FNLeftClassifyNeViewCell.h"
#import "FNcategoryLeftDeCell.h"
#import "FNoptionRightCollectionViewCell.h"
#import "FNcateTextNeReusableView.h"

@implementation FNcategoryShowDeView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self=[super initWithFrame:frame];
    if (self) {
        [self compositionView];
    }
    return self;
}

#pragma mark -  单元
-(void)compositionView{
    self.leftTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth*0.25, 200) style:UITableViewStylePlain];
    self.leftTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.leftTableview.backgroundColor=[UIColor whiteColor];
    self.leftTableview.dataSource = self;
    self.leftTableview.delegate = self;
    self.leftTableview.showsVerticalScrollIndicator=NO;
    self.leftTableview.showsHorizontalScrollIndicator=NO;
    [self addSubview:self.leftTableview];
    
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 10;
    flowlayout.minimumInteritemSpacing = 10;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.rightCollectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(FNDeviceWidth*0.25, 0, FNDeviceWidth*0.75, 200) collectionViewLayout:flowlayout];
    self.rightCollectionview.backgroundColor=[UIColor whiteColor];
    self.rightCollectionview.showsVerticalScrollIndicator=NO;
    self.rightCollectionview.showsHorizontalScrollIndicator=NO;
    self.rightCollectionview.dataSource = self;
    self.rightCollectionview.delegate = self;
    [self addSubview:self.rightCollectionview];
    [self.rightCollectionview registerClass:[FNoptionRightCollectionViewCell class] forCellWithReuseIdentifier:@"rightClassifycellId"];
    [self.rightCollectionview registerClass:[FNcateTextNeReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    
    self.leftTableview.sd_layout
    .topSpaceToView(self, 0).rightSpaceToView(self, 0).leftSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    self.rightCollectionview.sd_layout
    .topSpaceToView(self, 0).rightSpaceToView(self, 0).leftSpaceToView(self.rightCollectionview, 0).bottomSpaceToView(self, 0);
    
}

#pragma mark -  UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.leftDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNcategoryLeftDeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CategorycellID"];
    if (cell == nil) {
        cell = [[FNcategoryLeftDeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CategorycellID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.evaluate=self.leftDataArr[indexPath.row];
    cell.indexAc=indexPath;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FNLeftclassifyModel *model=self.leftDataArr[indexPath.row];
    //self.leftclassifyID=model.id;
    //self.CategoryItem=model;
    //self.SkipUIIdentifier=model.SkipUIIdentifier;
    for (FNLeftclassifyModel *Fnmode in self.leftDataArr) {
        if (Fnmode.id==model.id) {
            Fnmode.select_type=1;
        }else{
            Fnmode.select_type=0;
        }
    }
    [self.leftTableview reloadData];
    [self scrollToSectionHeader:indexPath.row];
    //[self apiRequestLeftCategory];
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
#pragma mark -  UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (self.leftDataArr.count>0) {
        return self.leftDataArr.count;
    }
    return 0;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.leftDataArr.count>0) {
      FNLeftclassifyModel *mode=self.leftDataArr[section];
      NSArray *twocate=mode.twocate;
      return twocate.count;
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FNoptionRightCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"rightClassifycellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    if (self.leftDataArr.count>0) {
      FNLeftclassifyModel *Leftmode=self.leftDataArr[indexPath.section];
      NSArray *twocate=Leftmode.twocate;
      FNRightclassifyModel* model=[FNRightclassifyModel mj_objectWithKeyValues:twocate[indexPath.row]];
      cell.model=model;//self.rightDataArr[indexPath.row];
    }
    return cell;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
#pragma mark - Collection view delegate && UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=(JMScreenWidth*0.75-40)/3;
    CGSize size = CGSizeMake(with, with+20);
    return size;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNLeftclassifyModel *Leftmode=self.leftDataArr[indexPath.section];
    NSArray *twocate=Leftmode.twocate;
    FNRightclassifyModel* model=[FNRightclassifyModel mj_objectWithKeyValues:twocate[indexPath.row]];
    if ([self.delegate respondsToSelector:@selector(showDeRightViewAction:)]) {
        [self.delegate showDeRightViewAction:model];
    }
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    FNcateTextNeReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    FNLeftclassifyModel *Leftmode=self.leftDataArr[indexPath.section];
    headerView.TypeLB.text=Leftmode.catename;
    headerView.TypeLB.textColor=RGB(246, 55, 151);
    if([[FNBaseSettingModel settingInstance].cates_bj_color kr_isNotEmpty]){
        headerView.TypeLB.textColor=[UIColor colorWithHexString:[FNBaseSettingModel settingInstance].cates_bj_color];
    }
    return headerView;
    
}
//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(JMScreenWidth*0.75-40, 40);
}
-(void)scrollToSectionHeader:(NSInteger)section {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    UICollectionViewLayoutAttributes *attribs =
    [self.rightCollectionview layoutAttributesForSupplementaryElementOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
    CGPoint topOfHeader = CGPointMake(0, attribs.frame.origin.y -
                                      self.rightCollectionview.contentInset.top);
    [self.rightCollectionview setContentOffset:topOfHeader animated:YES];
}

-(void)setLeftDataArr:(NSMutableArray *)leftDataArr{
    _leftDataArr=leftDataArr;
    [self.leftTableview reloadData];
    [self.rightCollectionview reloadData];
}

@end
