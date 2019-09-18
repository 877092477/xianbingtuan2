//
//  FNmemberMessageHeaderview.h
//  THB
//
//  Created by Jimmy on 2018/9/7.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GradeMemberNModel.h"

@interface FNmemberMessageHeaderview : UITableViewHeaderFooterView

/** headerline **/
@property (nonatomic, strong)UILabel *headerline;

/** BgImage **/
@property (nonatomic, strong)UIImageView *BgOneImageView;

/** BgTwoImage **/
@property (nonatomic, strong)UIImageView *BgTwoImageView;

/** BgThreeImage **/
@property (nonatomic, strong)UIImageView *BgThreeImageView;

/** 右边BGImage **/
@property (nonatomic, strong)UIImageView *BgRightBlueImage;

/** 等级 **/
@property (nonatomic, strong)UILabel *RightLB;

/** 邀请码 **/
@property (nonatomic, strong)UILabel *inviteNumberLB;

/** 复制按钮 **/
@property (nonatomic, strong)UIButton *stickvBtn;

/** 邀请码文字 **/
@property (nonatomic, strong)UILabel *invitetitleLB;

/** 余额 **/
@property (nonatomic, strong)UILabel *balanceLB;

/** 余额标题 **/
@property (nonatomic, strong)UILabel *balanceTitleLB;

/** line1 **/
@property (nonatomic, strong)UILabel *lineOne;

/** line2 **/
@property (nonatomic, strong)UILabel *lineTwo;

/** 待收入红包 **/
@property (nonatomic, strong)UILabel *treatLB;

/** 邀请人数 **/
@property (nonatomic, strong)UILabel *invitePeopleLB;

/** 邀请人数 **/
@property (nonatomic, strong)UILabel *invitePeopleLTitleLB;

/** 今天已发红包数 **/
@property (nonatomic, strong)UILabel *todayLB;

/** 数1BG **/
@property (nonatomic, strong)UIImageView *placeOneBGImage;

/** 数2BG **/
@property (nonatomic, strong)UIImageView *placeTwoBGImage;

/** 数3BG **/
@property (nonatomic, strong)UIImageView *placeThreeBGImage;

/** 数4BG **/
@property (nonatomic, strong)UIImageView *placeFourBGImage;

/** 数5BG **/
@property (nonatomic, strong)UIImageView *placeFiveBGImage;

/** 数6BG **/
@property (nonatomic, strong)UIImageView *placeSixBGImage;

/** 数1LB **/
@property (nonatomic, strong)UILabel *placeOneLB;

/** 数2LB **/
@property (nonatomic, strong)UILabel *placeTwoLB;

/** 数3LB **/
@property (nonatomic, strong)UILabel *placeThreeLB;

/** 数4LB **/
@property (nonatomic, strong)UILabel *placeFourLB;

/** 数5LB **/
@property (nonatomic, strong)UILabel *placeFiveLB;

/** 数6LB **/
@property (nonatomic, strong)UILabel *placeSixLB;

/** 个 **/
@property (nonatomic, strong)UILabel *EntriesLB;

@property (nonatomic, strong)GradeMemberNModel *model;

@property (nonatomic, copy)void (^stickupClickString)(GradeMemberNModel * model);
@property (nonatomic, copy)void (^SelectedGradeClick)(GradeMemberNModel * model);

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
