//
//  FNtendOrientationNeController.h
//  69橙子
//
//  Created by 李显 on 2018/12/9.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
#import "FNCityDeNeModel.h"
@protocol FNtendOrientationNeControllerDelegate <NSObject>

- (void)didClickedWithCityName:(NSString*)cityName;

- (void)didCityWithLongitude:(NSString*)longitude withLatitude:(NSString*)latitude;

- (void)didCityWithLongitude:(NSString*)longitude withLatitude:(NSString*)latitude withModel:(FNCityDeNeModel*)model;

@end

@interface FNtendOrientationNeController : SuperViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) id<FNtendOrientationNeControllerDelegate>delegate; 

@property (strong, nonatomic) NSMutableArray *arrayLocatingCity;//定位城市数据
@property (strong, nonatomic) NSMutableArray *arrayHotCity;//热门城市数据
@property (strong, nonatomic) NSMutableArray *arrayHistoricalCity;//常用城市数据
@property (strong, nonatomic) FNCityDeNeModel*model;
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, assign) NSInteger topStyle;//1:标示 商家中心设置未编辑时搜索栏在Nav下面 0标示小店首页原来的样式
@end


