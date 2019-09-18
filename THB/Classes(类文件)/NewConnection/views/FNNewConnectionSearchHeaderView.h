//
//  FNNewConnectionSearchHeaderView.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/6/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNNewConnectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNNewConnectionSearchSortButton : UIView

@property (nonatomic, strong) UIView *vSort;
@property (nonatomic, strong) UILabel *lblSort;
@property (nonatomic, strong) UIImageView *imgSort;
@property (nonatomic, assign, setter=setIsHasSub:) BOOL isHasSub;//是否有二级菜单
@property (nonatomic, assign, setter=setState:) int state; // 0-普通，1-升序，2-降序
@property (nonatomic, strong) UIView *vLine;

@end

@class FNNewConnectionSearchHeaderView;
@protocol FNNewConnectionSearchHeaderViewDelegate <NSObject>

- (void)searchView: (FNNewConnectionSearchHeaderView*)view didCateClick: (NSInteger)index button: (FNNewConnectionSearchSortButton*)button;
- (void)searchView: (FNNewConnectionSearchHeaderView*)view didSearchClick: (NSString*) keyword;

@end

@interface FNNewConnectionSearchHeaderView : UITableViewHeaderFooterView

@property (nonatomic, weak) id<FNNewConnectionSearchHeaderViewDelegate> delegate;

@property (nonatomic, strong) UITextField *txfSearch;
@property (nonatomic, strong) UIButton *btnSearch;
@property (nonatomic, strong) UILabel *lblTips;

- (void)configCate: (NSArray<FNNewConnectionCateSortModel*>*) cates;

- (void)resetStatus;

@end

NS_ASSUME_NONNULL_END
