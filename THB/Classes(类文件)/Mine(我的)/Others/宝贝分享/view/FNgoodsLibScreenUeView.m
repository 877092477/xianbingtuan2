//
//  FNgoodsLibScreenUeView.m
//  THB
//
//  Created by 李显 on 2019/1/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNgoodsLibScreenUeView.h"

@implementation FNgoodsLibScreenUeView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
}


-(void)setUpAllView{
    CGFloat placeY=SafeAreaTopHeight+80;
    
    self.bgTopView=[[UIView alloc]init];
    
    self.bgTopView.backgroundColor=[UIColor clearColor];
    
    self.bgTopView.frame=CGRectMake(0, 0, FNDeviceWidth, 0);
    
    [self addSubview:self.bgTopView];
  
    self.bgView=[[UIView alloc]init];
    
    self.bgView.backgroundColor=RGB(246, 245, 245);
    
    self.bgView.frame=CGRectMake(0, placeY, FNDeviceWidth, 0);
    
    [self addSubview:self.bgView];
    
    self.bgTwoView=[[UIView alloc]init];
    
    self.bgTwoView.backgroundColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3];
    
    self.bgTwoView.frame=CGRectMake(0, CGRectGetMaxY(self.bgView.frame), FNDeviceWidth, FNDeviceHeight-CGRectGetMaxY(self.bgView.frame));
    
    [self addSubview:self.bgTwoView];
    
    UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideView)];
    [self.bgTopView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *twotap= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideView)];
    [self.bgTwoView addGestureRecognizer:twotap];
    
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.conditionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 0, FNDeviceWidth-20, 0) collectionViewLayout:flowlayout];
    self.conditionView.backgroundColor=[UIColor whiteColor];
    self.conditionView.dataSource = self;
    self.conditionView.delegate = self;
    self.conditionView.showsVerticalScrollIndicator=NO;
    self.conditionView.showsHorizontalScrollIndicator=NO;
    [self.conditionView registerClass:[FNlibScreenItemUeCell class] forCellWithReuseIdentifier:@"FNsomeItemTeCellId"];
    [self.bgView addSubview:self.conditionView];
    
   
    
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArr.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FNlibScreenItemUeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNsomeItemTeCellId" forIndexPath:indexPath];
    cell.backgroundColor =[UIColor whiteColor];
    FNSomeGoodsCateModel *model=self.dataArr[indexPath.row]; 
    cell.model=model;
    return cell;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=FNDeviceWidth-20;
    if(self.dataArr.count>0){
       FNSomeGoodsCateModel *model=self.dataArr[0];
        NSString *addType=model.addType;
        if([addType isEqualToString:@"sort"]){
            with=FNDeviceWidth-20;
        }else if([addType isEqualToString:@"cate"]){
            with=(FNDeviceWidth-20)/5;
        }
    }
    CGSize size = CGSizeMake(with, 35);
    
    return size;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FNSomeGoodsCateModel *model=self.dataArr[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(ingoodsLibChildTypeAction:)]) {
            [self.delegate ingoodsLibChildTypeAction:model];
    }
    [self hideView];
}
#pragma mark - 隐藏视图
-(void)hideView{
    CGFloat placeY=SafeAreaTopHeight+80;
    CGFloat listheight=4*35;
    if(self.dataArr.count>0){
        FNSomeGoodsCateModel *model=self.dataArr[0];
        NSString *addType=model.addType;
        if([addType isEqualToString:@"sort"]){
            listheight=self.dataArr.count*35;
        }else if([addType isEqualToString:@"cate"]){
            listheight=(self.dataArr.count/5+1)*35;
        }
    }
    self.backgroundColor = [UIColor clearColor];
    self.bgTwoView.frame=CGRectMake(0, placeY+listheight, FNDeviceWidth, 0);
    self.bgTwoView.hidden = YES;
    self.bgTopView.hidden = YES;
    self.bgTopView.frame=CGRectMake(0, 0, FNDeviceWidth, 0);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.frame = CGRectMake(0, placeY, FNDeviceWidth, 0);
        self.conditionView.frame = CGRectMake(10, 0, FNDeviceWidth-20, 0);
    } completion:^(BOOL finished) {
        self.hidden = YES;
        self.conditionView.hidden = YES;
        self.bgView.hidden = YES;
        for (UIView *view in self.subviews) {
            view.hidden = YES;
        }
    }];
}
#pragma mark - 显示
-(void)showView{
    CGFloat placeY=SafeAreaTopHeight+80;
    self.bgTopView.hidden = NO;
    self.bgView.hidden = NO;
    self.conditionView.hidden = NO; 
    CGFloat listheight=4*35;
    if(self.dataArr.count>0){
        FNSomeGoodsCateModel *model=self.dataArr[0];
        NSString *addType=model.addType;
        if([addType isEqualToString:@"sort"]){
            listheight=self.dataArr.count*35;
        }else if([addType isEqualToString:@"cate"]){
            listheight=(self.dataArr.count/5+1)*35;
        }
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.frame = CGRectMake(0, placeY, FNDeviceWidth, listheight+10);
        self.conditionView.frame = CGRectMake(10, 0, FNDeviceWidth-20, listheight);
        self.bgTopView.frame=CGRectMake(0, 0, FNDeviceWidth, SafeAreaTopHeight+80);
    } completion:^(BOOL finished) {
        self.bgTwoView.hidden = NO;
        self.bgTwoView.frame=CGRectMake(0, placeY+listheight+10, FNDeviceWidth, FNDeviceHeight-listheight-placeY-10);
    }];
}
-(void)setDataArr:(NSArray *)dataArr{
    _dataArr=dataArr;
    if(dataArr.count>0){
      [self.conditionView reloadData];
    }
}
@end
