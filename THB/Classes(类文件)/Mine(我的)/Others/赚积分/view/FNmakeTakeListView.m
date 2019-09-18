//
//  FNmakeTakeListView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmakeTakeListView.h"

@implementation FNmakeTakeListView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
}
-(void)setUpAllView{
    
    UICollectionViewFlowLayout *flowayout=[[UICollectionViewFlowLayout alloc]init];
    flowayout.minimumLineSpacing = 0;
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth-44, 60) collectionViewLayout:flowayout];
    self.collectionview.dataSource = self;
    self.collectionview.delegate = self;
    self.collectionview.backgroundColor=[UIColor clearColor];
    [self addSubview: self.collectionview];
    [self.collectionview registerClass:[FNmakeTakeListItemCell class] forCellWithReuseIdentifier:@"FNmakeTakeListItemCellID"];
    self.collectionview.showsVerticalScrollIndicator = NO;
    self.collectionview.showsHorizontalScrollIndicator = NO;
    self.collectionview.scrollEnabled = NO;
}
#pragma mark -  UICollectionViewDataSource&&
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNmakeTakeListItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmakeTakeListItemCellID" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor clearColor];
    FNMakeTaskItemTmodel *model=self.modelArr[indexPath.row];
    cell.model=model;
    cell.indexPath=indexPath;
    cell.delegate=self;
    if(indexPath.row==self.dataArr.count){
       cell.line.hidden=YES;
    }
    return cell;
}
// 点击
- (void)inMakeTakeListItemAction:(NSIndexPath *)indexPath{
    FNMakeTaskItemTmodel *model=self.modelArr[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(inMakeTakeListAction:)]) {
        [self.delegate inMakeTakeListAction:model];
    } 
}
// 点击任务详情
- (void)inMakeTakeListItemDetailsBtnAction:(NSIndexPath *)indexPath{
    FNMakeTaskItemTmodel *model=self.modelArr[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(inMakeTakeListDetailsAction:)]) {
        [self.delegate inMakeTakeListDetailsAction:model];
    }
}
// 点击失败原因
- (void)inMakeTakeListcauseOfFailureAction:(NSIndexPath *)indexPath{
    FNMakeTaskItemTmodel *model=self.modelArr[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(inMakeTakeSeletedCauseOfFailureAction:)]) {
        [self.delegate inMakeTakeSeletedCauseOfFailureAction:model];
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
-(void)rightBtnAction{
    
}
#pragma mark - Collection view delegate && UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=FNDeviceWidth-44;
    CGSize  size=CGSizeMake(with, 105);
    return size;
}
-(void)setDataArr:(NSArray *)dataArr{
    _dataArr=dataArr;
    if(dataArr.count>0){
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        [dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNMakeTaskItemTmodel *model=[FNMakeTaskItemTmodel mj_objectWithKeyValues:obj];
            if(idx==dataArr.count-1){
                model.lineState=1;
            }else{
                model.lineState=0;
            }
            [arrM addObject:model];
        }];
        self.modelArr=arrM;
        self.collectionview.sd_layout
        .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
        [self.collectionview reloadData];
    }
}
-(NSMutableArray *)modelArr{
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
}
@end
