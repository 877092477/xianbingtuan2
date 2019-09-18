//
//  FNRightTopReusableView.h
//  THB
//
//  Created by Jimmy on 2018/9/5.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNLeftclassifyModel.h"
@interface FNRightTopReusableView : UICollectionReusableView

/** 图片 **/
@property (nonatomic, strong)UIImageView* advertisingView;

/** 名字 **/
@property (nonatomic, strong)UILabel* TypeLB;

@property (nonatomic, strong)NSIndexPath* indexPath;

@property (nonatomic, strong)FNLeftclassifyModel* model;

@end
