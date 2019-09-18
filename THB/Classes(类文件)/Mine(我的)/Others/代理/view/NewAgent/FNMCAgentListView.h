//
//  FNMCAgentListView.h
//  THB
//
//  Created by jimmy on 2017/8/28.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNMCAgentListView : UIView
@property (nonatomic, strong)NSArray *list;
@property (nonatomic, strong)NSMutableArray<UIButton *>* btns;
@property (nonatomic, strong)void (^updateBtnBlock)(NSInteger index);
@property (nonatomic, strong)UIButton* updateBtn;
@property (nonatomic, assign)NSInteger selectedIndex;
@end
