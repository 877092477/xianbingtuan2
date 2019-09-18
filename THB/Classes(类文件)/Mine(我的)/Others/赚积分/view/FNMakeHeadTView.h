//
//  FNMakeHeadTView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmakeHeadListView.h"
#import "FNMakeTmodel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNMakeHeadTView : UICollectionReusableView
@property (nonatomic, strong)UILabel  *titleLB;
@property (nonatomic, strong)UIButton *centreBtn;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)UIView *leftline;
@property (nonatomic, strong)UIView *rightline;
@property (nonatomic, strong)FNmakeHeadListView *listView;
@property (nonatomic, strong)FNMakeTmodel *model;
@end

NS_ASSUME_NONNULL_END
