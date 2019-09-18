//
//  FNDetailBottomView.h
//  THB
//
//  Created by Jimmy on 2017/12/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMView.h"
@class FNNewProductDetailModel;
@interface FNDetailBottomView : JMView
@property (nonatomic, strong)FNNewProductDetailModel* model;
@property (nonatomic, copy)void (^btnClicked)(NSInteger index);
@property (nonatomic, assign)BOOL isSearch;
@end
