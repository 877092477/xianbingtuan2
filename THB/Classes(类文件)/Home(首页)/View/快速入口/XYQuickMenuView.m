//
//  XYQuickMenuView.m
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

#import "XYQuickMenuView.h"

#import "MenuModel.h"
const CGFloat _quick_menuH = 155-8;
const CGFloat _quick_pageH = 20;



@interface XYQuickMenuView ()<UIGestureRecognizerDelegate,UIScrollViewDelegate>
@property (strong,nonatomic) UIImageView *imageView;
@property (strong,nonatomic) UILabel *titleLable;
@property (strong,nonatomic) NSArray *tapArray;
@property(nonatomic,strong)UIView *firstVC;

@property(nonatomic,strong)UIView *secondVC;

@property(nonatomic,strong)UIPageControl *pageControl;


@property (nonatomic, strong)NSMutableArray* views;
@end
@implementation XYQuickMenuView
@synthesize imageView,titleLable,tapArray,firstVC,menu;

- (NSMutableArray<XYMenuView *> *)menuviews
{
    if (_menuviews == nil) {
        _menuviews = [NSMutableArray new];
    }
    return _menuviews;
}
- (NSMutableArray *)views
{
    if (_views == nil) {
        _views = [NSMutableArray new];
    }
    return _views;
}
-(void)addContentView:(NSArray *)menuArray{
    
    if (self.views.count>=1) {
        [self.views makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.views removeAllObjects];
    }
    if (self.menuviews.count>=1) {
        [self.menuviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.menuviews removeAllObjects];
    }
    tapArray = [NSMutableArray array];
    tapArray = menuArray;
    int i ;
    if (menuArray.count>5) {
        i = 1;
    }else{
        i = 2;
    }
    
    int num ;
    if(menuArray.count>10){
        num = 2;
    }else{
        num = 1;
    }
    firstVC=[[UIView alloc]initWithFrame:CGRectMake(0,0,XYScreenWidth,_quick_menuH)];
    _secondVC=[[UIView alloc]initWithFrame:CGRectMake(XYScreenWidth,0,XYScreenWidth,_quick_menuH)];
    
    //    [self addSubview:firstVC];
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,XYScreenWidth,_quick_menuH+_quick_pageH)];
    scrollView.contentSize=CGSizeMake(num*XYScreenWidth,_quick_menuH+_quick_pageH);
    scrollView.pagingEnabled=YES;
    scrollView.delegate=self;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.showsHorizontalScrollIndicator=NO;
    [scrollView addSubview:firstVC];
    [scrollView addSubview:_secondVC];
    [self addSubview:scrollView];
    [self.views addObject:scrollView];
    
    for (int i=0;i<tapArray.count;i++) {
        if (i<5) {
            menu = tapArray[i];
            CGRect frame=CGRectMake(i*XYScreenWidth/5,0,XYScreenWidth/5,_quick_menuH/2);
            NSString *title=menu.name;
            NSString *imageStr=menu.img;
            XYMenuView *menuView=[[XYMenuView alloc]initWithFrame:frame title:title imageStr:imageStr];
            menuView.tag=10+i;
            [firstVC addSubview:menuView];
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnTapBtnView:)];
            [menuView addGestureRecognizer:tap];
            [self.menuviews addObject:menuView];
        }else if (i<10) {
            menu = tapArray[i];
            CGRect frame=CGRectMake((i-5)*XYScreenWidth/5,_quick_menuH/2,XYScreenWidth/5,_quick_menuH/2);
            NSString *title=menu.name;
            NSString *imageStr=menu.img;
            XYMenuView *menuView=[[XYMenuView alloc]initWithFrame:frame title:title imageStr:imageStr];
            menuView.tag=10+i;
            [firstVC addSubview:menuView];
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnTapBtnView:)];
            [menuView addGestureRecognizer:tap];
            [self.menuviews addObject:menuView];
        }else if (i<15){
            menu = tapArray[i];
            CGRect frame=CGRectMake((i-10)*XYScreenWidth/5,0,XYScreenWidth/5,_quick_menuH/2);
            NSString *title=menu.name;
            NSString *imageStr=menu.img;
            XYMenuView *menuView=[[XYMenuView alloc]initWithFrame:frame title:title imageStr:imageStr];
            menuView.tag=10+i;
            [_secondVC addSubview:menuView];
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnTapBtnView:)];
            [menuView addGestureRecognizer:tap];
            [self.menuviews addObject:menuView];
        }else if (i<20){
            menu = tapArray[i];
            CGRect frame=CGRectMake((i-15)*XYScreenWidth/5,_quick_menuH/2,XYScreenWidth/5,_quick_menuH/2);
            NSString *title=menu.name;
            NSString *imageStr=menu.img;
            XYMenuView *menuView=[[XYMenuView alloc]initWithFrame:frame title:title imageStr:imageStr];
            menuView.tag=10+i;
            [_secondVC addSubview:menuView];
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnTapBtnView:)];
            [menuView addGestureRecognizer:tap];
            [self.menuviews addObject:menuView];
        }
        _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(XYScreenWidth/2,_quick_menuH-5,0,_quick_pageH)];
        _pageControl.currentPage=0;
        _pageControl.numberOfPages=num;
        if (i>=10) {
            [_pageControl setCurrentPageIndicatorTintColor:RED];
            [_pageControl setPageIndicatorTintColor:[UIColor grayColor]];

            [self addSubview:_pageControl];
            [self.views addObject:_pageControl];
        }
        
    }
    [self.menuviews enumerateObjectsUsingBlock:^(XYMenuView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        menu = tapArray[idx];
        obj.titleLabel.textColor = [NSString isEmpty:menu.font_color]?FNBlackColor:[UIColor colorWithHexString:menu.font_color];
        obj.titleLabel.adjustsFontSizeToFitWidth = YES;
    }];
  
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollViewW/2)/scrollViewW;
    _pageControl.currentPage = page;
    _pageControl.currentPage=page;
    
}
-(void)OnTapBtnView:(UITapGestureRecognizer *)sender
{
    
    NSInteger tag = sender.view.tag-10;
    //    MenuModel *model =tapArray[tag];
    //    NSString *url =model.url;
    [self.delegate OnTapMenuView:tag];
}



- (void)setMenuModelArray:(NSArray<MenuModel *> *)menuModelArray{
    _menuModelArray = menuModelArray;
    [self addContentView:_menuModelArray];
}
@end
