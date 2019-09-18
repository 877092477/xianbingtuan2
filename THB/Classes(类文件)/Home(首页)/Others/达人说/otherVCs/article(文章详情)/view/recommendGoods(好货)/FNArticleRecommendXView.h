//
//  FNArticleRecommendXView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/18.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSHPopupContainer.h" 
#import "FNHomeProductSingleRowCell.h"
#import "FNBaseProductModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNArticleRecommendXViewDelegate <NSObject>
// 点击提到的好货
- (void)inRecommendXViewAction:(NSInteger)index;
@end
@interface FNArticleRecommendXView : UIView<DSHCustomPopupView,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView* collectionview;
@property(nonatomic,strong)NSArray  *dataArr;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UILabel  *titleLB;
@property(nonatomic,strong)UIView   *lineView;
@property(nonatomic ,weak) id<FNArticleRecommendXViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
