//
//  FNmerPhotoDeletePuView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/1.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSHPopupContainer.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNmerPhotoDeletePuView : UIView<DSHCustomPopupView>

@property (nonatomic, strong)UILabel   *titleLB;
@property (nonatomic, strong)UILabel   *hintLB;
@property (nonatomic, strong)UIButton  *leftBtn;
@property (nonatomic, strong)UIButton  *rightBtn;

@end

NS_ASSUME_NONNULL_END
