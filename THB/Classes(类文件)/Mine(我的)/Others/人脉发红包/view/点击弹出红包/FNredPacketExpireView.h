//
//  FNredPacketExpireView.h
//  THB
//
//  Created by Jimmy on 2019/2/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNredPacketExpireView : UIView
/** whiteView **/
@property (nonatomic, strong)UIView* whiteView;
/** 头像图片 **/
@property (nonatomic, strong)UIImageView* headImg;
/** 标题 **/
@property (nonatomic, strong)UILabel* titleLB;
/** 备注1 **/
@property (nonatomic, strong)UILabel* remarkLB;
/** 看看大家 **/
@property (nonatomic, strong)UIButton* checkBtn;
/** name **/
@property (nonatomic, strong)NSString* nameString;
/** bgView **/
@property (nonatomic, strong)UIView *bgView;

- (void)dismissAlert;

@end

NS_ASSUME_NONNULL_END
