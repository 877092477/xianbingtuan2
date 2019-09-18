//
//  FNProductImageTool.h
//  新版嗨如意
//
//  Created by Weller on 2019/6/17.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNProductImageTool : UIView

typedef void(^ImageBlock)(NSArray<NSString*>* images);

- (void)loadUrl: (NSString*)url block: (ImageBlock) block;

@end

NS_ASSUME_NONNULL_END
