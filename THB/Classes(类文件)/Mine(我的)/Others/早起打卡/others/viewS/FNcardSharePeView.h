//
//  FNcardSharePeView.h
//  THB
//
//  Created by 李显 on 2019/2/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNcardSharePeView : UIView
/** bgView **/
@property (nonatomic, strong)UIView* bgView;

/** whiteView **/
@property (nonatomic, strong)UIView* whiteView;
/** 标题  **/
@property (nonatomic, strong)UILabel* titleLB;

@property (nonatomic, strong)UIImageView* imageView;

/** 取消 **/
@property (nonatomic, strong)UIButton *cancelBtn;

/** 1 **/
@property (nonatomic, strong)UIButton *oneBtn;
/** 2  **/
@property (nonatomic, strong)UIButton *twoBtn;
/** 3  **/
@property (nonatomic, strong)UIButton *threeBtn;

/** 左边  **/
@property (nonatomic, strong)UIView* leftLine;
/** 右边  **/
@property (nonatomic, strong)UIView* rightLine;

- (void)dismissAlert;
@end

NS_ASSUME_NONNULL_END
