//
//  FNreckDetailsSeHeader.h
//  THB
//
//  Created by Jimmy on 2018/12/26.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNreckDetailsSeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNreckDetailsSeHeader : UICollectionReusableView
@property (nonatomic, strong)UIView *line;
/** 类型图片例京东 **/
@property (nonatomic, strong)UIImageView* typeImage;
/** 类型文本例京东 **/
@property (nonatomic, strong)UILabel* typeLB;
/** 奖励 **/
@property (nonatomic, strong)UILabel* awardLB;
/** 奖励 **/
@property (nonatomic, strong)UILabel* stateLB; 
/** model **/
@property (nonatomic, strong)FNreckDetailsSeModel* model;

@end

NS_ASSUME_NONNULL_END
