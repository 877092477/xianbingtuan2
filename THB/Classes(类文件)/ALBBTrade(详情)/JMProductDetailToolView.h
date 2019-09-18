//
//  JMProductDetailToolView.h
//  THB
//
//  Created by jimmy on 2017/5/25.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNFunctionBtnView.h"
#import "JMProductDetailModel.h"
@interface JMProductDetailToolView : UIView
@property (nonatomic, strong) FNFunctionBtnView* likeView;
@property (nonatomic, strong) UILabel* desLabel;
@property (nonatomic, strong) UIButton* helpBtn;
@property (nonatomic, strong)JMProductDetailModel* model;

@end
