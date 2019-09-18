//
//  FNCreaditCardMyShareCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/6/21.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNCreaditCardMyShareCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgBackground;
@property (nonatomic, strong) UIImageView *imgHeader;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblName;
@property (nonatomic, strong) UIView *vTag;
@property (nonatomic, strong) UILabel *lblCommission;
@property (nonatomic, strong) UILabel *lblTime;

@property (nonatomic, strong) UIImageView *imgStatus;

- (void)setState: (NSString*)stateUrl ;
- (void) setTags: (NSArray<NSString*> *)tags withColor: (UIColor*)color andBg: (NSString*)bg;

@end

NS_ASSUME_NONNULL_END
