//
//  FNmeStoreImgTextView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import "FNmerchantIconItemCell.h"
#import "FNMerchantMeModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNmeStoreImgTextViewDelegate <NSObject>
// 点击
- (void)inMeStoreImgTextAction:(id)model;

@end
@interface FNmeStoreImgTextView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView* collectionview;

@property(nonatomic,strong)NSArray* dataArr;

@property(nonatomic,strong)NSMutableArray* modelArr;

@property(nonatomic,weak)id<FNmeStoreImgTextViewDelegate> delegate;

@property(nonatomic,strong)FNMerchantMeModel  *model;
@end

NS_ASSUME_NONNULL_END
