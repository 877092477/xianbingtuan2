//
//  EvaluateFrame.h
//  THB
//
//  Created by Jimmy on 2018/8/31.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
//评价
#import "EvaluateModel.h"
@interface EvaluateFrame : NSObject

// commit 模型
@property(nonatomic, strong) EvaluateModel *model;

//总高度
@property(nonatomic, assign) CGFloat cellHeight;

@end
