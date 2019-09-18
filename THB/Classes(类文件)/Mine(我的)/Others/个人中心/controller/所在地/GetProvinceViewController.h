//
//  GetProvinceViewController.h
//  THB
//
//  Created by zhongxueyu on 16/5/10.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "SuperViewController.h"

@interface GetProvinceViewController : SuperViewController

/** 0.选择省 1.选择城市 2.选择地区 */
@property (nonatomic,assign) NSInteger type;

/** 选择的ID */
@property (nonatomic,assign) int selectId;

@end

