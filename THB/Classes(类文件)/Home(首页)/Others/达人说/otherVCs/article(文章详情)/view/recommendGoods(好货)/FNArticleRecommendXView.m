//
//  FNArticleRecommendXView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/18.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNArticleRecommendXView.h"

@implementation FNArticleRecommendXView
- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //self.layer.cornerRadius = 10/2;
        //self.clipsToBounds = YES;
        [self initializedSubviews];
    } return self;
}
// 准备弹出(初始化弹层位置)
- (void)willPopupContainer:(DSHPopupContainer *)container; {
    CGRect frame = self.frame;
    frame.size = CGSizeMake(FNDeviceWidth, 0);
    frame.origin.x = 0;
    frame.origin.y = container.frame.size.height;// - frame.size.height;
    self.frame = frame;
}

// 已弹出(做弹出动画)
- (void)didPopupContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration; {
    
    [UIView animateWithDuration:duration animations:^{
        CGRect frame = CGRectMake(0, container.frame.size.height - 385, FNDeviceWidth,385);
        self.frame = frame; 
    }];
}

// 将要移除(做移除动画)
- (void)willDismissContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration; {
    CGRect frame = self.frame;
    frame.origin.y = container.frame.size.height;
    frame.size.height=0;
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0.f;
    }];
}

- (void)initializedSubviews{
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    self.titleLB.font=kFONT17;
    self.titleLB.text=@"提到的好货";
    self.titleLB.textColor=RGB(51, 51, 51);
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn setImage:IMAGE(@"FN_DR_gbImg") forState:UIControlStateNormal];
    [self addSubview:self.leftBtn];
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 50).rightSpaceToView(self, 50).topSpaceToView(self, 0).heightIs(49);
    self.leftBtn.sd_layout
    .rightSpaceToView(self, 0).topSpaceToView(self, 0).heightIs(49).widthIs(49);
    self.leftBtn.imageView.sd_layout
    .centerXEqualToView(self.leftBtn).centerYEqualToView(self.leftBtn).heightIs(15).widthIs(15); 
    
    CGFloat height=334;
    if(SafeAreaTopHeight>64){
       height=314;
    }
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 49, FNDeviceWidth, height) collectionViewLayout:flowlayout];
    self.collectionview.backgroundColor=[UIColor whiteColor];
    self.collectionview.dataSource = self;
    self.collectionview.delegate = self;
    self.collectionview.showsVerticalScrollIndicator=NO;
    self.collectionview.showsHorizontalScrollIndicator=NO;
    [self.collectionview registerClass:[FNHomeProductSingleRowCell class] forCellWithReuseIdentifier:@"FNHomeProductSingleRowCellID"];
    [self addSubview:self.collectionview];
    
    self.lineView=[[UIView alloc]init];
    self.lineView.backgroundColor=FNColor(246, 246, 246);
    [self addSubview:self.lineView];
    self.lineView.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 49).heightIs(1);
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FNBaseProductModel *model=[FNBaseProductModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
    FNHomeProductSingleRowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNHomeProductSingleRowCellID" forIndexPath:indexPath];
    cell.model=model;
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height=140;
    CGFloat with=FNDeviceWidth; 
    CGSize size = CGSizeMake(with, height);
    return size;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(inRecommendXViewAction:)]) {
        [self.delegate inRecommendXViewAction:indexPath.row];
    }
}
-(void)setDataArr:(NSArray *)dataArr{
    _dataArr=dataArr;
    if(dataArr){
        [self.collectionview reloadData];
    }
}
@end
