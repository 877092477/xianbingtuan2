//
//  FNSpeciItemHeadNeView.h
//  THB
//
//  Created by Jimmy on 2018/9/27.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNUpDetailsNModel.h"
@interface FNSpeciItemHeadNeView : UICollectionReusableView
/** 标题数据 */
@property (nonatomic, strong) FNUpGoodsAttrNModel *headTitle;
/* 标题 */
@property (strong , nonatomic)UILabel *headerLabel;
/* 底部View */
@property (strong , nonatomic)UIView *bottomView;
@end
