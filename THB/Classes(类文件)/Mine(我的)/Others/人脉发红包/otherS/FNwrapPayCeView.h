//
//  FNwrapPayCeView.h
//  THB
//
//  Created by Jimmy on 2019/2/13.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNwrapPayItemAeCell.h"
#import "FNPayPasswordCeView.h"
#import "FNRedPackageNaModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNwrapPayCeViewDelegate <NSObject> 
- (void)inBackPasswordString:(NSString*)content payModel:(NSString*)payString;
@end
@interface FNwrapPayCeView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
+ (void)showPayCeView;
/** lineOne **/
@property (nonatomic, strong)UIView* lineOne;
/** lineTwo **/
@property (nonatomic, strong)UIView* lineTwo;
/** 头像图片 **/
@property (nonatomic, strong)UIImageView* headImg;
/** 标题 **/
@property (nonatomic, strong)UILabel* titleLB;
/** 标题2 **/
@property (nonatomic, strong)UILabel* sumLB;
/** whiteView **/
@property (nonatomic, strong)UIView* whiteView;
/** 支付方式 **/
@property (nonatomic, strong)UICollectionView* pay_collectionview;
/** 输入框 **/
@property (nonatomic, strong)FNPayPasswordCeView* payPasswordView;
/** delegate **/
@property (nonatomic, weak)id<FNwrapPayCeViewDelegate> delegate;
/** 支付方式 **/
@property (nonatomic, strong)NSMutableArray *dataArr;
/** 选择的支付方式 **/
@property (nonatomic, strong)NSString *payType;
-(void)dismissAlert;
@end

NS_ASSUME_NONNULL_END
