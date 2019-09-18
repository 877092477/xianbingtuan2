//
//  FNteIndentPhoneNeHeader.h
//  69橙子
//
//  Created by Jimmy on 2018/12/6.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNtendOrderDetailsDeModel.h"
@protocol FNteIndentPhoneNeHeaderDelegate <NSObject>

// 联系
- (void)inTeIndentPhoneAction;

@end

@interface FNteIndentPhoneNeHeader : UITableViewHeaderFooterView
/**  电话       **/
@property(nonatomic, strong) UIButton* phoneBtn;
/**  联系商家    **/
@property(nonatomic, strong) UIButton *relationBtn;
/**  金额       **/
@property(nonatomic, strong) UILabel *sumLb;
/**  topLine   **/
@property(nonatomic, strong) UILabel *topLineLb;
/**  delegate  **/
@property(nonatomic ,weak) id<FNteIndentPhoneNeHeaderDelegate> delegate;
@property(nonatomic , strong)FNtendOrderDetailsDeModel *model;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@end

 
