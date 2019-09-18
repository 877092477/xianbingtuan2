//
//  FNConnectionsMessageCell.h
//  THB
//
//  Created by Weller Zhao on 2019/2/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNConnectionsMessageCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgHeader;
@property (nonatomic, strong) UILabel *lblName;
@property (nonatomic, strong) UILabel *lblTime;
@property (nonatomic, strong) UIView *vCount;
@property (nonatomic, strong) UILabel *lblCount;

@end

NS_ASSUME_NONNULL_END
