//
//  FNRecommendFineItemXCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewJavascriptBridge.h"
//NS_ASSUME_NONNULL_BEGIN

@interface FNRecommendFineItemXCell : UICollectionViewCell<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,copy) NSString *url;

@property (nonatomic, strong) WVJBHandler jsHandler;

@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@property (nonatomic, assign) CGFloat height;
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;
@end

//NS_ASSUME_NONNULL_END
