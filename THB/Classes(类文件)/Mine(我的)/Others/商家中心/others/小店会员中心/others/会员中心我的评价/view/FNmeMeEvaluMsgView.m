//
//  FNmeMeEvaluMsgView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/21.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmeMeEvaluMsgView.h"

@implementation FNmeMeEvaluMsgView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
}
-(void)setUpAllView{
    
    UICollectionViewFlowLayout *flowayout=[[UICollectionViewFlowLayout alloc]init]; 
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowayout];
    self.collectionview.dataSource = self;
    self.collectionview.delegate = self;
    self.collectionview.backgroundColor=[UIColor clearColor];
    [self addSubview: self.collectionview];
    self.collectionview.sd_layout
    .leftSpaceToView(self,  0).rightSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
    [self.collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
        [self.collectionview registerClass:[FNmerDiscussDetailsUserCell class] forCellWithReuseIdentifier:@"FNmerDiscussDetailsUserCellID"];
        [self.collectionview registerClass:[FNmerDiscussDeTallyCell class] forCellWithReuseIdentifier:@"FNmerDiscussDeTallyCellID"];
        [self.collectionview registerClass:[FNmerDiscussEvaluateTextCell class] forCellWithReuseIdentifier:@"FNmerDiscussEvaluateTextCellID"];
        [self.collectionview registerClass:[FNmerDiscussImgItemCell class] forCellWithReuseIdentifier:@"FNmerDiscussImgItemCellID"];
//        [self.collectionview registerClass:[FNmerDiscussHandleCell class] forCellWithReuseIdentifier:@"FNmerDiscussHandleCellID"];
        [self.collectionview registerClass:[FNmerDiscussRespondItCell class] forCellWithReuseIdentifier:@"FNmerDiscussRespondItCellID"];
    [self.collectionview registerClass:[FNmeMemberRespondCell class] forCellWithReuseIdentifier:@"FNmeMemberRespondCellID"];
    
    [self.collectionview registerClass:[FNmeMemberMorebaCell class] forCellWithReuseIdentifier:@"FNmeMemberMorebaCellID"];
    self.collectionview.scrollEnabled = NO;
    self.collectionview.showsVerticalScrollIndicator = NO;
    self.collectionview.showsHorizontalScrollIndicator = NO;
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 6;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if(section==0){
        return 1;
    }
    else if(section==1){
        return self.titleArr.count;
    }
    else if(section==2){
        return 1;
    }
    else if(section==3){
        return  self.model.imgs.count;
    }
    else if(section==4){
        return 1;
    }
    else{
        return 1;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        FNmerDiscussDetailsUserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerDiscussDetailsUserCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.model=self.model;
        return cell;
    }
    else if(indexPath.section==1){
        FNmerDiscussDeTallyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerDiscussDeTallyCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.titleLB.text=self.titleArr[indexPath.row];
        return cell;
    }
    else if(indexPath.section==2){
        FNmerDiscussEvaluateTextCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerDiscussEvaluateTextCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.model=self.model;
        return cell;
    }
    else if(indexPath.section==3){
        FNmerDiscussImgItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerDiscussImgItemCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        [cell.imgView setUrlImg:self.model.imgs[indexPath.row]];
        return cell;
    }
    else if(indexPath.section==4){
//        FNmerDiscussHandleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerDiscussHandleCellID" forIndexPath:indexPath];
//        cell.backgroundColor=[UIColor whiteColor];
//        cell.model=self.model;
//        //[cell.likeBtn addTarget:self action:@selector(likeBtnClick)];
//        //[cell.queryBtn addTarget:self action:@selector(queryBtnClick)];
//        return cell;
        
        
        FNmeMemberMorebaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmeMemberMorebaCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.model=self.model;
        [cell.bgBtn addTarget:self action:@selector(lookOverClick)];
        [cell.likeBtn addTarget:self action:@selector(likeBtnClick)];
        [cell.moreBtn addTarget:self action:@selector(moreBtnClick)];
        return cell;
    }
    else{
        if([self.model.sub_comment kr_isNotEmpty]){
            FNmeMemberRespondCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmeMemberRespondCellID" forIndexPath:indexPath];
            cell.backgroundColor=[UIColor whiteColor];
            cell.model=self.model;
            return cell;
        }else{
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID" forIndexPath:indexPath];
            return cell;
        }
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemHeight=55;
    CGFloat itemWith=FNDeviceWidth;
    if(indexPath.section==0){
        itemHeight=55;
        itemWith=FNDeviceWidth;
    }
    else if(indexPath.section==1){
        itemHeight=17;
        NSString *titleStr=self.titleArr[indexPath.row];
        CGFloat titleW=[titleStr kr_getWidthWithTextHeight:17 font:11];
        itemWith=titleW+12;
    }
    else if(indexPath.section==2){
        CGFloat textheight=0;
        CGFloat textWidth=FNDeviceWidth-95;
        if([self.model.content kr_isNotEmpty]){
            textheight=[self.model.content kr_heightWithMaxWidth:textWidth attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        }
        itemHeight=textheight+35;
        itemWith=FNDeviceWidth;
    }
    else if(indexPath.section==3){
        CGFloat imgsItemFloat=(FNDeviceWidth-87)/3;
        itemHeight=imgsItemFloat;
        itemWith=imgsItemFloat;
    }
    else if(indexPath.section==4){
        itemHeight=120;
        itemWith=FNDeviceWidth;
    }
    else if(indexPath.section==5){
        //FNmerReviewItemModel *itemModel=[FNmerReviewItemModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
        CGFloat textheight=0;
        CGFloat textWidth=FNDeviceWidth-75;
        if([self.model.sub_comment kr_isNotEmpty]){
            NSString *jointStr=[NSString stringWithFormat:@"%@:  %@",self.model.sub_comment_str,self.model.sub_comment];
            textheight=[jointStr kr_heightWithMaxWidth:textWidth attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
            itemHeight=textheight+25;
        }else{
            itemHeight=0;
        }
        itemWith=FNDeviceWidth;
    }
    CGSize  size = CGSizeMake(itemWith, itemHeight);
    return  size;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if(section==1){
        return 5;
    }
    else if(section==3){
        return 3;
    }
    return 0;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if(section==1){
        return 5;
    }
    else if(section==3){
        return 3;
    }else{
        return 1;
    }
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section { 
    CGFloat topGap=0;
    CGFloat leftGap=0;
    CGFloat bottomGap=5;
    CGFloat rightGap=0;
    if(section==1){
        leftGap=64;
        rightGap=25;
    }
    else if(section==3){
        bottomGap=10;
        leftGap=64;
        NSArray *imgArr=self.model.imgs; 
        if(imgArr.count<4){
           rightGap=15;
        }else if(imgArr.count>3){
           CGFloat imgsItemFloat=(FNDeviceWidth-87)/3;
           rightGap=imgsItemFloat+18;
        }
    }
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==3){
        if ([self.delegate respondsToSelector:@selector(didmeMeEvaluMsgViewTheImage:withSite:)]) {
            [self.delegate didmeMeEvaluMsgViewTheImage:self.index withSite:indexPath.row];
        }
    }
}
-(void)setModel:(FNmerchentReviewModel *)model{
    _model=model;
    if(model){
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        if(model.imgs.count>0){
           [arrM addObject:@"有图"];
        }
        if([model.star_str kr_isNotEmpty]){
           [arrM addObject:model.star_str];
        }
        self.titleArr=arrM;
        [self.collectionview reloadData];
    }
}
- (NSMutableArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [NSMutableArray array];
    }
    return _titleArr;
}

//进入
-(void)lookOverClick{
    if ([self.delegate respondsToSelector:@selector(didmeMeEvaluMsgEnterIntoAction:)]) {
        [self.delegate didmeMeEvaluMsgEnterIntoAction:self.index];
    }
}
//点赞
-(void)likeBtnClick{
    if ([self.delegate respondsToSelector:@selector(didmeMeEvaluMsgGiveaLikeAction:)]) {
        [self.delegate didmeMeEvaluMsgGiveaLikeAction:self.index];
    }
}
//更多
-(void)moreBtnClick{
    if ([self.delegate respondsToSelector:@selector(didmeMeEvaluMsgMoreAction:)]) {
        [self.delegate didmeMeEvaluMsgMoreAction:self.index];
    }
}
@end
