//
//  FNNewFreeProductDetailHeaderView.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNNewFreeProductDetailHeaderView : UIView

@property (nonatomic, strong) UILabel       *lblPrice;
@property (nonatomic, strong) UIView        *vMsg;
@property (nonatomic, strong) UILabel       *lblMsg;
@property (nonatomic, strong) UILabel       *lblTitle;
@property (nonatomic, strong) UILabel       *lblPeople;
@property (nonatomic, strong) UILabel       *lblCount;

- (void) setImages: (NSArray*) images;

@end

NS_ASSUME_NONNULL_END
