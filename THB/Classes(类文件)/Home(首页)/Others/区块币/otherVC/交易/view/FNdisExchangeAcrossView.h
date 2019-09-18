//
//  FNdisExchangeAcrossView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/7.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNdisExChangeStyleTwoCell.h"
#import "FNdistrictExchangeModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNdisExchangeAcrossViewDelegate <NSObject>
- (void)didExchangeAcrossAction; 
@end
@interface FNdisExchangeAcrossView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView* collectionview;

@property(nonatomic,strong)NSArray* dataArr;
 
@property(nonatomic,weak) id<FNdisExchangeAcrossViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
