//
//  FNstartiTextDeFooterView.h
//  THB
//
//  Created by Jimmy on 2018/12/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDSlideBar.h"
#import "FNstatisticsDeModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNstartiTextDeFooterViewDegate <NSObject>
// 选择财务报表 或订单报表
- (void)intypeStairScreenType:(NSInteger)send;
@end
@interface FNstartiTextDeFooterView : UICollectionReusableView
/** 提示 **/
@property (nonatomic, strong)UILabel* hintLB;
/** 分栏内容 **/
@property (nonatomic, strong)FDSlideBar *topSlideBar;//分栏内容
/** model **/
@property (nonatomic, strong)FNstatisticsDeModel* model;
/** delegate **/
@property(nonatomic ,weak) id<FNstartiTextDeFooterViewDegate> delegate;
/** 记录 **/
@property (nonatomic, assign)NSInteger topOneType;
@end

NS_ASSUME_NONNULL_END
