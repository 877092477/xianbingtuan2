//
//  FNSaleGoodsViewCell.m
//  THB
//
//  Created by zhongxueyu on 2018/8/20.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNSaleGoodsViewCell.h"
#import "MenuModel.h"

@implementation FNSaleGoodsViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = kIndex_Miaosha_01_Component;
    FNSaleGoodsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    return cell;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
         [self initUI];
        
    }
    return self;
}
-(void)initUI{
    //self.contentView.userInteractionEnabled=YES;
    //self.heatView.userInteractionEnabled=YES;
    self.heatView=[[FNBuyProductHeatNView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, 235)];
    //self.heatView.delegate=self;
    self.heatView.recordInt=1;
    //@WeakObj(self);
    [self.contentView addSubview:self.heatView];
    self.contentView.sd_layout
    .leftEqualToView(self.contentView).topEqualToView(self.contentView).rightEqualToView(self.contentView).bottomEqualToView(self.contentView);
    
  
}
-(void)setSeckillArr:(NSMutableArray *)seckillArr{
    if(seckillArr.count>0){
        self.heatView.heatArr=seckillArr;
        self.heatView.hidden=NO;
    }else{
        self.heatView.hidden=YES;
    }
}

-(void)setRestsDic:(NSDictionary *)restsDic{
    self.heatView.imageDic=restsDic;
    
}

//- (void)ProductHeatClickAction:(FNBaseProductModel *)item{
//    NSLog(@"首页选择");
//}

//-(void)setIndex_tuwenwei_01List:(NSArray<MenuModel *> *)index_tuwenwei_01List{
//    _index_tuwenwei_01List = index_tuwenwei_01List;
//}
//- (void)CheckProductAction{
//    NSMutableArray* tuwenweiArr=[[NSMutableArray alloc]init];
//    for (NSDictionary *dict in self.index_tuwenwei_01List) {
//        MenuModel *tuwenweiModel=[MenuModel mj_objectWithKeyValues:dict];
//        [tuwenweiArr addObject:tuwenweiModel];
//    }
//    if (self.selectMemberShowAll) {
//        self.selectMemberShowAll(tuwenweiArr[0]);
//        }
//}
@end
