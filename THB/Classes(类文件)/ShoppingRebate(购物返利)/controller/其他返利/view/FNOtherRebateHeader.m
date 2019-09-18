//
//  FNOtherRebateHeader.m
//  THB
//
//  Created by Fnuo-iOS on 2018/5/5.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNOtherRebateHeader.h"

@implementation FNOtherRebateHeader

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
        
        UIButton* searchBtn = [UIButton buttonWithTitle:@"找券" titleColor:FNWhiteColor font:kFONT15 target:self action:@selector(searchBtnAction)];
        [searchBtn sizeToFit];
        searchBtn.backgroundColor = RGB(240, 204, 48);
        searchBtn.cornerRadius = 22;
        [_btmview addSubview:searchBtn];
        [searchBtn autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeLeft)];
        [searchBtn autoSetDimension:(ALDimensionWidth) toSize:searchBtn.width+40];
        
    }
    return _btmview;
}

- (UITextField *)searchTF{
    if (_searchTF == nil) {
        _searchTF = [UITextField new];
        _searchTF.font = kFONT14;
    }
    return _searchTF;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *BGImageView=[UIImageView new];
        [self addSubview:BGImageView];
        [BGImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(@0);
        }];
        self.BGImageView=BGImageView;
        
        [self addSubview:self.btmview];
        [self.btmview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(_jm_leftMargin));
            make.right.bottom.equalTo(@(-_jm_leftMargin));
            make.height.equalTo(@44);
        }];
    }
    return self;
}

-(void)setModel:(OtherRebatetopListModel *)Model{
    _Model=Model;
    if (_Model) {
        [self.BGImageView setUrlImg:_Model.img];
        self.searchTF.placeholder=_Model.str;
        self.searchTF.text=_Model.keyword;
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
