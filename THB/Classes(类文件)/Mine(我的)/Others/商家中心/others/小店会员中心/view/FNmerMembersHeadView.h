//
//  FNmerMembersHeadView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/16.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerMembersModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNmerMembersHeadViewDelegate <NSObject>

- (void)didMerHeaderLucencySeletedClickIndex:(NSIndexPath*)index;

@end
@interface FNmerMembersHeadView : UICollectionReusableView
@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)UILabel *titleLB;
@property (nonatomic, strong)UILabel *rightTextLB;
@property (nonatomic, strong)UIImageView *rightImg;
@property (nonatomic, strong)UIButton *lucencyBtn;
@property (nonatomic, strong)NSIndexPath *index;
@property (nonatomic, strong)FNmerMembersModel *model;
@property (nonatomic, weak)id<FNmerMembersHeadViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
