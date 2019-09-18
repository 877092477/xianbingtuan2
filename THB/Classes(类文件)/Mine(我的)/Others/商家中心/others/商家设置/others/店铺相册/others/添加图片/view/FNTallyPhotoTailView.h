//
//  FNTallyPhotoTailView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/2.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
//选择照片
#import "HXPhotoViewController.h"
//选择照片后布局界面
#import "HXPhotoView.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNTallyPhotoTailViewDelegate <NSObject>
// 添加的图片
- (void)didMerTallyPhotoImages:(NSArray*)imgArr;
@end
@interface FNTallyPhotoTailView : UICollectionReusableView<HXPhotoViewDelegate>
@property (nonatomic, strong)UILabel      *hintLb;
@property (nonatomic, strong)UIView       *bgView;

//图片
@property (nonatomic, strong)HXPhotoManager *manager;
//图片view
@property (nonatomic, strong)HXPhotoView *photoView;
@property (nonatomic, weak)id<FNTallyPhotoTailViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
