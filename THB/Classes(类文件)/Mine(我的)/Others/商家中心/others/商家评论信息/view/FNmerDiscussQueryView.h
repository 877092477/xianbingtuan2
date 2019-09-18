//
//  FNmerDiscussQueryView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/30.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FNmerchentReviewModel.h"
#import "FNmerDisQueryItemCell.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNmerDiscussQueryViewDelegate <NSObject>
// 提交疑问
- (void)didMerAffirmQueryIndex:(NSIndexPath*)index withType:(NSString*)type withContent:(NSString*)content;

@end
@interface FNmerDiscussQueryView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate>


@property(nonatomic,strong)UIView *bgBaseView;
@property(nonatomic,strong)UICollectionView* collectionview;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)UIButton *affirmBtn;
@property(nonatomic,strong)UITextView   *compileView;
@property(nonatomic,strong)UILabel  *hintLb;
@property(nonatomic,strong)UILabel  *titleLB;
@property(nonatomic,strong)NSMutableArray  *typeArr;
@property(nonatomic,strong)NSIndexPath  *backIndex;
@property(nonatomic,strong)FNmerReviewQueryModel *model;
@property(nonatomic,strong)NSString *jointType;

@property(nonatomic,weak)id<FNmerDiscussQueryViewDelegate> delegate;

-(void)showView;
-(void)dismissView;
@end

NS_ASSUME_NONNULL_END
