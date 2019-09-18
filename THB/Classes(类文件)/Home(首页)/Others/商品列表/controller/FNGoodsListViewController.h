//
//  FNGoodsListViewController.h
//  THB
//
//  Created by Fnuo-iOS on 2018/5/7.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
#import "FNAPIHome.h"
#import "FDSlideBar.h"
#import "HotSearchHeadColumnModel.h"
#import "firstVersionSearchViewController.h"
#import "ScreeningView.h"
#import "FNPopUpTool.h"
#import "GoodsListScreeningView.h"
#import "OnlyView.h"
#import "GoodsListTypeOneCell.h"
#import "GoodsListTypeTwoCell.h"

@interface FNGoodsListViewController : SuperViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)NSArray<HotSearchHeadColumnModel *>* ColumnArray;

@property (nonatomic, strong)NSMutableArray<FNBaseProductModel *>* list;

@property (nonatomic, strong)FDSlideBar *slideBar;

@property (nonatomic, copy) NSString *SkipUIIdentifier;

@property (nonatomic, copy) NSString *keyword;

@property (nonatomic, weak)UIView *mainView;

@property (nonatomic, strong)GoodsListScreeningView* elementview;

@property (nonatomic, strong)UITextField *SearchBar;

@property (nonatomic, strong)ScreeningView* screeningView;

@property (nonatomic, strong)OnlyView* Onlyview;

@property (nonatomic, strong)NSMutableArray* SortArr;

@end
