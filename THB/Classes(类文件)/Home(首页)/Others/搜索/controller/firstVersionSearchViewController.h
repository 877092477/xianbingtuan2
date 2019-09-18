//
//  firstVersionSearchViewController.h
//  THB
//
//  Created by Fnuo-iOS on 2018/5/5.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
#import "FNAPIHome.h"
#import "FDSlideBar.h"
#import "HotSearchHeadColumnModel.h"
#import "JMAlertView.h"
#import "FNSectionHeaderView.h"
#import "FNMaximumSpacingFlowLayout.h"

@interface firstVersionSearchViewController : SuperViewController<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong)FDSlideBar *slideBar;

@property (nonatomic, strong)NSArray<HotSearchHeadColumnModel *>* ColumnArray;

@property (nonatomic, copy) NSString *SkipUIIdentifier;

//历史纪录
@property (strong,nonatomic)NSMutableArray *hisorydataArr;

@property (nonatomic, strong)UITextField *SearchBar;

@property (nonatomic, strong)FNSectionHeaderView* sectioHeader;

@property (nonatomic, strong)UIImageView *dibuImageView;

@end
