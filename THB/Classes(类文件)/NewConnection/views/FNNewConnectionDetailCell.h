//
//  FNNewConnectionDetailCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/6/3.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNNewConnectionDetailCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgBackground;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIButton *btnChat;

@property (nonatomic, strong) UIImageView *imgHeader;
@property (nonatomic, strong) UILabel *lblName;
@property (nonatomic, strong) UIImageView *imgLevel;
@property (nonatomic, strong) UILabel *lblLevel;
@property (nonatomic, strong) UILabel *lblPhone;
@property (nonatomic, strong) UILabel *lblCode;
@property (nonatomic, strong) UILabel *lblWechat;

- (void) updateHeight;
- (void) setPadding: (CGFloat)padding;

@end

NS_ASSUME_NONNULL_END
