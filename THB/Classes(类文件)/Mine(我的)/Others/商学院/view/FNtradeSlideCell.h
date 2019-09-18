//
//  FNtradeSlideCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h> 

#import "TYCyclePagerView.h"
#import "TYPageControl.h"
#import "FNtradeMenusImgsCell.h"
#import "FNtradeHomeModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol FNtradeSlideCellDelegate <NSObject>
// 点击
- (void)inTradeSlideClick:(NSInteger)index;
//编辑
- (void)inTradeSlideCompileAction:(NSString*)content;

@end
@interface FNtradeSlideCell : UICollectionViewCell<UISearchBarDelegate,TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>
@property (nonatomic, strong)UISearchBar* searchBar;
/** 幻灯片 **/
@property (nonatomic, strong)TYCyclePagerView* pagerView; 
@property (nonatomic, strong)TYPageControl *pageControl;
 
@property (nonatomic, copy)void (^tradeSlidedBlock)(NSInteger index);

@property(nonatomic,strong)FNtradeHomeModel *model;

@property(nonatomic,weak)id<FNtradeSlideCellDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
