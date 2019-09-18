//
//  FNDisHeaderView.h
//  THB
//
//  Created by jimmy on 2017/5/24.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FNMineSingleSignUpView,FXCenterInfoModel;
@interface FNDisHeaderView : UIView
@property (nonatomic, strong)UIView* avatarView;
@property (nonatomic, strong)UIImageView* avatarImgView;
@property (nonatomic, strong)UIImageView* IDImgview;
@property (nonatomic, strong)UILabel* recommendIDLabel;
@property (nonatomic, strong)UILabel* tipsLabel;

@property (nonatomic, strong)UIView* infonView;
@property (nonatomic, strong)NSMutableArray<FNMineSingleSignUpView *>* views;
@property (nonatomic, strong)FXCenterInfoModel* model;

@property (nonatomic, copy)void (^tapViewBlock)(NSInteger index);
@end
