//
//  FNconSeekGoodsSternView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerConsumeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNconSeekGoodsSternView : UICollectionReusableView
@property (nonatomic, strong)UIView    *bgView;
@property (nonatomic, strong)UIView    *lineView;
@property (nonatomic, strong)UIButton    *matterBtn;
@property (nonatomic, strong)FNmerConsumeModel   *model;
@end

NS_ASSUME_NONNULL_END
