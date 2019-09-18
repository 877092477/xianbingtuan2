//
//  FNrelationFlockItemUeCell.h
//  THB
//
//  Created by 李显 on 2019/1/21.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNrelationFlockItemUeCell : UITableViewCell
/** 头像  **/
@property (nonatomic, strong)UIImageView* photoImage;
/** 状态 **/
@property (nonatomic, strong)UILabel* stateLB;
/** 名字 **/
@property (nonatomic, strong)UILabel* nameLB;
/** 描述 **/
@property (nonatomic, strong)UILabel* representLB;
/** line **/
@property (nonatomic, strong)UIView *line;

@end

NS_ASSUME_NONNULL_END
