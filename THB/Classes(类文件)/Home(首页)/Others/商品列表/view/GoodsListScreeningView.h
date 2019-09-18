//
//  GoodsListScreeningView.h
//  THB
//
//  Created by Fnuo-iOS on 2018/5/7.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "JMView.h"

@interface GoodsListScreeningView : JMView

@property (nonatomic, copy)NSString* types;
@property (nonatomic, assign)NSInteger isJdSale;
@property (nonatomic, assign)NSInteger is_tm;

@property (nonatomic, copy)NSString* lowprice;

@property (nonatomic, copy)NSString* highprice;

@property (nonatomic, copy)void (^btnClickedAction)(void);

@end
