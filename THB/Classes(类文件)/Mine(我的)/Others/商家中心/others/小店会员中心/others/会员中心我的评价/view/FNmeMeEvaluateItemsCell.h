//
//  FNmeMeEvaluateItemsCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/21.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmeMeEvaluMsgView.h"
#import "FNmerchentReviewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmeMeEvaluateItemsCell : UICollectionViewCell
@property (nonatomic, strong)FNmeMeEvaluMsgView *listView;
@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)FNmerchentReviewModel *model;
@end

NS_ASSUME_NONNULL_END
