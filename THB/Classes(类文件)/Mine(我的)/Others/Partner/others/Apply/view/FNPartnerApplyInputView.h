//
//  FNPartnerApplyInputView.h
//  SuperMode
//
//  Created by jimmy on 2017/10/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMView.h"
#import "FNCustomeTextView.h"
#import "FNPartnerApplyTitleView.h"
extern const CGFloat _paiv_top_height;
@interface FNPartnerApplyInputView : JMView
@property (nonatomic, strong)FNPartnerApplyTitleView* topview;

@property (nonatomic, strong)UIView* typedview;
@property (nonatomic, strong)FNCustomeTextView* textview;
@property (nonatomic, strong)UITextField* nameTF;
@property (nonatomic, strong)UITextField* qqTF;
@property (nonatomic, strong)UITextField* phoneTF;

@property (nonatomic, strong)UIView* contactview;
@property (nonatomic, strong)UILabel* contactLabel;

@property (nonatomic, strong)UIButton* applybtn;

@property (nonatomic, copy)void (^applyBlock)(void);
@end
