//
//  FNWithdrawContentView.h
//  SuperMode
//
//  Created by jimmy on 2017/6/15.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMView.h"
#import "FNWithdrawViewModel.h"

@interface FNWithdrawContentView : JMView<UITextFieldDelegate>
@property (nonatomic, strong) UILabel* titlelabel;
@property (nonatomic, strong) UITextField* textField;
@property (nonatomic, strong) UILabel* balanceLabel;
@property (nonatomic, strong) UIButton* withdrawAllBtn;
@property (nonatomic, strong) UIButton* clearAllBtn;
@property (nonatomic, strong)FNWithdrawViewModel* viewModel;
- (void)withdrawAllBtnAction:(UIButton *)btn;
@end
