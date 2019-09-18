//
//  FNNetCouponeHeaderView.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/11.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNNetCouponeHeaderView : UIView

@property (nonatomic, strong) UIButton *btnRule;
@property (nonatomic, strong) UIImageView *imgCoupone;
@property (nonatomic, strong) UILabel *lblCoupone;
@property (nonatomic, strong) UILabel *lblMoney;
@property (nonatomic, strong) UILabel *lblCouponeDesc;

@property (nonatomic, strong) UIImageView *imgInfo;
@property (nonatomic, strong) UILabel *lblInfo;
@property (nonatomic, strong) UIView *vInfo;
@property (nonatomic, strong) UIButton *btnExcharge;

@end

NS_ASSUME_NONNULL_END
