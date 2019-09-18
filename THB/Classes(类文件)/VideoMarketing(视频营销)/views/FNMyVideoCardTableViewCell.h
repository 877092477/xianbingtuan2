//
//  FNMyVideoCardTableViewCell.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/30.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNMyVideoCardTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *lblType;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblTime;
@property (nonatomic, strong) UIImageView *imgCode;

- (void)setLeftImage: (NSString*)leftImage withRightImage: (NSString*)rightImage ;

@end

NS_ASSUME_NONNULL_END
