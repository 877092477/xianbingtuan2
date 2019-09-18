//
//  FNNPDShopHeader.h
//  THB
//
//  Created by Jimmy on 2017/12/16.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMView.h"

@class JM_NPD_dpArr;
@interface FNNPDShopHeader : JMView
@property (nonatomic, strong)NSArray* titles;
@property (nonatomic, strong)NSArray* images;
@property (nonatomic, strong)JM_NPD_dpArr* model;
@property (nonatomic, strong)UIButton* searchbtn;
@property (nonatomic, copy)void (^returnHeight) (CGFloat height);
@end
