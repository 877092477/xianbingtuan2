//
//  FNCreaditCardCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/6/20.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNCreaditCardCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgCard;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblCount;

@property (nonatomic, strong) UILabel *lblBuy;
@property (nonatomic, strong) UILabel *lblShare;

@property (nonatomic, strong) UIButton *btnBuy;
@property (nonatomic, strong) UIButton *btnShare;

- (void) setTags: (NSArray<NSString*> *)tags withColor: (UIColor*)color andBg: (NSString*)bg;

@end

NS_ASSUME_NONNULL_END
