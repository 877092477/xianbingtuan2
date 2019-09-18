//
//  FNshopTendOptionsNeCell.m
//  69橙子
//
//  Created by Jimmy on 2018/11/22.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNshopTendOptionsNeCell.h"
#define _quick_menuH  147


#define _quick_pageH   20
@implementation FNshopTendOptionsNeCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializedSubviews];
        
    }
    return self;
}

- (void)initializedSubviews
{
    //圆形按钮模块
    FNFunctionView *functionview = [[FNFunctionView alloc]initWithFrame:(CGRectMake(0, 10, JMScreenWidth, _quick_menuH+_quick_pageH))];
    functionview.backgroundColor=FNWhiteColor;
    functionview.column = 5;
    functionview.row = 2;
    functionview.singleH = _quick_menuH*0.5;
    functionview.scrollview.pagingEnabled=YES;
    
    [self addSubview:functionview];
    self.functionview=functionview;
    self.functionbgimgview = [UIImageView new];
    self.functionbgimgview.clipsToBounds = YES;
    //[self.functionbgimgview setUrlImg:[FNBaseSettingModel settingInstance].ksrk];
    [self.functionview insertSubview:self.functionbgimgview atIndex:0];
    [self.functionbgimgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
}
-(void)setKuaisurukouList:(NSArray *)kuaisurukouList{
    @WeakObj(self);
    _kuaisurukouList = kuaisurukouList;
    //设置快速入口模块数据
    if (kuaisurukouList.count>0) {
        self.functionview.btnClickedBlock = ^(NSInteger index) {
            if ([selfWeak.delegate respondsToSelector:@selector(tendOptionsAction:)]) {
                [selfWeak.delegate tendOptionsAction:index];
            }
        };
        NSMutableArray* images = [NSMutableArray new];
        NSMutableArray* titles = [NSMutableArray new];
        NSMutableArray* font_Colors = [NSMutableArray new];
        
        for (NSDictionary *dict in kuaisurukouList) {
            Index_kuaisurukou_01Model *kuaisurukou=[Index_kuaisurukou_01Model mj_objectWithKeyValues:dict];
            [images addObject:kuaisurukou.img];
            //[font_Colors addObject:kuaisurukou.font_color];
            [font_Colors addObject:@"3c3c3c"];
            [titles addObject:kuaisurukou.catename];
            NSLog(@"font_color:%@",kuaisurukou.font_color);
        }
        self.functionview.titles = titles;
        self.functionview.images = images;
        self.functionview.font_Colors = font_Colors; 
        
        CGFloat height = 0;
        
        if (titles.count > 5 && titles.count <=10) {
            height = _quick_menuH;
            self.functionview.column = 5;
            self.functionview.row = 2;
            self.functionview.height = height;
            self.functionbgimgview.height = height;
        }else if (titles.count > 10){
            height = _quick_menuH + _quick_pageH;
            self.functionview.column = 5;
            self.functionview.row = 2;
            self.functionbgimgview.height = height;
            self.functionview.height = height;
            
        }else{
            height = _quick_menuH * 0.5;
            self.functionview.row = 1;
            self.functionview.column = titles.count;
            self.functionbgimgview.height = height;
            self.functionview.height = height;
        }
        [self.contentView setNeedsLayout];
        [self.functionview setBtnviews];
    }
}

@end
