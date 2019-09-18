//
//  FNPaymentSelectorAlert.h
//  THB
//
//  Created by Weller Zhao on 2019/1/10.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNPaymentSelectorAlert : UIView
typedef void (^OnItemSelected)(NSInteger index);

+ (void) show: (NSArray<NSString*>*) titles withImagesUrls: (NSArray<NSString*>*)imagesUrls onItemSelected: (OnItemSelected) block;

+ (void) dismiss;

@end

NS_ASSUME_NONNULL_END
