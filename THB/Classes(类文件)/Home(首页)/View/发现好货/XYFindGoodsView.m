//
//  XYFindGoodsView.m
//  THB
//
//  Created by zhongxueyu on 16/4/25.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有 2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "XYFindGoodsView.h"
#import "XYFindFirstView.h"
#import "XYFindSecondView.h"
#import "XYTitleModel.h"
#import "HomeViewController.h"
@interface XYFindGoodsView ()<HomeViewControllerRefreshDelegate>

/** 存放分类数据的数组 */
@property (retain, nonatomic) NSMutableArray *categoryDataArray;

/** 存放分类的数组 */
@property (retain, nonatomic) NSMutableArray *categoryNameArray;
@end
@implementation XYFindGoodsView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        HomeViewController *vc = [[HomeViewController alloc]init];
        vc.delegate = self;
        _categoryDataArray = [NSMutableArray array];
        _categoryNameArray = [NSMutableArray array];
        [self loadCategoryNameMethod];
    }
    return self;
}

-(void)Refresh:(NSInteger)index{
    [self loadCategoryNameMethod];
}
//获取数据
-(void)loadCategoryNameMethod
{
    NSMutableArray *idArray = [NSMutableArray array];
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"type":@5,
                                                                                 @"time":[NSString GetNowTimes]}];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
//    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_home_getCates successBlock:^(id responseBody) {
        NSDictionary *dict = responseBody;
//        NSString *msg = [NSString stringWithFormat:@"%@",[dict objectForKey:XYMessage]];
        XYLog(@"responseBody is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            NSArray *tempArray = [dict objectForKey:XYData];
            [_categoryNameArray removeAllObjects];
            [_categoryDataArray removeAllObjects];
            
            if (tempArray) {
                for (int i = 0; i < tempArray.count; i ++) {
                    XYTitleModel *model = [XYTitleModel mj_objectWithKeyValues:tempArray[i]];
                    [_categoryDataArray addObject:model];
                    [_categoryNameArray addObject:model.category_name];
                    [idArray addObject:model.id];
                }
            }
            if (_categoryNameArray.count>0) {
                [SVProgressHUD dismiss];
                [self addContentView:_categoryDataArray];
                
            }else{
                [SVProgressHUD dismiss];
                [FNTipsView showTips:XYMsg];
            }
            
        }
        else{
            //            [FNTipsView showTips:msg];
        }
        
        
        
    } failureBlock:^(NSString *error) {
        [SVProgressHUD dismiss];
        [XYNetworkAPI cancelAllRequest];
    }];
    
    
}
- (void)addContentView:(NSMutableArray *)dataArray{
    
    
    for (int i = 0 ; i<2; i++) {
        XYTitleModel *model = dataArray[i];
        XYFindFirstView *view = [[XYFindFirstView alloc]initWithFrame:CGRectMake(i*(XYScreenWidth/2), 0, XYScreenWidth/2, 150) title:model.category_name detailTitle:model.title image1Str:model.img1 image2Str:model.img2];
        view.tag = i;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnTapBtnView:)];
        [view addGestureRecognizer:tap];
        [self addSubview:view];
    }
    
    for (int i = 0 ; i<dataArray.count-2; i++) {
        XYTitleModel *model = dataArray[i+2];
        CGFloat ViewX;
        CGFloat ViewY;
        ViewX = i%4*(XYScreenWidth/4);
        ViewY = 150+120*(i/4);
        XYFindSecondView *Sview = [[XYFindSecondView alloc]initWithFrame:CGRectMake(ViewX, ViewY, XYScreenWidth/4, 120) title:model.category_name detailTitle:model.title imageStr:model.img1];
        Sview.tag = i+2;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnTapBtnView:)];
        [Sview addGestureRecognizer:tap];
        [self addSubview:Sview];
    
    }
}
-(void)OnTapBtnView:(UITapGestureRecognizer *)sender
{
    
    NSInteger tag = sender.view.tag+1;
    //    MenuModel *model =tapArray[tag];
    //    NSString *url =model.url;
    [self.delegate OnTapGoodsView:tag];
}
@end
