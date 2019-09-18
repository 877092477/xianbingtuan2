//
//  FNtradeMenusCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/22.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNtradeMenusCell.h"

@implementation FNtradeMenusCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews{
    //动画样式
    self.listView = [[FMHorizontalMenuView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, 92)];
    self.listView.tag = 1000;
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.currentPageDotColor = RGB(240, 99, 101);
    self.listView.pageDotColor = RGB(240, 99, 101);//[UIColor whiteColor];
    //self.listView.pageDotImage=IMAGE(@"FN_SXYmenItemsbannerX");
    //self.listView.currentPageDotImage=IMAGE(@"FN_SXYmenItemsbannerD");
    //self.listView.pageControlDotSize=CGSizeMake(16, 6);
    self.listView.controlSpacing=6;
    //self.listView.backgroundColor = [UIColor orangeColor];
    self.listView.hidesForSinglePage = YES;
    [self addSubview:self.listView];
    
    self.listView.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    
}

#pragma mark === FMHorizontalMenuViewDataSource
- (Class)customCollectionViewCellClassForHorizontalMenuView:(FMHorizontalMenuView *)view{
    return [FNtradeMenusImgsCell class];
}

-(void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index horizontalMenuView:(FMHorizontalMenuView *)view{
    
    NSArray *arrList=self.model.cate;
    if(arrList.count>0){
        FNtradeHomeCateItemModel *titemModel=[FNtradeHomeCateItemModel mj_objectWithKeyValues:arrList[index]];
        FNtradeMenusImgsCell *myCell = (FNtradeMenusImgsCell*)cell;
        myCell.typeInt=2;
//        myCell.allImgView.backgroundColor=RGB(250, 250, 250);
        [myCell.allImgView setUrlImg:titemModel.img];
        myCell.allImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
}
/**
 提供数据的数量
 
 @param horizontalMenuView 控件本身
 @return 返回数量
 */
-(NSInteger)numberOfItemsInHorizontalMenuView:(FMHorizontalMenuView *)horizontalMenuView{
    NSArray *arrList=self.model.cate;
    return arrList.count;
}

#pragma mark === FMHorizontalMenuViewDelegate
/**
 设置每页的行数 默认 2
 
 @param horizontalMenuView 当前控件
 @return 行数
 */
-(NSInteger)numOfRowsPerPageInHorizontalMenuView:(FMHorizontalMenuView *)horizontalMenuView{
    NSArray *arrList=self.model.cate;
    if(arrList.count>3){
       return 2;
    }else{
       return 1;
    } 
}

/**
 设置每页的列数 默认 4
 
 @param horizontalMenuView 当前控件
 @return 列数
 */
-(NSInteger)numOfColumnsPerPageInHorizontalMenuView:(FMHorizontalMenuView *)horizontalMenuView{
    return 3;
}
/**
 当选项被点击回调
 
 @param horizontalMenuView 当前控件
 @param index 点击下标
 */
-(void)horizontalMenuView:(FMHorizontalMenuView *)horizontalMenuView didSelectItemAtIndex:(NSInteger)index{
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"您点击了第%ld个",index + 1] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alert show];
    
    if ([self.delegate respondsToSelector:@selector(inTradeMenusSeletedAction:)]) {
        [self.delegate inTradeMenusSeletedAction:index];
    }
}

-(CGSize)iconSizeForHorizontalMenuView:(FMHorizontalMenuView *)horizontalMenuView{
    CGFloat itemWidh=FNDeviceWidth/3;
    return CGSizeMake(itemWidh, 72);
}
-(void)setModel:(FNtradeHomeModel *)model{
    _model=model;
    if(model){
        NSArray *arrList=self.model.cate;
        if(arrList.count>3 && arrList.count<7){
           //self.listView.sd_resetLayout
           //.leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 10);
           self.listView.frame=CGRectMake(0, 0, FNDeviceWidth, 190);
        }
        else if(arrList.count>7){
           self.listView.frame=CGRectMake(0, 0, FNDeviceWidth, 180);
        }
        else if(arrList.count<4){
           self.listView.frame=CGRectMake(0, 0, FNDeviceWidth, 92);
        }
        else{
           self.listView.frame=CGRectMake(0, 0, FNDeviceWidth, 92);
        }
       [self.listView reloadData];
    }
}
@end
