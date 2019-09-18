//
//  FNConnectionsHomeCell.h
//  THB
//
//  Created by Weller Zhao on 2019/1/14.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNConnectionsHomeCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgHeader;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;
@property (nonatomic, strong) UILabel *lblPhone;
@property (nonatomic, strong) UILabel *lblType;

- (void)setIsCheck: (BOOL)isCheck;
- (void)setIsShowCheck: (BOOL)isShow;

@end

NS_ASSUME_NONNULL_END
