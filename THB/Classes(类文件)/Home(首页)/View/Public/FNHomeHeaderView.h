//
//  FNHomeHeaderView.h
//  THB
//
//  Created by jimmy on 2017/5/4.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark -View
#import "XYQuickMenuView.h"
#import "SDCycleScrollView.h"
#import "FNHomeSpecialView.h"
#import "FDSlideBar.h"
#import "FNFunctionView.h"
#import "FNAdView.h"
#import "FNScrollmonkeyView.h"

#pragma mark -Model
#import "HotSearchHeadColumnModel.h"
#import "MenuModel.h"
#import "FNHomeModel.h"

@class MenuModel,FNHomeModel,HotSearchHeadColumnModel;
@interface FNHomeHeaderView : UIView

#pragma mark- Model
@property (nonatomic, strong)MenuModel* posterModel;
@property (nonatomic, strong)FNHomeModel* homeModel;

#pragma mark- View
/** 快速入口视图背景 **/
@property (nonatomic, strong)UIImageView* functionbgimgview;

/** 幻灯片 **/
@property (nonatomic, strong)SDCycleScrollView* bannerView;

/** 快速入口 **/
@property (nonatomic, strong)XYQuickMenuView* quickMenuView;
@property (nonatomic, strong)FNFunctionView* functionview;//圆形按钮模块


/** 广告位 **/
@property (nonatomic, strong)UIImageView* posterImgView;

@property (nonatomic, strong)FNAdView* adView;

/** 栅格（图文)视图 **/

@property (nonatomic, strong)FNHomeSpecialView* specialView;
/** 栅格视图背景 **/
@property (nonatomic, strong)UIImageView* specialbgimgview;

/** 跑马灯视图 **/
@property (nonatomic, strong)FNScrollmonkeyView* FNMarqueeView;;

/** 今日特价商品视图 **/
@property (nonatomic, strong)UIView* FNSpecialGoodsView;


/** 商品分栏视图 **/
@property (nonatomic, strong)UIView* slideBarView;

@property (nonatomic, strong)FDSlideBar *slideBar;//分栏内容



#pragma mark- Array
@property (nonatomic, strong)NSArray* bannerArray;
@property (nonatomic, strong)NSArray<MenuModel *>* quickArray;
@property (nonatomic, strong)NSArray<MenuModel *>* specialArray;
@property (nonatomic, strong)NSArray<HotSearchHeadColumnModel *>* ColumnArray;


#pragma mark- Block
@property (nonatomic, copy)void (^RefreshFrameBlock)(CGFloat Height);
@property (nonatomic, copy)void (^BannerClickedBlock)(NSInteger index);
@property (nonatomic, copy)void (^QuickClickedBlock)(MenuModel* model);
@property (nonatomic, copy)void (^PosterClickedBlock)(MenuModel* model);
@property (nonatomic, copy)void (^ColumnClickedBlock)(Index_goods_01Model* model);


@end
