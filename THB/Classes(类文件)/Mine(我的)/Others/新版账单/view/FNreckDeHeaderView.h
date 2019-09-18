//
//  FNreckDeHeaderView.h
//  THB
//
//  Created by Jimmy on 2018/12/25.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNreckSetDeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNreckDeHeaderView : UICollectionReusableView
/** 收入 **/
@property (nonatomic, strong)UILabel* incomeLB;
/** 支出 **/
@property (nonatomic, strong)UILabel* disburseLB; 
/** 月份 **/
@property (nonatomic, strong)UILabel* monthLB;
/** 月份img **/
@property (nonatomic, strong)UIImageView* monthImage;
/** model **/
@property (nonatomic, strong)FNreckSetDeModel* model;
@end

NS_ASSUME_NONNULL_END
