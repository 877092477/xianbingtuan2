//
//  FNArtcleTopStreamerNView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/16.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNArtcleTopStreamerNView.h"

@implementation FNArtcleTopStreamerNView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
}
-(void)setUpAllView{
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    self.titleLB.font=kFONT15;
    self.titleLB.textColor=RGB(51, 51, 51);
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    self.titleLB.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self, 0).rightSpaceToView(self, 10).heightIs(19);
    
    self.bgImgView=[[UIImageView alloc]init];
    [self addSubview:self.bgImgView];
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 70).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    FNArtcleStreamerNLayout* flowLayout = [FNArtcleStreamerNLayout new];
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 29, FNDeviceWidth, 210) collectionViewLayout:flowLayout];
    self.collectionview.dataSource = self;
    self.collectionview.delegate = self;
    self.collectionview.backgroundColor=[UIColor clearColor];
    [self addSubview: self.collectionview];
    [self.collectionview registerClass:[FNArtcleStreamerItemCell class] forCellWithReuseIdentifier:@"FNArtcleStreamerItemCellID"];
    self.collectionview.showsVerticalScrollIndicator = NO;
    self.collectionview.showsHorizontalScrollIndicator = NO;
    
}
#pragma mark -  UICollectionViewDataSource&&
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNEssayItemDModel *model=[FNEssayItemDModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
    FNArtcleStreamerItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNArtcleStreamerItemCellID" forIndexPath:indexPath];
    //cell.backgroundColor=[UIColor whiteColor];
    cell.cornerRadius=10;
    cell.model=model;
    cell.indexS=indexPath;
    cell.delegate=self;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(didStreamerItemAction:)]) {
        [self.delegate didStreamerItemAction:indexPath.row];
    }
}
#pragma mark - Collection view delegate && UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGSize size=CGSizeMake(FNDeviceWidth-130, 180);
    return size;
}
-(void)setDataArr:(NSArray *)dataArr{
    _dataArr=dataArr;
    if(dataArr){
        [self.collectionview reloadData];
        self.bgImgView.image=IMAGE(@"FN_DR_hfBGimg");
        if(dataArr.count>1){
           [_collectionview scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }
    }
}
// 点击头像或者名字FNArtcleStreamerItemCellDelegate
- (void)didArtcleStreamerItemAction:(NSIndexPath*)indexS{
    NSDictionary *dictry=self.dataArr[indexS.row];
    if ([self.delegate respondsToSelector:@selector(didTopStreamerNHeadItemAction:)]) {
        [self.delegate didTopStreamerNHeadItemAction:dictry];
    }
}
//配置cell居中
- (void)fixCellToCenter {
    //最小滚动距离
    float dragMiniDistance = self.bounds.size.width/20.0f;
    if (_dragStartX -  _dragEndX >= dragMiniDistance) {
        _selectedIndex -= 1;//向右
    }else if(_dragEndX -  _dragStartX >= dragMiniDistance){
        _selectedIndex += 1;//向左
    }
    NSInteger maxIndex = [_collectionview numberOfItemsInSection:0] - 1;
    _selectedIndex = _selectedIndex <= 0 ? 0 : _selectedIndex;
    _selectedIndex = _selectedIndex >= maxIndex ? maxIndex : _selectedIndex;
    [self scrollToCenter];
}
//滚动到中间
- (void)scrollToCenter {
    
    [_collectionview scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    
}
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex=selectedIndex;
    
}

#pragma mark -k CollectionDelegate

//手指拖动开始
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _dragStartX = scrollView.contentOffset.x;
}

//手指拖动停止
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    _dragEndX = scrollView.contentOffset.x;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self fixCellToCenter];
    });
}

@end
