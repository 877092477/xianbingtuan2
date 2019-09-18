//
//  FNmeMeEvaluatesEditCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmeMemberEvaluatesModel.h"
#import "FNmerchentReviewModel.h"
//选择照片
#import "HXPhotoViewController.h"
//选择照片后布局界面
#import "HXPhotoView.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNmeMeEvaluatesEditCellDelegate <NSObject> 

- (void)didmeMeEvaluatesEdit:(NSString*)content;

- (void)didmeMeEvaluatesAction:(NSArray*)photoArr;

@end
@interface FNmeMeEvaluatesEditCell : UICollectionViewCell<UITextViewDelegate,HXPhotoViewDelegate>
@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, strong)UIView *grayView;
@property (nonatomic, strong)UILabel *titleLB;
@property (nonatomic, strong)UITextView   *evaluateView;
@property (nonatomic, strong)UILabel      *evaluateHint;
@property (nonatomic, strong)UIButton     *submitBtn;
@property (nonatomic, strong)FNmeMemberEvaluatesModel *model;
@property (nonatomic, strong)FNmerchentReviewModel *alterModel;
//图片
@property (nonatomic, strong)HXPhotoManager *manager;
//图片view
@property (nonatomic, strong)HXPhotoView *photoView;

@property (nonatomic, weak)id<FNmeMeEvaluatesEditCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
