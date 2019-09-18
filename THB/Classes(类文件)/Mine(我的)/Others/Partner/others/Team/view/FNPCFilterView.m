//
//  FNPCFilterView.m
//  SuperMode
//
//  Created by jimmy on 2017/10/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPCFilterView.h"

@implementation FNPCFilterView
- (FNCombinedButton *)commissionbtn{
    if (_commissionbtn == nil) {
        _commissionbtn = [[FNCombinedButton alloc]initWithImage:IMAGE(@"screen_off") selectedImage:IMAGE(@"screen_down") title:[NSString stringWithFormat:@"贡献%@",[FNBaseSettingModel settingInstance].YJCustomUnit] font:kFONT14 titleColor:FNBlackColor selectedTitleColor:FNMainGobalControlsColor target:self action:@selector(commissionbtnAction)];
        
    }
    return _commissionbtn;
}
- (FNCombinedButton *)timebtn{
    if (_timebtn == nil) {
        _timebtn = [[FNCombinedButton alloc]initWithImage:IMAGE(@"screen_off") selectedImage:IMAGE(@"screen_down") title:@"入驻时间" font:kFONT14 titleColor:FNBlackColor selectedTitleColor:FNMainGobalControlsColor target:self action:@selector(timebtnAction)];
        
    }
    return _timebtn;
}
#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    self.backgroundColor = FNWhiteColor;
    [self addSubview:self.timebtn];
    [self.timebtn autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeRight)];
    [self.timebtn autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:self withMultiplier:0.5];
    [self addSubview:self.commissionbtn];
    [self.commissionbtn autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeLeft)];
    [self.commissionbtn autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:self withMultiplier:0.5];
    
    self.height = 40;
}
#pragma mark - aciton
- (void)timebtnAction{
    if (self.filtertype == PFFilterTypeTimeDescending) {
        self.filtertype = PFFilterTypeTimeAscending;
    }else{
        self.filtertype = PFFilterTypeTimeDescending;
    }
    self.timebtn.selected  =YES;
    self.commissionbtn.selected = NO;
}
- (void)commissionbtnAction{
    if (self.filtertype == PFFilterTypeCommissionDescending) {
        self.filtertype = PFFilterTypeCommissionAscending;
    }else{
        self.filtertype = PFFilterTypeCommissionDescending;
    }
    self.timebtn.selected  =NO;
    self.commissionbtn.selected = YES;
}


- (void)setFiltertype:(PFFilterType)filtertype{
    _filtertype = filtertype;
    switch (filtertype) {
        case PFFilterTypeTimeDescending:
        {
            [self.timebtn.titleLabel setImage:IMAGE(@"screen_down") forState:(UIControlStateSelected)];
            break;
            
        }
        case PFFilterTypeTimeAscending:
        {
            [self.timebtn.titleLabel setImage:IMAGE(@"screen_up") forState:(UIControlStateSelected)];
            break;
            
        }
        case PFFilterTypeCommissionDescending:
        {
            [self.commissionbtn.titleLabel setImage:IMAGE(@"screen_down") forState:(UIControlStateSelected)];
            break;
            
        }
        case PFFilterTypeCommissionAscending:
        {
            [self.commissionbtn.titleLabel setImage:IMAGE(@"screen_up") forState:(UIControlStateSelected)];
            break;
            
        }
        default:
            break;
    }
    if (self.filterBlock) {
        self.filterBlock(self.filtertype);
    }
}
@end
