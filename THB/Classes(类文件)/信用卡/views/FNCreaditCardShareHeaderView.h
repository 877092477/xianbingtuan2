//
//  FNCreaditCardShareHeaderView.h
//  新版嗨如意
//
//  Created by Weller on 2019/6/21.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNCreaditCardShareHeaderView : UIView

@property (nonatomic, strong) UIView* bannerView;
@property (nonatomic, strong) UIImageView* imgHeader;

@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIView *vTag;
@property (nonatomic, strong) UILabel *lblCount;
@property (nonatomic, strong) UIButton *btnBuy;
@property (nonatomic, strong) UILabel *lblBuy;
@property (nonatomic, strong) UIButton *btnShare;
@property (nonatomic, strong) UILabel *lblShare;
@property (nonatomic, strong) UILabel *lblRule;

@end

NS_ASSUME_NONNULL_END
