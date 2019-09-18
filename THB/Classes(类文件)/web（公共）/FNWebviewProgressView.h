//
//  FNWebviewProgressView.h
//  新版嗨如意
//
//  Created by Weller on 2019/5/22.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNWebviewProgressView : UIView

//进度条颜色
@property (nonatomic,strong) UIColor  *lineColor;

//开始加载
-(void)startLoadingAnimation;

//结束加载
-(void)endLoadingAnimation;

@end

NS_ASSUME_NONNULL_END
