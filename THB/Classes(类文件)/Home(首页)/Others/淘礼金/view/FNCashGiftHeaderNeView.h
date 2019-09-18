//
//  FNCashGiftHeaderNeView.h
//  THB
//
//  Created by 李显 on 2018/10/15.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QJSlideButtonView.h"
#import "JMTitleScrollView.h"
#import "ScreeningView.h"
#import "FDSlideBar.h"


@protocol FNCashGiftHeaderNeViewDelegate <NSObject>
/** 点击分类 **/
- (void)CashGiftCarouselClassifyAction:(NSInteger)sender withIndexPath:(NSIndexPath*)indexPath;
/** 点击排序 **/
- (void)CashGiftCarouselSortAction:(NSString *)type withSite:(NSUInteger)site;
/** 更换样式 **/
- (void)CashGiftCarouselChangeAction:(NSInteger)sender;
@end
@interface FNCashGiftHeaderNeView : UICollectionReusableView<JMTitleScrollViewDelegate>

@property (nonatomic,strong) JMTitleScrollView *titleView;
@property (nonatomic,strong) ScreeningView *screeningView;
@property (nonatomic,strong) FDSlideBar *topSlideBar; 

@property (nonatomic,strong) UIView *line;

@property (nonatomic,strong) UIView *Screeningline;

@property (nonatomic,strong) UIView *line2;

@property (nonatomic,strong) UIButton *switchBtn;
/** 分类arr **/
@property (nonatomic,strong) NSArray *classifyArr;
/** 排序arr **/
@property (nonatomic,strong) NSArray *sortArr;
/** delegate **/
@property(nonatomic ,weak) id<FNCashGiftHeaderNeViewDelegate> delegate;
/** 分类int **/
@property (nonatomic,assign) NSInteger seletedInt;
/** 排序int **/
@property (nonatomic,assign) NSInteger sortInt;
/** 样式int **/
@property (nonatomic,assign) NSInteger switchInt;
/** indexPath **/
@property (nonatomic, strong) NSIndexPath* indexPath;
 
@end
