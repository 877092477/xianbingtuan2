//
//  FNmeMeEvaluMsgView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/21.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerDiscussDetailsUserCell.h"
#import "FNmerDiscussDeTallyCell.h"
#import "FNmerDiscussEvaluateTextCell.h"
#import "FNmerDiscussImgItemCell.h"
#import "FNmerDiscussHandleCell.h"
#import "FNmerDiscussRespondItCell.h"
#import "FNmeMemberMorebaCell.h"
#import "FNmeMemberRespondCell.h"
#import "FNmerchentReviewModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNmeMeEvaluMsgViewDelegate <NSObject>
//查看图片
- (void)didmeMeEvaluMsgViewTheImage:(NSIndexPath*)indexs withSite:(NSInteger)siteInt;
//进入
- (void)didmeMeEvaluMsgEnterIntoAction:(NSIndexPath*)indexs;
//点赞
- (void)didmeMeEvaluMsgGiveaLikeAction:(NSIndexPath*)indexs;
//更多
- (void)didmeMeEvaluMsgMoreAction:(NSIndexPath*)indexs;

@end
@interface FNmeMeEvaluMsgView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView* collectionview;
@property (nonatomic, strong)FNmerchentReviewModel *model;
@property (nonatomic, strong)NSMutableArray *titleArr;
@property (nonatomic, strong)NSIndexPath    *index;
@property (nonatomic, weak)id<FNmeMeEvaluMsgViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
