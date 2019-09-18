//
//  FNNewPeopleWelfareDeCell.h
//  THB
//
//  Created by Jimmy on 2018/12/18.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FNpeopleNewDeView.h"

@interface FNNewPeopleWelfareDeCell : UICollectionViewCell
/** 白色背景 **/
@property (nonatomic, strong)UIView* bgView;

@property (nonatomic, strong)FNpeopleNewDeView* goodsView;

@property (nonatomic, strong)NSArray* dataArr;

@end


