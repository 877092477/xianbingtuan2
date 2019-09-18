//
//  FNgoodsLibScreenUeView.h
//  THB
//
//  Created by 李显 on 2019/1/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNlibScreenItemUeCell.h"
#import "FNSomeTeItemModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNgoodsLibScreenUeViewDegate <NSObject>
//选择类型
-(void)ingoodsLibChildTypeAction:(FNSomeGoodsCateModel*)model;
@end

@interface FNgoodsLibScreenUeView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic ,strong) UIView    *bgTopView;

@property(nonatomic ,strong) UIView    *bgView;

@property(nonatomic ,strong) UIView    *bgTwoView;

@property(nonatomic ,strong) UICollectionView   *conditionView;

@property(nonatomic ,strong) NSArray *dataArr;

@property(nonatomic ,weak) id<FNgoodsLibScreenUeViewDegate> delegate;

-(void)showView;

-(void)hideView;
@end

NS_ASSUME_NONNULL_END
