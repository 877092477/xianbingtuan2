//
//  FNMembershipUpgradeViewController.h
//  嗨如意
//
//  Created by Fnuo-iOS on 2018/4/20.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
#import "FNMembershipUpgradeTopView.h"
#import "MembershipUpgradeModel.h"
#import "MembershipUpgradeShowModel.h"
#import "FNMCAgentListView.h"
#import "FNPopUpTool.h"
#import "FNMCAgentApplyController.h"
#import "FNPayTypeChooseViewController.h"
#import <AlipaySDK/AlipaySDK.h>

@interface FNMembershipUpgradeViewController : SuperViewController<UIScrollViewDelegate>

@property (nonatomic, strong)MembershipUpgradeModel* Model;

@property (nonatomic ,weak)UIScrollView *bgView;

@property (nonatomic ,strong)FNMembershipUpgradeTopView *TopView;

@property (nonatomic ,weak)UIImageView *MidImageView;

@property (nonatomic ,weak)UIImageView *BottomImageView;

@property (nonatomic ,weak)UILabel *ruleLabel;

@property (nonatomic ,strong)FNMCAgentListView *listview;

@property (nonatomic ,strong)NSArray *showArr1;

@property (nonatomic ,strong)NSArray *showArr2;

@end
