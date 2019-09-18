//
//  FNLocationRetrievedNeCell.h
//  69橙子
//
//  Created by 李显 on 2018/12/10.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FNHContactModel.h"

@interface FNLocationRetrievedNeCell : UITableViewCell
/** 名字 **/
@property (nonatomic, strong)UILabel* name;

/** 详细地址 **/
@property (nonatomic, strong)UILabel* address;

/** 距离 **/
@property (nonatomic, strong)UILabel* distance;

/** 图片 **/
@property (nonatomic, strong)UIImageView *stateImage;

/** model **/
@property (nonatomic, strong)FNHsearchModel* model;

@end

 
