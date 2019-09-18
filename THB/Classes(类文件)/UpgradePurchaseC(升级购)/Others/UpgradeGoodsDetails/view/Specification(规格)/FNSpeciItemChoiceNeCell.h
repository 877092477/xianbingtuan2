//
//  FNSpeciItemChoiceNeCell.h
//  THB
//
//  Created by Jimmy on 2018/9/27.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNUpDetailsNModel.h"
@interface FNSpeciItemChoiceNeCell : UICollectionViewCell

@property (strong , nonatomic)UILabel *attLabel;

/* 内容数据 */
@property (nonatomic , copy) FNUpGoodsAttrItemNModel *content;
@end
