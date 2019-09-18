//
//  FNShareProdcutView.h
//  SuperMode
//
//  Created by jimmy on 2017/7/26.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNShareProdcutView : UIView
@property (nonatomic, copy)void (^cancelBtnBlock)(void);
@property (nonatomic, copy)void (^shareBtnBlock)(NSInteger index);
@property (nonatomic, copy)void (^shareHeightBlock)(void);
@property (nonatomic, strong)id model;
@end
