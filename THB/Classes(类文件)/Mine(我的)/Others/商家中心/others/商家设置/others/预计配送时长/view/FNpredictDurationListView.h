//
//  FNpredictDurationListView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/26.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSHPopupContainer.h" 
NS_ASSUME_NONNULL_BEGIN
@protocol FNpredictDurationListViewDelegate <NSObject>
// 选择时长
- (void)didpredictPredictDurationListAction:(NSIndexPath*)index withContent:(NSString*)content;

@end
@interface FNpredictDurationListView : UIView<DSHCustomPopupView,UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong)UIButton  *leftBtn;
@property (nonatomic, strong)UIButton  *rightBtn;
@property (nonatomic, strong)NSMutableArray  *dataArr;
@property (nonatomic, strong)NSString  *durationStr;
@property (nonatomic, strong)NSIndexPath  *index;
@property (nonatomic, weak)id<FNpredictDurationListViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
