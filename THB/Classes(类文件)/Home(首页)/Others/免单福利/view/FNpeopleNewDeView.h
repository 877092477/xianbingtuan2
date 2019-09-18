//
//  FNpeopleNewDeView.h
//  THB
//
//  Created by Jimmy on 2018/12/18.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FNpeopleGoodsItemNeCell.h"
@protocol FNpeopleNewDeViewDegate <NSObject>

// 点击
- (void)inSeletedGoodsItemClick:(NSDictionary*)dicTry;

@end
@interface FNpeopleNewDeView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,FNpeopleGoodsItemNeCellDegate>

@property(nonatomic,strong)UICollectionView* goodscollectionview;

@property(nonatomic,strong)NSArray* dataArr;

@property(nonatomic ,weak) id<FNpeopleNewDeViewDegate> delegate;

@end


