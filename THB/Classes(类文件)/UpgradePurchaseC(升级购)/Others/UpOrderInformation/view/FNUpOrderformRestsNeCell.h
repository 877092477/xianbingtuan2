//
//  FNUpOrderformRestsNeCell.h
//  THB
//
//  Created by 李显 on 2018/10/4.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNUpOrderinformationNModel.h"

@interface FNUpOrderformRestsNeCell : UITableViewCell
/** 订单其他信息左边 **/
@property (nonatomic, strong)UILabel* restsLeftLabel;
/** 订单其他信息右边 **/
@property (nonatomic, strong)UILabel* restsRightLabel;
/** line **/
@property (nonatomic, strong)UILabel* lineLB;
/** model **/
@property (nonatomic, strong)FNUpOrderMsgNModel* model;
@end
