//
//  COFshareView.h
//  THB
//
//  Created by Jimmy on 2018/8/30.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol COFshareViewDelegate <NSObject>

// 分享
-(void)COFshareBtnClick:(NSInteger )sender;


@end

@interface COFshareView : UIView
@property (nonatomic, assign) BOOL hideAfterTouchOutside; ///< 是否开启点击外部隐藏弹窗, 默认为YES.
@property (nonatomic, assign) BOOL showShade; ///< 是否显示阴影, 如果为YES则弹窗背景为半透明的阴影层, 否则为透明, 默认为NO.
//@property (nonatomic, assign) PopoverViewStyle style; ///< 弹出窗风格, 默认为 PopoverViewStyleDefault(白色).

+ (instancetype)popoverView;

/*!
 指向指定的View来显示弹窗 
 */
- (void)showWithActions;
@property(nonatomic ,weak) id<COFshareViewDelegate> delegate;
@end
