//
//  FNLiveCouponeGridCell.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNLiveCouponeGridCell.h"

@implementation FNLiveCouponeGridCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.index_tuwenwei_01List = [NSMutableArray new];
        [self initializedSubviews];
        
    }
    
    return self;
}

- (UIImageView *)specialbgimgview{
    if (_specialbgimgview == nil) {
        _specialbgimgview = [UIImageView new];
        [_specialbgimgview setUrlImg:[FNBaseSettingModel settingInstance].tw];
    }
    return _specialbgimgview;
}
- (void)initializedSubviews
{
    //图文模块
    _specialView = [[FNLiveCouponeSpecialView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth, 0.53*FNDeviceWidth))];
    [_specialView insertSubview:self.specialbgimgview atIndex:0];
    _specialView.timerHide=YES;
    [self addSubview:_specialView];
}

-(void)setIndex_tuwenwei_01List:(NSArray<MenuModel *> *)index_tuwenwei_01List{
    _index_tuwenwei_01List = index_tuwenwei_01List;
    @WeakObj(self);
    if (index_tuwenwei_01List.count>0) {
        
        NSMutableArray* tuwenweiArr=[[NSMutableArray alloc]init];
        
        for (NSDictionary *dict in index_tuwenwei_01List) {
            MenuModel *tuwenweiModel=[MenuModel mj_objectWithKeyValues:dict];
            [tuwenweiArr addObject:tuwenweiModel];
        }
        _specialView.specialArray = tuwenweiArr;
        _specialView.specialViewClicked = ^(NSInteger index) {
            if (selfWeak.QuickClickedBlock) {
                selfWeak.QuickClickedBlock(index_tuwenwei_01List[index]);
            }
        };
    }
    
}

@end
