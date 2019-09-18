//
//  JMViewProtocol.h
//  SuperMode
//
//  Created by jimmy on 2017/6/8.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol JMViewModelProtocol;
@protocol JMViewProtocol <NSObject>
@optional

- (instancetype)initWithViewModel:(id <JMViewModelProtocol>)viewModel;

- (void)jm_bindViewModel;
- (void)jm_setupViews;
- (void)jm_addReturnKeyBoard;
@end
