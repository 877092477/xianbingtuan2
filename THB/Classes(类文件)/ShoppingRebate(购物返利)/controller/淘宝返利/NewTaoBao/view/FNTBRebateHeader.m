//
//  FNTBRebateHeader.m
//  THB
//
//  Created by jimmy on 2017/10/31.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNTBRebateHeader.h"

@interface FNTBRebateHeader()<UITextFieldDelegate>
@property (nonatomic, strong)UIView* topview;
@property (nonatomic, strong)UIView* btmview;
@property (nonatomic, strong)UITextField* searchTF;
@end
@implementation FNTBRebateHeader
- (UIView *)topview{
    if (_topview == nil) {
        _topview = [UIView new];
        
        UIView* view = [UIView new];
        [_topview addSubview:view];
        [view autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
        [view autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:0];
        [view autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
        
        UIImageView* img = [[UIImageView alloc]initWithImage:IMAGE(@"shop_logo")];
        [view addSubview:img];
        [img autoSetDimensionsToSize:img.size];
        [img autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        [img autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        
        UILabel* titleLabel = [UILabel new];
        titleLabel.font = [UIFont systemFontOfSize:img.size.height];
        titleLabel.textColor = RGB(255, 217, 59);
        [view addSubview:titleLabel];
        titleLabel.text = @"海量内部优惠券";
        [titleLabel sizeToFit];
        [titleLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:img withOffset:_jm_margin10];
        [titleLabel autoSetDimension:(ALDimensionWidth) toSize:titleLabel.width];
        [titleLabel autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        
        [view autoPinEdge:(ALEdgeRight) toEdge:(ALEdgeRight) ofView:titleLabel];
    }
    return _topview;
}
- (UITextField *)searchTF{
    if (_searchTF == nil) {
        _searchTF = [UITextField new];
        _searchTF.font = kFONT14;
        _searchTF.placeholder = @"搜索淘宝／天猫商品，领内部优惠券";
    }
    return _searchTF;
}
- (UIView *)btmview{
    if (_btmview == nil) {
        _btmview = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, FNDeviceWidth-_jm_leftMargin*2, 44))];
        _btmview.cornerRadius = 22;
        _btmview.backgroundColor = FNWhiteColor;
        
        UIImageView* leftimgview = [[UIImageView alloc]initWithImage:IMAGE(@"shop_search")];
        [_btmview addSubview:leftimgview];
        [leftimgview autoSetDimensionsToSize:leftimgview.size];
        [leftimgview autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [leftimgview autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_margin10*2];
        
        
        [_btmview addSubview:self.searchTF];
        [self.searchTF autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
        [self.searchTF autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:0];
        [self.searchTF autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:leftimgview withOffset:_jm_margin10];
        
        UIButton* searchBtn = [UIButton buttonWithTitle:@"找券" titleColor:FNWhiteColor font:kFONT14 target:self action:@selector(searchBtnAction)];
        [searchBtn sizeToFit];
        searchBtn.backgroundColor = RGB(240, 204, 48);
        searchBtn.cornerRadius = 22;
        [_btmview addSubview:searchBtn];
        [searchBtn autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeLeft)];
        [searchBtn autoSetDimension:(ALDimensionWidth) toSize:searchBtn.width+40];
        
    }
    return _btmview;
}
#pragma mark - initializedSubviews
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self jm_setupViews];
    }
    return self;
}
- (void)jm_setupViews
{
    [self addSubview:self.topview];
    [self.topview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(_jm_leftMargin, _jm_leftMargin, 0, _jm_leftMargin)) excludingEdge:(ALEdgeBottom)];
    [self.topview autoSetDimension:(ALDimensionHeight) toSize:44];
    
    [self addSubview:self.btmview];
    [self.btmview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(0, _jm_leftMargin, _jm_leftMargin, _jm_leftMargin)) excludingEdge:(ALEdgeTop)];
    [self.btmview autoSetDimension:(ALDimensionHeight) toSize:self.btmview.height];
    
    UIImageView* bgimgview = [[UIImageView alloc]initWithImage:IMAGE(@"shop_bj")];
    [self insertSubview:bgimgview atIndex:0];
    [bgimgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
    self.height = 44*2+_jm_leftMargin*3;
}

-(void)setModel:(OtherRebatetopListModel *)Model{
    _Model=Model;
    if (_Model) {
        
    }
}

- (void)searchBtnAction{
    if(self.searchTF.text && self.searchTF.text.length>=1 && self.searchBlock){
        [self.searchTF resignFirstResponder];
        self.searchBlock(self.searchTF.text);
    }else{
        [self.searchTF kr_shake];
    }
}

@end
