//
//  FXQuickView.m
//  THB
//
//  Created by zhongxueyu on 16/7/29.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "FXQuickView.h"
#import "XYFXMenuView.h"
#define MenuH 167
@interface FXQuickView ()<UIGestureRecognizerDelegate>
@property (strong,nonatomic) UIImageView *imageView;
@property (strong,nonatomic) UILabel *titleLable;
@property (strong,nonatomic) NSMutableArray *imgArray;
@property(nonatomic,strong)UIView *firstVC;
/** 存放快速入口Model的数组 */
@property (nonatomic,strong) NSMutableArray *titleArray;

@end

@implementation FXQuickView

@synthesize imageView,titleLable,firstVC;
-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addContentView];
    }
    return self;
}

-(void)addContentView{
    

    _imgArray = [NSMutableArray arrayWithObjects:@"money",@"team",@"order",@"fx-code", nil];

    _titleArray = [NSMutableArray arrayWithObjects:@"收益统计",@"我的团队",@"分销订单",@"二维码", nil];

    firstVC=[[UIView alloc]initWithFrame:CGRectMake(0,0,XYScreenWidth,MenuH)];
    [self addSubview:firstVC];
//    firstVC.backgroundColor = [UIColor blackColor];
    for (int i=0;i<_imgArray.count;i++) {
        if (i<_imgArray.count) {
            CGRect frame=CGRectMake(i*XYScreenWidth/_imgArray.count,0,XYScreenWidth/_imgArray.count,MenuH/2);
            NSString *title=_titleArray[i];
            NSString *imageStr=_imgArray[i];
            XYFXMenuView *menuView=[[XYFXMenuView alloc]initWithFrame:frame title:title imageStr:imageStr];
            menuView.tag=10+i;
            [firstVC addSubview:menuView];
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnTapBtnView:)];
            [menuView addGestureRecognizer:tap];
        }
    }
    
}
-(void)OnTapBtnView:(UITapGestureRecognizer *)sender
{
    
    NSInteger tag = sender.view.tag-10;
    //    MenuModel *model =tapArray[tag];
    //    NSString *url =model.url;
    [self.delegate OnTapMenuView:tag];
}


- (NSMutableArray *)imgArray {
    if (!_imgArray) {
        _imgArray = [NSMutableArray array];
    }
    return _imgArray;
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}



@end
