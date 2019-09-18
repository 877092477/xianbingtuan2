//
//  FNMinePromoteCateView.h
//  SuperMode
//
//  Created by jimmy on 2017/10/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMView.h"
#import "FNCmbDoubleTextButton.h"
@interface FNMinePromoteCateView : JMView
@property (nonatomic, strong)UIScrollView* scorllview;
@property (nonatomic, strong)UIView* indicatorView;
@property (nonatomic, strong)NSMutableArray<FNCmbDoubleTextButton *>* btns;
@property (nonatomic, strong)NSArray* titles;
@property (nonatomic, strong)NSArray* contents;
@property (nonatomic, strong)void (^clickedBlock)(NSInteger index);
/**
 *  index
 */
@property (nonatomic, assign)NSInteger index;
@end
