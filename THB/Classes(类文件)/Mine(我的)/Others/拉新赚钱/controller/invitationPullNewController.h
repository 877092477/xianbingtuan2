//
//  invitationPullNewController.h
//  嗨如意
//
//  Created by Fnuo-iOS on 2018/5/9.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
#import "FNinvitationPullNewModel.h"
#import "FNFunctionView.h"
#import "FNteamPullNewController.h"
#import "FNPullNewDetailController.h"

@interface invitationPullNewController : SuperViewController

@property (nonatomic,strong) FNinvitationPullNewModel *model;

@property (nonatomic,weak) UILabel *TitleLable;

@property (nonatomic,weak) UIScrollView *scrollview;

@property (nonatomic,weak) UIView *BgView;

@property (nonatomic,weak) UIImageView *topImageView;

@property (nonatomic,weak) UIView *shareView;

//@property (nonatomic,weak) UIImageView *shareBGImageView;

@property (nonatomic,strong) FNFunctionView *functionview;

@property (nonatomic,weak) UILabel *OneLabel;

@property (nonatomic,weak) UIView *requirementsView;

@property (nonatomic,weak) UILabel *requirementsLabel;

@end
