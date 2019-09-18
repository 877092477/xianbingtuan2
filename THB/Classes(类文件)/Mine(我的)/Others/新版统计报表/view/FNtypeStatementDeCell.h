//
//  FNtypeStatementDeCell.h
//  THB
//
//  Created by Jimmy on 2018/12/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDSlideBar.h"
#import "ScreeningView.h"
#import "FNstatisticsDeModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNtypeStatementDeCellDegate <NSObject>
// 筛选选择
- (void)intypeStateScreenDupAction:(NSIndexPath*)index withState:(NSInteger)state;

// 选择财务报表 或订单报表
//- (void)intypeStairScreenType:(NSInteger)send;

// 天数 二级筛选
- (void)intypeStairScreenTwoType:(NSInteger)send;

// 三级筛选
- (void)intypeStairScreenThreeType:(NSInteger)send;

@end
@interface FNtypeStatementDeCell : UICollectionViewCell
@property (nonatomic, strong)FDSlideBar *topSlideBar;//分栏内容
@property (nonatomic, strong)FDSlideBar *screeningView;//筛选
@property (nonatomic, strong)UIButton *screenBtn;
@property (nonatomic, strong)UISegmentedControl *segment;
/** model **/
@property (nonatomic, strong)FNstatisticsDeModel* model;
@property (nonatomic, strong)NSMutableArray* timeArray;
@property (nonatomic, strong)NSMutableArray* ordertypeArray;
@property (nonatomic, strong)NSIndexPath *indexPath;
/** delegate **/
@property(nonatomic ,weak) id<FNtypeStatementDeCellDegate> delegate;

@end

NS_ASSUME_NONNULL_END
