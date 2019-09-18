//
//  FNclockInAriseView.h
//  THB
//
//  Created by Jimmy on 2019/2/27.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNclockInTeCell.h"
#import "FNclockInPayCell.h"
#import "FNclockInTeHeaderView.h"
#import "FNclockInPayHeaderView.h"
#import "FNclockInZoModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNclockInAriseViewDelegate <NSObject>
- (void)ariseClockInChoiceCount:(NSString*)countID withType:(NSString*)payType;

@end
@interface FNclockInAriseView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
/** bgView **/
@property (nonatomic, strong)UIView *bgView;
/** UICollectionView **/
@property (nonatomic, strong)UICollectionView *cardCollectionview;
@property (nonatomic, strong)UIButton *confirmBtn;
@property (nonatomic, strong)UIButton *cancelBtn;
-(void)showView;

@property (nonatomic,strong)FNclockInZoModel *dataModel;

@property(nonatomic,strong)NSMutableArray *typeArr;
@property(nonatomic,strong)NSMutableArray *payArr;

@property(nonatomic,strong)NSString *payTypeID;
@property(nonatomic,strong)NSString *countID;

/** delegate **/
@property (nonatomic, weak)id<FNclockInAriseViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
