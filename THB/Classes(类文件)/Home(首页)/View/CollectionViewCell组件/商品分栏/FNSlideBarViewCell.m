//
//  FNSlideBarViewCell.m
//  THB
//
//  Created by zhongxueyu on 2018/8/20.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNSlideBarViewCell.h"

@implementation FNSlideBarViewCell
{
    NSInteger ColumnSelectIndex;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.index_goods_01List = [NSArray new];
        [self initializedSubviews];
        
    }
    
    return self;
}

- (void)initializedSubviews
{
    
    //商品分栏模块
    _slideBarView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, 80)];
    _slideBarView.backgroundColor=FNWhiteColor;
    [self addSubview:_slideBarView];

    
    UIImageView* img = [[UIImageView alloc]initWithImage:IMAGE(@"home_highRebate")];
    img.contentMode = UIViewContentModeScaleAspectFit;
    img.clipsToBounds = YES;
    [_slideBarView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.centerX.equalTo(_slideBarView.mas_centerX);
        make.height.equalTo(@40);
//        make.width.equalTo(@(img.size.width));
    }];
    [img setUrlImg:[FNBaseSettingModel settingInstance].index_cgfjx_ico];

    if(![[FNBaseSettingModel settingInstance].index_cgfjx_ico kr_isNotEmpty]){
        img.hidden = YES;
        img.height = 0;
        _slideBarView.height = 40;
    }

    
    _slideBar = [[FDSlideBar alloc] initWithFrame:CGRectMake(0, 0, FNDeviceWidth, 40)];
    _slideBar.backgroundColor = FNWhiteColor;
    _slideBar.is_middle=YES;
   
    [_slideBarView addSubview:_slideBar];
    [_slideBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
//        make.top.equalTo(img.mas_bottom);
        make.left.right.bottom.equalTo(@0);
    }];
    
    
    
}
 
-(void)setIndex_goods_01List:(NSArray *)index_goods_01List{
    if (_index_goods_01List.count<=0) {
        _index_goods_01List = index_goods_01List;

    }

    @WeakObj(self);
    //设置商品分类
    if (index_goods_01List.count>0) {
        [_slideBar slideBarItemSelectedCallback:^(NSUInteger index) {
            int idx = 0;
            NSMutableArray* goodsIndexArr=[[NSMutableArray alloc]init];
            
            for (NSDictionary *dict in index_goods_01List) {
                
                Index_goods_01Model *goodsModel=[Index_goods_01Model mj_objectWithKeyValues:dict];
                
                if (idx==index) {
                    goodsModel.is_check=@"1";
                }else{
                    goodsModel.is_check=@"0";
                }
                [goodsIndexArr addObject:goodsModel];

                _index_goods_01List = goodsIndexArr;

                idx ++;
            }
            //将选中的model 索引 传过去
            if(selfWeak.ColumnClickedAddIntBlock){
                selfWeak.ColumnClickedAddIntBlock(goodsIndexArr[index], index);
            }
        }];
        
        int idx = 0;
        NSMutableArray *title=[[NSMutableArray alloc]init];
        for (NSDictionary *dict in _index_goods_01List) {
            
            Index_goods_01Model *goodsModel=[Index_goods_01Model mj_objectWithKeyValues:dict];
            [title addObject:goodsModel.name];
            if ([goodsModel.is_check integerValue]==1) {
                ColumnSelectIndex=idx;
            }
            idx ++;
        }
        _slideBar.itemsTitle = title;
        _slideBar.itemColor = FNGlobalTextGrayColor;
        _slideBar.itemSelectedColor = FNMainGobalTextColor;
        _slideBar.sliderColor = FNMainGobalTextColor;
        _slideBar.fontSize=13;
        _slideBar.SelectedfontSize=14;
        [_slideBar selectSlideBarItemAtIndex:ColumnSelectIndex];
    }
}

-(void)setStoreindex:(NSInteger)storeindex{
     [_slideBar selectSlideBarItemAtIndex:storeindex];
}
@end
