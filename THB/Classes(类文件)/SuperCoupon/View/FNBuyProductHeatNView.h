//
//  FNBuyProductHeatNView.h
//  THB
//
//  Created by 李显 on 2018/9/10.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MZTimerLabel.h"

@class FNBaseProductModel;
@protocol FNBuyProductHeatNViewDelegate <NSObject>

- (void)ProductHeatClickAction:(FNBaseProductModel *)item;

- (void)CheckProductAction;

@end

@interface FNBuyProductHeatNView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
/** 标题Image1 **/
@property(nonatomic,strong)UIImageView *titleImage;

/** 查看全部Image **/
@property(nonatomic,strong)UIImageView *directionView;

/** 查看全部  **/
@property(nonatomic,strong)UIButton *checkBtn;

/** 标题Image2 **/
@property(nonatomic,strong)UIImageView *titleTwoImage;

@property(nonatomic,strong)UICollectionView* goodscollectionview;

@property(nonatomic,strong)NSMutableArray* heatArr;
@property(nonatomic,strong)NSDictionary* imageDic;

@property(nonatomic,assign)NSUInteger  recordInt;//1代表首页 2代表超高反界面

@property(nonatomic,strong)UIImageView *timeBgView;
@property (nonatomic, strong)MZTimerLabel* timeLabel;

@property(nonatomic ,weak) id<FNBuyProductHeatNViewDelegate> delegate;

@property (nonatomic, copy)void (^selectHeatCommodityNow)(FNBaseProductModel * model);


@end
