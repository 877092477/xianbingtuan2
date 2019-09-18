//
//  FNSearchView.h
//  THB
//
//  Created by Weller Zhao on 2018/12/26.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNSearchView;
@protocol FNSearchViewDelegate <NSObject>

- (void)searchView: (FNSearchView*)searchView didSearch: (NSString*) text;

@end

@interface FNSearchView : UIView

@property (nonatomic, strong, setter=setPlaceholder:) NSString *placeholder;
@property (nonatomic, strong, setter=setText:, getter=getText) NSString *text;

@property (nonatomic, weak) id<FNSearchViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
