//
//  FNdistrictCoinStateView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/6.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSHPopupContainer.h" 
NS_ASSUME_NONNULL_BEGIN

@interface FNdistrictCoinStateView : UIView<DSHCustomPopupView>
@property(nonatomic,strong)UIImageView *stateImg;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)UILabel *stateLB;
@end

NS_ASSUME_NONNULL_END
