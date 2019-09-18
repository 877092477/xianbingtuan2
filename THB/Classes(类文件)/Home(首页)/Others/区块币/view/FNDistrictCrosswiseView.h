//
//  FNDistrictCrosswiseView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/30.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNDistrictDealitemCell.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNDistrictCrosswiseViewDelegate <NSObject>
// 点击 类型
- (void)didDistrictCrosswiseItemAction:(NSString*)type;
@end
@interface FNDistrictCrosswiseView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView* collectionview; 
@property(nonatomic,strong)NSArray* dataArr;
@property (nonatomic ,weak) id<FNDistrictCrosswiseViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
