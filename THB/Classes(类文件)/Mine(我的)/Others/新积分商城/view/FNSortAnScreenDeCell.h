//
//  FNSortAnScreenDeCell.h
//  THB
//
//  Created by Jimmy on 2019/1/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMTitleScrollView.h"
#import "FDSlideBar.h"
#import "ScreeningView.h"
#import "FNDefiniteStoreNeModel.h"
#import "FNCombinedButton.h"
#import "QJSlideButtonView.h"
#import "JXCategoryView.h"
//#import "FNstatisticsTimeModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNSortAnScreenDeCellDelegate <NSObject>
// 点击分类
- (void)choiceClassifyIntegralClick:(NSString*)send withPlace:(NSInteger)place;
// 点击排序
- (void)choiceRankIntegralClickWithPlace:(NSInteger)place WithState:(NSInteger)state;
@end
@interface FNSortAnScreenDeCell : UICollectionViewCell<JMTitleScrollViewDelegate,JXCategoryViewDelegate>
//分类
@property (nonatomic, strong)JMTitleScrollView* titleView;

@property (nonatomic, strong)QJSlideButtonView* titleTwoView;
//排序
//@property (nonatomic, strong)FDSlideBar *screeningView;
//排序
@property (nonatomic, strong)ScreeningView* screeningView;

@property (nonatomic, strong)UIView* filterview;

@property (nonatomic, strong)NSArray* screeningArray;

@property (nonatomic, strong)NSArray* sortArray;

@property (nonatomic, strong)NSMutableArray* btns;

@property (nonatomic, assign)NSInteger catePlace;

@property (nonatomic, assign)NSInteger sortPalce;

@property (nonatomic, weak) id<FNSortAnScreenDeCellDelegate> delegate;

@property (nonatomic, strong)JXCategoryTitleView *categoryView;
@property (nonatomic, strong)JXCategoryIndicatorLineView *lineView;
@end

NS_ASSUME_NONNULL_END
