//
//  FNcateTextNeReusableView.h
//  THB
//
//  Created by Jimmy on 2018/12/17.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FNLeftclassifyModel.h"

@interface FNcateTextNeReusableView : UICollectionReusableView


/** 名字 **/
@property (nonatomic, strong)UILabel* TypeLB;

@property (nonatomic, strong)NSIndexPath* indexPath;

@property (nonatomic, strong)FNLeftclassifyModel* model;
@end

 
