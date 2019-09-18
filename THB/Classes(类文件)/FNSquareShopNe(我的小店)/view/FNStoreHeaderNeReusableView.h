//
//  FNStoreHeaderNeReusableView.h
//  69橙子
//
//  Created by Jimmy on 2018/11/22.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNStoreHeaderNeReusableView;
@protocol FNStoreHeaderNeReusableViewDelegate <NSObject>

- (void)view: (FNStoreHeaderNeReusableView*)view didLayoutSelected: (BOOL)isSelected; 

@end

@interface FNStoreHeaderNeReusableView : UICollectionReusableView

@property (nonatomic, weak) id<FNStoreHeaderNeReusableViewDelegate> delegate;

/** 名字 **/
@property (nonatomic, strong)UILabel* TypeLB;
/** 左 **/
//@property (nonatomic, strong)UILabel* leftLB;
///** 右 **/
//@property (nonatomic, strong)UILabel* rightLB;
/** topline **/
@property (nonatomic, strong)UILabel* topLineLB;
/** baseline **/
@property (nonatomic, strong)UILabel* baseLineLB;
@end

NS_ASSUME_NONNULL_END
