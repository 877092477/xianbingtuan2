//
//  FNCmbDoubleTextButton.h
//  LikeKaGou
//
//  Created by jimmy on 16/9/28.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  双文字按钮：上下
 */
@class FNCmbDoubleTextButton;
typedef void(^buttonOnClickedBtn)(FNCmbDoubleTextButton * view);
@interface FNCmbDoubleTextButton : UIView
@property (nonatomic) BOOL isHiidenTop;

@property (nonatomic, weak) UIButton* topLable;
@property (nonatomic, weak) UIButton* bottomLabel;
@property (nonatomic, strong) UIColor* selectedColor;
@property (nonatomic, strong) UIColor* normalColor;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, copy) buttonOnClickedBtn clickedBlock;
@end
