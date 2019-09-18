//
//  FNConnectionsSwitchCell.h
//  THB
//
//  Created by Weller Zhao on 2019/3/5.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNConnectionsSwitchCell;
@protocol FNConnectionsSwitchCellDelegate <NSObject>

- (void)switchCell: (FNConnectionsSwitchCell*)cell didChange: (BOOL)isOn;

@end

@interface FNConnectionsSwitchCell : UITableViewCell

@property (nonatomic, strong) UILabel* lblTitle;
@property (nonatomic, strong) UISwitch* swt;

@property (nonatomic, weak) id<FNConnectionsSwitchCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
