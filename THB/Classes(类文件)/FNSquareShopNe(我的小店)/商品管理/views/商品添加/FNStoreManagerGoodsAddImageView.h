//
//  FNStoreManagerGoodsAddImageView.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/12.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNStoreManagerGoodsAddImageView;
@protocol FNStoreManagerGoodsAddImageViewDelegate <NSObject>

- (void)didAddImageClick: (FNStoreManagerGoodsAddImageView*)view;
- (void)didCloseImageClick: (FNStoreManagerGoodsAddImageView*)view;

@end

@interface FNStoreManagerGoodsAddImageView : UIView

@property (nonatomic, weak) id<FNStoreManagerGoodsAddImageViewDelegate> delegate;

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIButton *btnImage;
@property (nonatomic, strong) UIButton *btnClose;

@end

NS_ASSUME_NONNULL_END
