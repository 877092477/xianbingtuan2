//
//  FNshareMakeDeView.h
//  THB
//
//  Created by Jimmy on 2018/12/19.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "COFshareBtn.h"
@protocol FNshareMakeDeViewDelegate <NSObject>
// 分享
-(void)shareBtnClick:(NSInteger)sender;

@end
@interface FNshareMakeDeView : UIView
@property (nonatomic, assign) BOOL showShade; ///< 是否显示阴影, 如果为YES则弹窗背景为半透明的阴影层, 否则为透明, 默认为NO.

@property (nonatomic, assign) CGFloat itemWidth;//按钮宽度
@property (nonatomic, assign) CGFloat currentH;//内容view高度

@property (nonatomic, assign) NSArray *imageListArr;//分享按钮图片
@property (nonatomic, assign) NSArray *nameListArr;//分享文字

+ (instancetype)popoverView;

- (void)showWithActions; 
@property(nonatomic ,weak) id<FNshareMakeDeViewDelegate> delegate;
@end


