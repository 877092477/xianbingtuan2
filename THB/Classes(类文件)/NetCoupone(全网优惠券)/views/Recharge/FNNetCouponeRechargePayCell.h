//
//  FNNetCouponeRechargePayCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/12.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNNetCouponeRechargePayCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgIcon;
@property (nonatomic, strong) UILabel *lblTitle;

- (void)setIsSelected:(BOOL)selected;

@end

NS_ASSUME_NONNULL_END
