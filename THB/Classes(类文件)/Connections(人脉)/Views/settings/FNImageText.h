//
//  FNImageText.h
//  THB
//
//  Created by Weller Zhao on 2019/3/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNImageText;
@protocol FNImageTextDelegate <NSObject>

- (void)didIconClick: (FNImageText*)icon;

@end


@interface FNImageText : UIView

@property (nonatomic, strong) UIImageView *imgIcon;
@property (nonatomic, strong) UILabel *lblTitle;

@property (nonatomic, weak) id<FNImageTextDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
