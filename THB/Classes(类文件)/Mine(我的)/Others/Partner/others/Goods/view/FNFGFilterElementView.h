//
//  FNFGFilterElementView.h
//  SuperMode
//
//  Created by jimmy on 2017/10/19.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMView.h"

@interface FNFGFilterElementView : JMView
@property (nonatomic, strong)NSArray* types;
/**
 *  lowprice
 */
@property (nonatomic, copy)NSString* lowprice;
/**
 *  high
 */
@property (nonatomic, copy)NSString* highprice;
/**
 *  selectedindex
 */
@property (nonatomic, assign)NSInteger selectedIndex;

@property (nonatomic, copy)void (^btnClickedAction)(void);
@end
