//
//  FNLocationSelectorViewController.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/21.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNLocationSelectorViewController;
@protocol FNLocationSelectorViewControllerDelegate <NSObject>

- (void)locationController: (FNLocationSelectorViewController*)vc didSelectPoi: (AMapPOI*) poi;

@end

@interface FNLocationSelectorViewController : UIViewController

@property (nonatomic, weak) id<FNLocationSelectorViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
