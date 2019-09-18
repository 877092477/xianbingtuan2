//
//  FNTBWebViewController.h
//  新版嗨如意
//
//  Created by Weller on 2019/5/31.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNTBWebViewController : SuperViewController

@property (nonatomic, copy) NSString *url;

- (void)openTB;

@end

NS_ASSUME_NONNULL_END
