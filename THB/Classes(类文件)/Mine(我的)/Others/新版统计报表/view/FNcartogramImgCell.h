//
//  FNcartogramImgCell.h
//  THB
//
//  Created by Jimmy on 2018/12/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AAChartKit.h"
#import "FNstatisticsDeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNcartogramImgCell : UICollectionViewCell<AAChartViewDidFinishLoadDelegate>
@property (nonatomic, strong)UIView *line;
@property (nonatomic, strong)UIButton *moreBtn;
@property (nonatomic, strong)UIView *grayline;
@property (nonatomic, strong)AAChartModel *aaChartModel;
@property (nonatomic, strong)AAChartView  *aaChartView;
@property (nonatomic, strong)FNstatisticsAnReportModel *model;
@property (nonatomic, strong)NSMutableArray *picDataArr;
@end

NS_ASSUME_NONNULL_END
