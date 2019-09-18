//
//  FNDouQuanView.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNDouQuanModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FNDouQuanViewDelegate <NSObject>

- (void)didProductClick;
- (void)didCollectionClick;
- (void)didShareClick;
- (void)didDownloadClick;
- (void)didSjzClick;
- (void)didFxzClick;

- (void)didDescClick;

@end

@interface FNDouQuanView : UIView

@property (nonatomic, weak) id<FNDouQuanViewDelegate> delegate;

- (void)setModel:(FNDouQuanModel *)model;
- (void)doLike ;

- (void)doUnlike ;

- (void) onCollectionAction;

@end

NS_ASSUME_NONNULL_END
