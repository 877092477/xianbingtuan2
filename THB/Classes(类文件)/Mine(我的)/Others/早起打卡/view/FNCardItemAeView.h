//
//  FNCardItemAeView.h
//  THB
//
//  Created by Jimmy on 2019/2/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNCardItemAeView : UIView
/** 背景img **/
@property (nonatomic, strong)UIImageView* headImg;
/** 描述img **/
@property (nonatomic, strong)UIButton* describeImg;
/** 名字 **/
@property (nonatomic, strong)UILabel* nameLB;
/** 金额  **/
@property (nonatomic, strong)UILabel* sumLB;

@end

NS_ASSUME_NONNULL_END
