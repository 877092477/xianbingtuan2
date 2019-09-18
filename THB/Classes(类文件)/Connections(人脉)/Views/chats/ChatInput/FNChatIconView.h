//
//  FNChatIconView.h
//  THB
//
//  Created by Weller Zhao on 2019/1/23.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNChatIconView;
@protocol FNChatIconViewDelegate <NSObject>

- (void)iconView: (FNChatIconView*)iconView didSelectAt: (NSInteger) index;

@end

@interface FNChatIconView : UIView

@property (nonatomic, weak) id<FNChatIconViewDelegate> delegate;

- (void)setIcons: (NSArray<NSString*>*) imageURLs withTitles: (NSArray<NSString*>*)titles andTextColors: (NSArray<UIColor*>*)colors;

@end

NS_ASSUME_NONNULL_END
