//
//  JMRebateRuleView.h
//  THB
//
//  Created by jimmy on 2017/4/21.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
extern const CGFloat _rr_rebateBtnheight ;
@interface JMRebateRuleView : UIView
@property (nonatomic, strong)UIImageView* logoImgView;
@property (nonatomic, strong)UIButton* rebateBtn;
@property (nonatomic, strong)UILabel* rebateDetailBtn;
@property (nonatomic, strong)UIWebView* webView;

@property (nonatomic, strong)NSLayoutConstraint* imgHeightCons;
@end
