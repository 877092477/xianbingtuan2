//
//  FNBrandShopCell.m
//  THB
//
//  Created by jimmy on 2017/5/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNBrandShopCell.h"
#import "FNBrandShopModel.h"
static NSString* const _brand_rebate_title = @"最高返";
@interface FNBrandShopProCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView* proImgView;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UILabel* couponLabel;
@end
@implementation FNBrandShopProCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    _proImgView = [UIImageView new];
    _proImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_proImgView];
    
    _desLabel = [UILabel new];
    _desLabel.font = kFONT14;
    _desLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_desLabel];
    
    _couponLabel = [UILabel new];
    _couponLabel.font = kFONT14;
    _couponLabel.textColor = FNMainGobalControlsColor;
    _couponLabel.textAlignment  = NSTextAlignmentCenter;
    [self.contentView addSubview:_couponLabel];
    
    
    // layout
    [_proImgView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(5, 5, 5, 5)) excludingEdge:(ALEdgeBottom)];
    [_proImgView autoMatchDimension:(ALDimensionHeight) toDimension:(ALDimensionWidth) ofView:_proImgView];
    
    [_desLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:5];
    [_desLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:5];
    [_desLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_proImgView withOffset:_jm_margin10*0.5];
    
    [_couponLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_desLabel withOffset:_jm_margin10*0.5];
    [_couponLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_margin10*0.5];
    [_couponLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_margin10*0.5];
    
}
//class method: get cell instance
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNBrandShopProCell";
    FNBrandShopProCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}

@end
@interface FNBrandShopCell ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, strong) UIImageView* shopImgView;

@property (nonatomic, strong) UIView* centerView;
@property (nonatomic, strong) UIImageView* todayNew;
@property (nonatomic, strong) UILabel* shopnameLabel;
@property (nonatomic, strong) UILabel* desLabel;
@property (nonatomic, strong) UIButton* rebateBtn;

@property (nonatomic, strong) UIView* couponView;

@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) NSLayoutConstraint* collectionViewConsH;

@end
@implementation FNBrandShopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{

    [self setUpShopImgView];
    [_shopImgView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero) excludingEdge:(ALEdgeBottom)];
    [_shopImgView autoSetDimension:(ALDimensionHeight) toSize:0.35*FNDeviceWidth];
//    [_shopImgView autoMatchDimension:(ALDimensionHeight) toDimension:(ALDimensionWidth) ofView:_shopImgView withOffset:0.1];
    
    UICollectionViewFlowLayout*  layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset= UIEdgeInsetsZero;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:(CGRectZero) collectionViewLayout:layout];
    _collectionView.backgroundColor = FNWhiteColor;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.userInteractionEnabled = NO;
    _collectionView.scrollEnabled = NO;
    [self.contentView addSubview:_collectionView];
    [_collectionView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [_collectionView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    [_collectionView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_shopImgView];
    self.collectionViewConsH = [_collectionView autoSetDimension:(ALDimensionHeight) toSize:0];
    
    [_collectionView registerClass:[FNBrandShopProCell class] forCellWithReuseIdentifier:@"FNBrandShopProCell"];
    
    
}
- (void)setUpShopImgView{
    _shopImgView = [UIImageView new];
    _shopImgView.backgroundColor = FNHomeBackgroundColor;
    [self.contentView addSubview:_shopImgView];
    
    
    _centerView = [UIView new];
    _centerView.backgroundColor = [FNWhiteColor colorWithAlphaComponent:0.5];
    _centerView.cornerRadius = 5;
    [_shopImgView addSubview:_centerView];
    
    _todayNew = [UIImageView new];
    _todayNew.image = IMAGE(@"brand_today_new");
    [_todayNew sizeToFit];
    [_centerView addSubview:_todayNew];
    
    _shopnameLabel = [UILabel new];
    _shopnameLabel.font = [UIFont boldSystemFontOfSize:14];
    _shopnameLabel.textAlignment = NSTextAlignmentCenter;
    [_centerView addSubview:_shopnameLabel];
    
    _desLabel = [UILabel new];
    _desLabel.font = kFONT14;
    _desLabel.textAlignment = NSTextAlignmentCenter;
    [_centerView addSubview:_desLabel];
    
    _couponView = [UIView new];
    [_centerView addSubview:_couponView];
    
    _rebateBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_rebateBtn setTitleColor:FNMainGobalControlsColor forState:UIControlStateNormal];
    _rebateBtn.titleLabel.font = kFONT14;
    [_centerView addSubview:_rebateBtn];
    
    
    [_centerView autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionWidth) ofView:_shopImgView withMultiplier:0.65];
    [_centerView autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
    [_centerView autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [_todayNew autoSetDimensionsToSize:_todayNew.size];
    [_todayNew autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:0];
    [_todayNew autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
    
    [_shopnameLabel autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:_todayNew.height];
    [_shopnameLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_margin10];
    [_shopnameLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_margin10];
    
    [_desLabel autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_shopnameLabel withOffset:5];
    [_desLabel autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:_jm_margin10];
    [_desLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_margin10];
    
    [_couponView autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_desLabel withOffset:5];
    [_couponView autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:5];
    [_couponView autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:5];
    [_couponView autoSetDimension:(ALDimensionHeight) toSize:34];
    
    [_rebateBtn autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_desLabel withOffset:5];
    [_rebateBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:5];
    [_rebateBtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:5];
    [_rebateBtn autoSetDimension:(ALDimensionHeight) toSize:34];
    
    [_centerView autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:_couponView];
    
}
#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNBrandShopCell";
    FNBrandShopCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[FNBrandShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}


#pragma mark - Collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.shop_goods.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNBrandShopProCell* cell = [FNBrandShopProCell cellWithCollectionView:collectionView atIndexPath:indexPath];;
    [cell.proImgView setUrlImg:self.model.shop_goods[indexPath.item].goods_img];
    cell.desLabel.text =  self.model.shop_goods[indexPath.item].goods_title;
    if (self.model.shop_goods[indexPath.item].yhq_price == nil ||self.model.shop_goods[indexPath.item].yhq_price.floatValue ==0) {
          cell.couponLabel.text =  [NSString stringWithFormat:@"到手价¥%@",self.model.shop_goods[indexPath.item].qh_money ?:@"0.00"];
    } else {
        cell.couponLabel.text =  self.model.shop_goods[indexPath.item].qh_money ?[NSString stringWithFormat:@"¥%@",self.model.shop_goods[indexPath.item].qh_money ]:@"¥ 0.00";
        [cell.couponLabel addAttchmentImage:IMAGE(@"brand_after_quan") andBounds:(CGRectMake(0, -3, 30, 16.25)) atIndex:0];
    }
  
    
    
    return cell;
}

#pragma mark -  Collection view delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = floorf(FNDeviceWidth/3.0);
    CGFloat height = width + 15 * 2 +10*2;
    CGSize size = CGSizeMake(floorf(FNDeviceWidth/3.0), height);
    return size;
}


#pragma mark -  override
- (void)setModel:(FNBrandShopModel *)model{
    _model = model;
    if (_model) {
        [_shopImgView setUrlImg:_model.banner];
        _shopnameLabel.text = _model.name;
        _desLabel.text = _model.info;
        [_rebateBtn setTitle:[NSString stringWithFormat:@"%@%@%%",_brand_rebate_title,_model.returnbili] forState:UIControlStateNormal];
        _todayNew.hidden = _model.day_new;
        
        if (_model.shop_goods.count == 0) {
            self.collectionViewConsH.constant = 0;
        }else{
            CGFloat width = floorf(FNDeviceWidth/3.0);
            CGFloat height = width + 15 * 2 +10*2;
            self.collectionViewConsH.constant = height;
            [self.collectionView layoutIfNeeded];
            [self.collectionView reloadData];
        }
        
        if ( _model.is_yhq.boolValue == YES) {
            _couponView.hidden = NO;
            _rebateBtn.hidden = YES;
            if (_couponView.subviews.count > 0) {
                [_couponView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            }
            CGFloat width = (FNDeviceWidth*0.65-15)/2;
            [_model.shop_yhq enumerateObjectsUsingBlock:^(JMShop_yhq * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx <= 1) {
                    UIButton* button = [UIButton buttonWithType:(UIButtonTypeCustom)];
                    button.userInteractionEnabled = NO;
                    [button setBackgroundImage:IMAGE(@"brand_quan") forState:UIControlStateNormal];
                    button.titleLabel.adjustsFontSizeToFitWidth = YES;
                    button.titleLabel.font = kFONT12;
                    [button setTitle:obj.yhq_span forState:UIControlStateNormal];
                    [_couponView addSubview:button];
                    if (_model.shop_yhq.count == 1) {
                        [button autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:5];
                        [button autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:5];
                        [button autoAlignAxisToSuperviewAxis:(ALAxisVertical)];
                        [button autoSetDimension:(ALDimensionWidth) toSize:width];
                    }else{
                        [button autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:5];
                        [button autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:5];
                        [button autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:idx*width + (idx)*5];
                        [button autoSetDimension:(ALDimensionWidth) toSize:width];
                    }

                }
                
            }];
        }else{
            _couponView.hidden = YES;
            _rebateBtn.hidden = NO;
        }
    }
}
@end
