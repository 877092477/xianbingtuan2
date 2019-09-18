//
//  FNIndexSelectorView.h
//  THB
//
//  Created by Weller Zhao on 2019/1/14.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNIndexSelectorView;
@protocol FNIndexSelectorViewDelegate <NSObject>

- (void)selectorView: (FNIndexSelectorView*)selector didSelectedAt: (NSInteger)index;
- (void)selectorViewDidCancle: (FNIndexSelectorView*)selector;

@end

@interface FNIndexSelectorView : UIView

@property (nonatomic, weak) id<FNIndexSelectorViewDelegate> delegate;

-(void)setTitles: (NSArray<NSString*>*)titles;

@end

NS_ASSUME_NONNULL_END
