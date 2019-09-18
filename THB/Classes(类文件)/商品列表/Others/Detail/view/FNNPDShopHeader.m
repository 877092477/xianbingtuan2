//
//  FNNPDShopHeader.m
//  THB
//
//  Created by Jimmy on 2017/12/16.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNNPDShopHeader.h"
#import "FNCombinedButton.h"
#import "FNNewProductDetailModel.h"
const CGFloat _npdsH_top_h = 70;
const CGFloat _npdsH_btm_h = 44;
@interface FNNPDShopHeader()
@property (nonatomic, strong)UIView* topview;
@property (nonatomic, strong)NSLayoutConstraint* topviewconsh;
@property (nonatomic, strong)UIImageView* logoimgview;
@property (nonatomic, strong)UILabel* nameLabel;
@property (nonatomic, strong)UIImageView* shopTypeimgview;


@property (nonatomic, strong)UIView* btmview;
@property (nonatomic, strong)NSLayoutConstraint* btmviewconsh;
@property (nonatomic, strong)NSMutableArray* btns;

@end
@implementation FNNPDShopHeader
- (NSMutableArray *)btns{
    if (_btns == nil) {
        _btns = [NSMutableArray new];
    }
    return _btns;
}
- (UIView *)topview{
    if (_topview == nil) {
        _topview = [UIView new];
        _topview.backgroundColor = FNWhiteColor;
        [_topview addSubview:self.logoimgview];
        [self.logoimgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(_jmsize_15, _jmsize_15, 20, _jmsize_15)) excludingEdge:(ALEdgeRight)];
        [self.logoimgview autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionHeight) ofView:self.logoimgview];
        
        [_topview addSubview:self.nameLabel];
        [self.nameLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.logoimgview withOffset:_jmsize_10];
        [self.nameLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeTop) ofView:self.logoimgview];
        
        [_topview addSubview:self.shopTypeimgview];
        [self.shopTypeimgview autoSetDimensionsToSize:self.shopTypeimgview.size];
        [self.shopTypeimgview autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.nameLabel];
        [self.shopTypeimgview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.logoimgview];
        
        [_topview addSubview:self.searchbtn];
        [self.searchbtn autoSetDimensionsToSize:CGSizeMake(self.searchbtn.size.width + 24, 20)];
        [self.searchbtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
        [self.searchbtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        
    }
    return _topview;
}
- (UIImageView *)logoimgview{
    if (_logoimgview == nil) {
        _logoimgview = [UIImageView new];
        _logoimgview.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _logoimgview;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.font = kFONT14;
        _nameLabel.adjustsFontSizeToFitWidth =YES;
    }
    return _nameLabel;
}
- (UIImageView *)shopTypeimgview{
    if (_shopTypeimgview == nil) {
        _shopTypeimgview = [[UIImageView alloc]initWithImage:IMAGE(@"shop_tmall")];
    }
    return _shopTypeimgview;
}
- (UIButton *)searchbtn{
    if (_searchbtn == nil) {
        _searchbtn = [UIButton buttonWithTitle:@"更多店铺优惠" titleColor:FNGlobalTextGrayColor font:kFONT12 target:self action:nil];
        _searchbtn.userInteractionEnabled = NO;
        [_searchbtn sizeToFit];
    }
    return _searchbtn;
}

-(UIView *)btmview{
    if (_btmview == nil) {
        _btmview = [UIView new];
        _btmview.backgroundColor = FNWhiteColor;
    }
    return _btmview;
}

- (void)jm_setupViews{
    [self addSubview:self.topview];
    [self.topview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    self.topviewconsh = [self.topview autoSetDimension:(ALDimensionHeight) toSize:0];
    
    [self addSubview:self.btmview];
    [self.btmview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeTop)];
    self.btmviewconsh = [self.btmview autoSetDimension:(ALDimensionHeight) toSize:0];
    
    [self changeHeight];
}
- (void)setupBtmViews{
    if (self.btns.count>=1) {
        [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.btns removeAllObjects];
    }
    @weakify(self);
    CGFloat width = (JMScreenWidth-1)/self.titles.count;
    [self.titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        UILabel *Label=[[UILabel alloc]initWithFrame:CGRectMake(idx*(width+1), 0, width, _npdsH_btm_h)];
        Label.textAlignment=NSTextAlignmentCenter;
        Label.textColor=FNBlackColor;
        Label.font=kFONT12;
        Label.text=obj;
        [Label HttpLabelLeftImage:self.images[idx] label:Label imageX:0 imageY:-2 imageH:12 atIndex:Label.text.length];
        [self.btmview addSubview:Label];
        [self.btns addObject:Label];
    }];
}
- (void)setModel:(JM_NPD_dpArr *)model{
    _model = model;
    if (_model) {
        self.topviewconsh.constant = _npdsH_top_h;
        [self.logoimgview setUrlImg:_model.logo];
        [self.shopTypeimgview setUrlImg:_model.shop_type_img];
        [self setMoreText:model.btn_str withTextColor:[UIColor colorWithHexString:model.btn_fontcolor] andBackgroundImage:model.btn_img];
        self.nameLabel.text = _model.name;
        if (self.model.fs.count>0) {
            self.btmviewconsh.constant = _npdsH_btm_h;
            NSMutableArray* titles = [NSMutableArray new];
            NSMutableArray* images = [NSMutableArray new];
            [self.model.fs enumerateObjectsUsingBlock:^(JM_NPD_fs * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [titles addObject:[NSString stringWithFormat:@"%@:%@",obj.title,obj.score]?:@"暂无评分"];
                [images addObject:obj.img?:@""];
            }];
            self.images = images;
            self.titles = titles;
            [self setupBtmViews];
        }
        [self changeHeight];
    }
}
- (void)changeHeight{
    self.height=self.topviewconsh.constant+self.btmviewconsh.constant+1;
    if (self.returnHeight) {
        self.returnHeight(self.height);
    }
}

- (void) setMoreText: (NSString*) text withTextColor: (UIColor*)textColor andBackgroundImage: (NSString*)image {
    [self.searchbtn setTitle:text forState:UIControlStateNormal];
    [self.searchbtn setTitleColor:textColor forState:UIControlStateNormal];
//    [self.searchbtn setBackgroundImage:image forState:UIControlStateNormal];
    [self.searchbtn sd_setBackgroundImageWithURL:URL(image) forState:UIControlStateNormal];
}
@end
