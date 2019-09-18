//
//  FNArtcleAroundSlideCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/23.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNArtcleAroundSlideCell.h"

@implementation FNArtcleAroundSlideCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNArtcleAroundSlideCellID";
    FNArtcleAroundSlideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializedSubviews];
        
    }
    return self;
}

- (void)initializedSubviews{
    self.bgImgView=[[UIImageView alloc]init];
    [self.contentView addSubview:self.bgImgView];
    self.titleLB=[[UILabel alloc]init]; 
    [self.contentView addSubview:self.titleLB];
    self.titleLB.font=[UIFont systemFontOfSize:22];
    self.titleLB.textColor=[UIColor whiteColor];
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self.contentView, 15).rightSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 19).heightIs(29);
    [self addPagerView];
}

- (void)addPagerView {
    
    self.pagerView = [[TYCyclePagerView alloc]init];
    self.pagerView.isInfiniteLoop = NO;
    self.pagerView.autoScrollInterval = 0;
    self.pagerView.dataSource = self;
    self.pagerView.delegate = self;
    self.pagerView.frame=CGRectMake(5, 55, XYScreenWidth-5, 180);
    [self.pagerView registerClass:[FNArticleNewTopSlideItemCCell class] forCellWithReuseIdentifier:@"FNArticleNewTopSlideItemCCellID"];
    [self.contentView addSubview:self.pagerView];
    
    
}
#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    NSArray *bannerArray=self.dataModel.topdata;
    return  bannerArray.count;
}
- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {

    NSArray *bannerArray=self.dataModel.topdata;
    FNEssayItemDModel *model=[FNEssayItemDModel mj_objectWithKeyValues:bannerArray[index]];
    FNArticleNewTopSlideItemCCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"FNArticleNewTopSlideItemCCellID" forIndex:index];
    cell.cornerRadius=0;
    cell.model=model;
    return cell;

}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    //layout.itemSize = CGSizeMake(XYScreenWidth-24, 170);
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(275, 160);
    layout.itemSpacing = 10;//12
    return layout;
    
}
- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index{
    //XYLog(@"点击:%ld",(long)index);
    if ([self.delegate respondsToSelector:@selector(tendAroundSlideCellAction:)]) {
        [self.delegate tendAroundSlideCellAction:index];
    }
}
-(void)setDataModel:(FNExpertNaModel *)dataModel{
    _dataModel=dataModel;
    if(dataModel){
       self.titleLB.text=dataModel.top_title;
       self.titleLB.textColor=[UIColor colorWithHexString:dataModel.top_title_color];
       [self.pagerView reloadData]; 
    }
}
@end
