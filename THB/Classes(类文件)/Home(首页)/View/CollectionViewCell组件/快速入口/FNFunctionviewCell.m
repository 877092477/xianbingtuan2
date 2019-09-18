//
//  FNFunctionviewCell.m
//  THB
//
//  Created by zhongxueyu on 2018/8/20.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNFunctionviewCell.h"
#define _quick_menuH  147


#define _quick_pageH   20

@interface FNFunctionviewCell()

//快速入口数据数组（index_kuaisurukou_01）
@property (nonatomic, strong)NSArray *index_kuaisurukou_01List;

@end

@implementation FNFunctionviewCell
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
    FNFunctionView *functionview = [[FNFunctionView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth, _quick_menuH+_quick_pageH))];
    functionview.backgroundColor=FNWhiteColor;
    functionview.column = 5;
    functionview.row = 2;
    functionview.singleH = _quick_menuH*0.5;
    functionview.scrollview.pagingEnabled=YES;
    
    
    [self addSubview:functionview];
    self.functionview=functionview;
    
    self.functionbgimgview = [UIImageView new];
    self.functionbgimgview.clipsToBounds = YES;
    [self.functionbgimgview setUrlImg:[FNBaseSettingModel settingInstance].ksrk];
    [self.functionview insertSubview:self.functionbgimgview atIndex:0];
    [self.functionbgimgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
    
}

-(void)setIndex_kuaisurukou_01List:(NSArray *)index_kuaisurukou_01List withColumn: (int)column{
    @WeakObj(self);
    
    _index_kuaisurukou_01List = index_kuaisurukou_01List;
    
    //设置快速入口模块数据
    if (index_kuaisurukou_01List.count>0) {
        self.functionview.btnClickedBlock = ^(NSInteger index) {
            
            if (selfWeak.QuickClickedBlock) {
                selfWeak.QuickClickedBlock(index_kuaisurukou_01List[index]);
            }
            
        };
        NSMutableArray* images = [NSMutableArray new];
        NSMutableArray* titles = [NSMutableArray new];
        NSMutableArray* font_Colors = [NSMutableArray new];
        
        for (NSDictionary *dict in index_kuaisurukou_01List) {
            Index_kuaisurukou_01Model *kuaisurukou=[Index_kuaisurukou_01Model mj_objectWithKeyValues:dict];
            [images addObject:kuaisurukou.img];
            [font_Colors addObject:kuaisurukou.font_color];
            [titles addObject:kuaisurukou.name];
            NSLog(@"font_color:%@",kuaisurukou.font_color);
        }
         NSLog(@"font_Colors:%@",font_Colors);
        self.functionview.titles = titles;
        self.functionview.images = images;
        self.functionview.font_Colors = font_Colors;

        
            // 处理耗时操作的代码块...
            CGFloat height = 0;

            if (titles.count > column && titles.count <=column * 2) {
                height = _quick_menuH;
                self.functionview.column = column;
                self.functionview.row = 2;
                self.functionview.height = height;
                self.functionbgimgview.height = height;
            }else if (titles.count > column * 2){
                height = _quick_menuH + _quick_pageH;
                self.functionview.column = column;
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

-(void)setCateString:(NSString *)cateString{
    _cateString=cateString;
    if(![cateString isEqualToString:@"0"]){
        self.functionbgimgview.hidden=YES;
    }
}
@end
