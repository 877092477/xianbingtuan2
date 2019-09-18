//
//  FNConnectionsSearchView.h
//  THB
//
//  Created by Weller Zhao on 2019/2/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNConnectionsSearchView;
@protocol FNConnectionsSearchViewDelegate <NSObject>

- (void) searchView: (FNConnectionsSearchView*)searchView didSearch: (NSString*)keyword;
- (void) searchView: (FNConnectionsSearchView*)searchView didItemSelectedAt: (NSInteger)index;

@end

@interface FNConnectionsSearchView : UIView

@property (nonatomic, weak) id<FNConnectionsSearchViewDelegate> delegate;

- (void) setIcons: (NSArray<NSString*>*)iconUrls;

@end

NS_ASSUME_NONNULL_END
