//
//  FNOrderForGoodsSingleNeCell.h
//  THB
//
//  Created by 李显 on 2018/10/7.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNUpOrderinformationNModel.h"

@interface FNOrderForGoodsSingleNeCell : UITableViewCell
/** 标题 **/
@property (nonatomic, strong)UILabel* lineLB;
/** 标题 **/
@property (nonatomic, strong)UILabel* restsleftLabel;
/** 信息 **/
@property (nonatomic, strong)UILabel* restsrightLabel;
/** model **/
@property (nonatomic, strong)FNUpOrderMsgNModel* model;

@end
