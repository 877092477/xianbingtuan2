//
//  FNNewStoreGoodsAttributeAlertView.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/31.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStoreGoodsAttributeAlertView.h"
#import "FNNewStorePayAttributeCell.h"
#import "FNMaximumSpacingFlowLayout.h"
#import "FNFNGoodsSelectorTitle.h"

@interface FNNewStoreGoodsAttributeAlertView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIButton *btnBg;
@property (nonatomic, strong) UIView *vAlert;

@property (nonatomic, strong) UIButton *btnClose;
@property (nonatomic, strong) UIImageView *imgGoods;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblPrice;
@property (nonatomic, strong) UILabel *lblOPrice;
@property (nonatomic, strong) UICollectionView *clvAttributes;
@property (nonatomic, strong) UIButton *btnConfirm;

@property (nonatomic, strong) UIButton *btnSub;
@property (nonatomic, strong) UILabel *lblCount;
@property (nonatomic, strong) UIButton *btnAdd;

@property (nonatomic, strong) FNStoreGoodsModel* model;

@property (nonatomic, copy) NSString *specs;
@property (nonatomic, strong) NSMutableArray<NSString*> *atts;

@end

@implementation FNNewStoreGoodsAttributeAlertView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _atts = [[NSMutableArray alloc] init];
        [self configUI];
    }
    return self;
}

- (void) configUI {
    _btnBg = [[UIButton alloc] init];
    _vAlert = [[UIView alloc] init];
    _btnClose = [[UIButton alloc] init];
    _imgGoods = [[UIImageView alloc] init];
    _lblTitle = [[UILabel alloc] init];
    _lblPrice = [[UILabel alloc] init];
    _lblOPrice = [[UILabel alloc] init];
    _btnConfirm = [[UIButton alloc] init];
    
    _btnSub = [[UIButton alloc] init];
    _lblCount = [[UILabel alloc] init];
    _btnAdd = [[UIButton alloc] init];
    
    FNMaximumSpacingFlowLayout *flowayout=[[FNMaximumSpacingFlowLayout alloc]init];
    flowayout.minimumLineSpacing=0;
    flowayout.minimumInteritemSpacing=0;
    
    _clvAttributes = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowayout];
    
    [self addSubview:_btnBg];
    [self addSubview:_vAlert];
    [_vAlert addSubview:_btnClose];
    [_vAlert addSubview:_imgGoods];
    [_vAlert addSubview:_lblTitle];
    [_vAlert addSubview:_lblPrice];
    [_vAlert addSubview:_lblOPrice];
    [_vAlert addSubview:_clvAttributes];
    [_vAlert addSubview:_btnConfirm];
    
    [_vAlert addSubview:_btnSub];
    [_vAlert addSubview:_lblCount];
    [_vAlert addSubview:_btnAdd];
    
    [_btnBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_vAlert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
//        make.bottom.equalTo(@20);
        make.height.mas_equalTo(556);
        make.top.equalTo(self.mas_bottom);
    }];
    [_btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lblTitle);
        make.right.equalTo(@-10);
        make.width.height.mas_equalTo(24);
    }];
    [_imgGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@13);
        make.top.equalTo(@13);
        make.width.height.mas_equalTo(94);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgGoods.mas_right).offset(10);
        make.right.lessThanOrEqualTo(@-20);
        make.top.equalTo(self.imgGoods).offset(10);
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgGoods.mas_right).offset(10);
        make.bottom.equalTo(self.imgGoods).offset(-10);
    }];
    [_lblOPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblPrice.mas_right).offset(4);
        make.bottom.equalTo(self.imgGoods).offset(-10);
    }];
    [_clvAttributes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@13);
        make.right.equalTo(@-13);
        make.top.equalTo(self.imgGoods.mas_bottom).offset(12);
        make.bottom.equalTo(self.btnAdd.mas_top).offset(-12);
    }];
    
    [_btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(isIphoneX ? @-34 : @0);
    }];
    
    [_btnSub mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20);
        make.centerY.equalTo(self.btnAdd);
        make.right.equalTo(self.lblCount.mas_left).offset(-2);
    }];
    [_lblCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(20);
        make.centerY.equalTo(self.btnAdd);
        make.right.equalTo(self.btnAdd.mas_left).offset(-2);
    }];
    [_btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20);
        make.bottom.equalTo(self.btnConfirm.mas_top).offset(-40);
        make.right.equalTo(@-15);
    }];
    
    self.hidden = YES;
    
    _btnBg.backgroundColor = RGBA(0, 0, 0, 0.2);
    
    _vAlert.layer.backgroundColor = UIColor.whiteColor.CGColor;
    _vAlert.layer.cornerRadius = 13;
    
    [_btnClose setImage:IMAGE(@"store_coupone_close_button") forState: UIControlStateNormal];
    
    [_clvAttributes registerClass:[FNNewStorePayAttributeCell class] forCellWithReuseIdentifier:@"FNNewStorePayAttributeCell"];
    [_clvAttributes registerClass:[FNFNGoodsSelectorTitle class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNFNGoodsSelectorTitle"];
    _clvAttributes.showsVerticalScrollIndicator=NO;
    _clvAttributes.showsHorizontalScrollIndicator=NO;
    _clvAttributes.delegate=self;
    _clvAttributes.dataSource=self;
    _clvAttributes.bounces = NO;
    _clvAttributes.backgroundColor = UIColor.clearColor;

    _lblTitle.font = [UIFont boldSystemFontOfSize:18];
    _lblTitle.textColor = RGB(51, 51, 51);
    
    _lblPrice.textColor = RGB(254, 67, 62);
    _lblPrice.font = [UIFont systemFontOfSize:22];
    
    _lblOPrice.textColor = RGB(153, 153, 153);
    _lblOPrice.font = [UIFont systemFontOfSize:12];

    _btnConfirm.backgroundColor = RGB(242, 58, 77);
    [_btnConfirm setTitle: @"确定" forState: UIControlStateNormal];
    [_btnConfirm setTitleColor: UIColor.whiteColor forState: UIControlStateNormal];
    _btnConfirm.titleLabel.font = kFONT15;
    [_btnConfirm addTarget:self action:@selector(onConfirmClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnClose addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_btnBg addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnSub setImage: IMAGE(@"store_goods_sub") forState: UIControlStateNormal];
    
    _lblCount.font = kFONT13;
    _lblCount.textColor = RGB(140, 140, 140);
    _lblCount.text = @"1";
    _lblCount.textAlignment = NSTextAlignmentCenter;
    
    [_btnAdd setImage: IMAGE(@"store_goods_add") forState: UIControlStateNormal];
    
    [_btnSub addTarget:self action:@selector(onSubClick) forControlEvents:UIControlEventTouchUpInside];
    [_btnAdd addTarget:self action:@selector(onAddClick) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    int count = 0;
    if (self.model.specs) {
        count ++;
    }
    return self.model.attribute.count + count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger index = section;
    if (self.model.specs) {
        if (index == 0) {
            return self.model.specs.data.count;
        }
        
        index --;
    }
    
    return self.model.attribute[index].data.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    FNNewStorePayAttributeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNNewStorePayAttributeCell" forIndexPath:indexPath];
//    cell.lblTitle.text = @"微辣";
    NSInteger index = indexPath.section;
    if (self.model.specs) {
        if (index == 0) {
            cell.lblTitle.text = self.model.specs.data[indexPath.row].name;
            
//            if ([self.model.specs.data[indexPath.row].stock isEqualToString:@"0"]) {
//                [cell setDisable];
//            } else {
                [cell setIsSelected: [self.model.specs.data[indexPath.row].id isEqualToString: _specs]];
//            }
        }
        
        index --;
    }
    
    if (index >= 0 && index < self.model.attribute[index].data.count) {
        cell.lblTitle.text = self.model.attribute[index].data[indexPath.row].value;
        [cell setIsSelected: [self.model.attribute[index].data[indexPath.row].key isEqualToString: _atts[index]]];
    }
    
    return cell;

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    FNFNGoodsSelectorTitle *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNFNGoodsSelectorTitle" forIndexPath:indexPath];

    NSInteger index = indexPath.section;
    if (self.model.specs) {
        if (index == 0) {
            [cell setTitle:self.model.specs.name];
        }
        
        index --;
    }
    
    if (index >= 0 && index < self.model.attribute[index].data.count) {
        [cell setTitle:self.model.attribute[index].name];
    }

    return cell;
}

#pragma mark - collectionView delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(JMScreenWidth, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    NSString* string = @"";
    NSInteger index = indexPath.section;
    if (self.model.specs) {
        if (index == 0) {
            string = self.model.specs.data[indexPath.row].name;
        }
        
        index --;
    }
    
    if (index >= 0 && index < self.model.attribute[index].data.count) {
        string = self.model.attribute[index].data[indexPath.row].value;
    }
    
    CGRect rect = [string boundingRectWithSize:(CGSizeMake(JMScreenWidth-30, 36)) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:kFONT13} context:nil];
    CGFloat width = rect.size.width+50;
    CGSize size = CGSizeMake(floor(width), 40);
    return size;

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger index = indexPath.section;
    if (self.model.specs) {
        if (index == 0) {
            
//            if (![self.model.specs.data[indexPath.row].stock kr_isNotEmpty] ||
//                [self.model.specs.data[indexPath.row].stock isEqualToString:@"0"]) {
//
//                //库存为0，不可点击
//
//            } else {
            
                _specs = self.model.specs.data[indexPath.row].id;
                _lblPrice.text = [NSString stringWithFormat: @"￥%@", self.model.specs.data[indexPath.row].price];
                [self updateCount];
//            }
        }
        
        index --;
    }
    
    if (index >= 0 && index < self.model.attribute[index].data.count) {
        _atts[index] = self.model.attribute[index].data[indexPath.row].key;
    }
    
    [self.clvAttributes reloadData];
}

- (void)show {
    [self layoutIfNeeded];
    self.hidden = NO;
    
    [_vAlert mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.mas_equalTo(556);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self setNeedsLayout];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)dismiss {
    
    [_vAlert mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.mas_equalTo(556);
        make.top.equalTo(self.mas_bottom);
    }];
    [self setNeedsLayout];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        self.hidden = YES;
    }];
}

- (void) onConfirmClick {
    
    for (NSString *att in _atts) {
        if (![att kr_isNotEmpty]) {
            [FNTipsView showTips:@"请选择规格"];
            
            return;
        }
    }
    
    if ([_delegate respondsToSelector:@selector(attributeAlertDidClick:specs:withKeys:)]) {
        [_delegate attributeAlertDidClick: _lblCount.text specs:_specs withKeys: _atts];
    }
}

- (void)setModel: (FNStoreGoodsModel*) model {
    _model = model;
    
    [_imgGoods sd_setImageWithURL: URL(model.goods_img)];
    _lblTitle.text = model.goods_title;
    _lblPrice.text = [NSString stringWithFormat: @"￥%@", model.goods_price];
    _lblCount.text = @"1";
    
    _specs = @"";
    if (model.specs && model.specs.data.count > 0) {
        _lblPrice.text = [NSString stringWithFormat: @"￥%@", self.model.specs.data[0].price];
        _specs = model.specs.data[0].id;
    }
    [_atts removeAllObjects];
    if (self.model.attribute && self.model.attribute.count > 0) {
//        _atts = [NSMutableArray arrayWithCapacity:self.model.attribute.count];
        for (NSInteger index = 0; index < self.model.attribute.count; index++) {
            [_atts addObject:@""];
        }
    }
    
    
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString: [NSString stringWithFormat: @"￥%@", model.goods_cost_price] attributes:attribtDic];
    
    _lblOPrice.attributedText = attribtStr;
    
    [self.clvAttributes reloadData];
}

- (void)onAddClick {
    int count = _lblCount.text.intValue;
    count ++;
    _lblCount.text = [NSString stringWithFormat:@"%d", count];
    [self updateCount];
}

- (void)onSubClick {
    int count = _lblCount.text.intValue;
    count --;
    _lblCount.text = [NSString stringWithFormat:@"%d", count];
    [self updateCount];
}

- (void)updateCount {
//    int stock = self.model.stock.intValue;
//    if (self.model.specs && self.model.specs.data.count > 0) {
//
//        for (FNStoreGoodsSpecDataModel *data in self.model.specs.data) {
//
//            if ([data.id isEqualToString:_specs]) {
//
//                stock = data.stock.intValue;
//            }
//        }
//    }
    int count = _lblCount.text.intValue;
    count = count < 1 ? 1 : count;
//    count = count > stock ? stock : count;
    _lblCount.text = [NSString stringWithFormat:@"%d", count];
}


@end
