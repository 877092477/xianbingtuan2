//
//  FNcateSortDeCell.h
//  THB
//
//  Created by Jimmy on 2018/12/17.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ScreeningView.h"

@protocol FNcateSortDeCellDelegate <NSObject>
// 点击排序
- (void)cateGoodsSortAction:(NSString*)sender;
//排版样式
- (void)cateGoodsComposingAction:(NSInteger)sender;
@end

@interface FNcateSortDeCell : UICollectionViewCell

//商品分栏视图
@property (nonatomic, strong)UIView* slideBarView;

//排序
@property (nonatomic, strong)ScreeningView* screeningView;

@property (nonatomic, strong)NSArray *sortArr;

@property (nonatomic ,weak) id<FNcateSortDeCellDelegate> delegate;

@property (nonatomic, strong)NSString *categoryId;

@property (nonatomic, strong)UIView *line2;
@property (nonatomic, strong)UIView *line;
@property (nonatomic, strong)UIView *Screeningline;
@property (nonatomic, strong)UIButton *switchBtn;

@property (nonatomic,assign) BOOL  singleType;

@end


