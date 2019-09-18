//
//  FNConnectionsHomeHeaderView.h
//  THB
//
//  Created by Weller Zhao on 2019/1/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNConnectionsHomeHeaderButtonView: UIView

@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UIImageView *imgIcon;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblBadge;

@end

@class FNConnectionsHomeHeaderView;
@protocol FNConnectionsHomeHeaderViewDelegate <NSObject>

- (void)headerView: (FNConnectionsHomeHeaderView*) headerView didSelectedAt: (NSInteger)index;

@end

@interface FNConnectionsHomeHeaderView : UIView

@property (nonatomic, weak) id<FNConnectionsHomeHeaderViewDelegate> delegate;

- (void) setBackgroundImageUrl: (NSString*)url;

- (void) setTitles: (NSArray<NSString*>*) titles withColors: (NSArray<UIColor*>*)colors imageUrls: (NSArray<NSString*>*) imageUrls badges: (NSArray<NSNumber*>*) badges;

@end

NS_ASSUME_NONNULL_END
