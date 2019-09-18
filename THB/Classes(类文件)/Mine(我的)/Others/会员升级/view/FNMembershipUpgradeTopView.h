//
//  FNMembershipUpgradeTopView.h
//  嗨如意
//
//  Created by Fnuo-iOS on 2018/4/20.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MembershipUpgradeModel.h"

@interface FNMembershipUpgradeTopView : UIView

@property (nonatomic, strong)MembershipUpgradeModel* Model;

@property (nonatomic ,weak)UIImageView *BGImageView;

@property (nonatomic ,weak)UIImageView *VipBGImageView;

@property (nonatomic ,weak)UIImageView *HeadPortrait;

@property (nonatomic ,weak)UILabel *Label1;

@property (nonatomic ,weak)UIView *line1;

@property (nonatomic ,weak)UIView *line2;

@property (nonatomic ,weak)UILabel *VipLabel;

@property (nonatomic ,weak)UILabel *PhoneLabel;

@property (nonatomic ,weak)UILabel *Label2;

@property (nonatomic ,weak)UIButton *caozuoBtn1;

@property (nonatomic ,weak)UIButton *caozuoBtn2;

@end
