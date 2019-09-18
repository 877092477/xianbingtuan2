//
//  FNNewConnectionGroupCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/6/13.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNNewConnectionGroupCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgHeader;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;
@property (nonatomic, strong) UILabel *lblTime;

- (void)setCount: (NSString*)count;

@end

NS_ASSUME_NONNULL_END
