//
//  FNMineIcon.h
//  THB
//
//  Created by Weller Zhao on 2018/12/25.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNMineIcon;
@protocol FNMineIconDelegate <NSObject>

- (void)didIconClick: (FNMineIcon*)icon;

@end

@interface FNMineIcon : UITableViewCell

@property (nonatomic, strong) UIImageView *imgIcon;
@property (nonatomic, strong) UILabel *lblTitle;

@property (nonatomic, weak) id<FNMineIconDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
