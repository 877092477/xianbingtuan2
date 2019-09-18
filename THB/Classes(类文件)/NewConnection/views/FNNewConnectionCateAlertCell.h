//
//  FNNewConnectionCateAlertCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/6/13.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNNewConnectionCateAlertCell : UITableViewCell

@property (nonatomic, strong) UILabel *lblTitle;

- (void)setCheck: (BOOL)check;

@end

NS_ASSUME_NONNULL_END
