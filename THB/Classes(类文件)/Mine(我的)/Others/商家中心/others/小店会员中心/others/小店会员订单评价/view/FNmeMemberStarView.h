//
//  FNmeMemberStarView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmeMemberStarItemsCell.h"
#import "FNmeMemberEvaluatesModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNmeMemberStarViewDelegate <NSObject>
- (void)didMeMemberStarViewLevel:(NSInteger)level;
@end

@interface FNmeMemberStarView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView* collectionview;
@property(nonatomic,strong)NSMutableArray *imgArr;
@property(nonatomic,strong)NSString *starStr;
@property (nonatomic, weak)id<FNmeMemberStarViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
