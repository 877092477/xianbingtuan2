//
//  JMProductRebateRuleController.h
//  THB
//
//  Created by jimmy on 2017/4/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
extern const CGFloat _product_headerHeight;
@class JMProductDetailRuleModel;
@interface JMProductRebateRuleController : SuperViewController
@property (nonatomic, strong)NSArray<JMProductDetailRuleModel *>* list;
/**
 *  commission
 */
@property (nonatomic, copy)NSString* commission;
@property (nonatomic, copy)void (^closeButtonBlock)(void);
@end
