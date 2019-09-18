//
 //  ProductCell.m
//  THB
//
//  Created by zhongxueyu on 16/4/1.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "ProductCell.h"
#define Margin 10

@interface ProductCell ()
@property (nonatomic, strong)UIView* couponview;
@property (nonatomic, weak)UIImageView* couponImg;
@property (nonatomic, weak)UIButton* couponBtn;

@end
@implementation ProductCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}
- (UIImageView *)productImg{
    if (_productImg == nil) {
        _productImg = [UIImageView new];
        _productImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return  _productImg;
}
- (void)setupViews{
    [self.contentView addSubview:self.productImg];
    [self.productImg autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsMake(5, 5, 5, 5))excludingEdge:(ALEdgeRight)];
    [self.productImg autoMatchDimension:(ALDimensionWidth) toDimension:(ALDimensionHeight) ofView:self.productImg];
    
    self.productImg.alpha = 0.f;
    
    // 执行动画
    [UIView animateWithDuration:IMGDuration animations:^{
        self.productImg.alpha = 1.f;
    }];
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_productImg.frame)+Margin, 0, XYScreenWidth-CGRectGetWidth(_productImg.frame)-20, 40)];
    
    
    
    _title.numberOfLines = 2;
    _title.lineBreakMode = NSLineBreakByWordWrapping;
    _title.text = @"2016春季韩版甜美吊带背心连衣裙+仿貂绒百搭开衫两件套套装";
    
    CGSize size = [_title sizeThatFits:CGSizeMake(_title.frame.size.width, MAXFLOAT)];
    
    _title.frame =CGRectMake(CGRectGetMaxX(_productImg.frame)+Margin, 0, XYScreenWidth-CGRectGetWidth(_productImg.frame)-20, size.height);
    
    _title.font =kFONT14;
    
    [self.contentView addSubview:_title];
    [_title autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.productImg withOffset:_jmsize_10];
    [_title autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeTop) ofView:self.productImg];
    [_title autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10];
    
    self.shopImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 3, 18, 10)];
    [self.title addSubview:self.shopImgView];
    
    
    CGFloat bottonLableY = self.contentView.size.height-18;
    _price = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_title.frame),CGRectGetMaxY(_title.frame)+5, 50, 21)];
    _price.text = @"￥24.9";
    _price.textAlignment = NSTextAlignmentLeft;
    _price.textColor = [UIColor blackColor];
    _price.adjustsFontSizeToFitWidth = YES;
    _price.font = kFONT13;
    [self.contentView addSubview:_price];
    [_price autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:_title];
    [_price autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:_title withOffset:5];
    
    _oldPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_price.frame)+3,CGRectGetMinY(_price.frame), CGRectGetWidth(self.contentView.frame)-CGRectGetMaxX(_price.frame)+2, 21)];
    _oldPriceLabel.text = @"4.9";
    _oldPriceLabel.textColor = [UIColor grayColor];
    _oldPriceLabel.font = kFONT13;
    _oldPriceLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_oldPriceLabel];
    [_oldPriceLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_price withOffset:3];
    [_oldPriceLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:_price];
    
    _sales = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_title.frame),bottonLableY, 120, 21)];
    _sales.text = @"月销100";
    _sales.textColor = [UIColor grayColor];
    _sales.font = kFONT13;
    _sales.textAlignment = NSTextAlignmentLeft;
    _sales.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_sales];
    [_sales autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:_title];
    [_sales autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeBottom) ofView:self.productImg];
    
    _likeBtn=[[CatZanButton alloc] initWithFrame:CGRectMake(XYScreenWidth-28,bottonLableY, 17, 15)];
    //    [self.contentView addSubview:_likeBtn];
    [_likeBtn setType:CatZanButtonTypeFirework];
    __block ProductCell *controller = self;
    [_likeBtn setClickHandler:^(CatZanButton *zanButton) {
        if (zanButton.isZan) {
            NSLog(@"like tag is %@",zanButton.goodsId);
            if ([UserAccessToken kr_isNotEmpty]) {
                if (zanButton.goodsId) {
                    [controller addMyLikeMethod:zanButton.goodsId];
                }
                
            }else{
                [FNTipsView showTips:@"登录之后才可以喜欢商品"];
                zanButton.isZan = NO;
            }
            
            
        }else{
            NSLog(@"Cancel like!");
            if ([UserAccessToken kr_isNotEmpty]) {
                if (zanButton.goodsId) {
                    [controller deleteMyLikeMethod:zanButton.goodsId];
                }
                
            }else{
                [FNTipsView showTips:@"登录之后才可以删除商品"];
                zanButton.isZan = NO;
            }
            
            
        }
    }];
    
    
    
    //
    _couponview = [UIView new];
    [self.contentView addSubview:_couponview];
    
    
    UIImageView* couponImg = [[UIImageView alloc]init];
    couponImg.image = IMAGE(@"quan0");
    [couponImg sizeToFit];
    [_couponview addSubview:couponImg];
    _couponImg = couponImg;
    
    
    UIButton * couponBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    couponBtn.userInteractionEnabled = NO;
    [couponBtn setBackgroundImage:IMAGE(@"quan2")  forState:UIControlStateNormal];
    couponBtn.titleLabel.font = kFONT12;
    [_couponview addSubview:couponBtn];
    _couponBtn = couponBtn;
    
    
    [_couponview autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.price];
    [_couponview autoPinEdge:(ALEdgeTop) toEdge:(ALEdgeBottom) ofView:self.price withOffset:0];
    [_couponview autoSetDimension:(ALDimensionHeight) toSize:_couponImg.height];
    [_couponview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_margin10];
    
    [_couponImg autoSetDimensionsToSize:_couponImg.size];
    [_couponImg autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
    [_couponImg autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    
    [_couponBtn autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_couponImg];
    [_couponBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
    [_couponBtn autoSetDimension:(ALDimensionHeight) toSize:_couponImg.height];
    [_couponBtn autoSetDimension:(ALDimensionWidth) toSize:(FNDeviceWidth-_couponImg.width - 88 -_jm_margin10*3) relation:(NSLayoutRelationLessThanOrEqual)];
    
    
}

-(void)addMyLikeMethod:(NSString *)goodsId{
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                                 @"goodsid":goodsId,
                                                                                 @"token":UserAccessToken                        }];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_home_addmylike successBlock:^(id responseBody) {
        NSDictionary *dict = responseBody;
        XYLog(@"responseBody is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            
            [FNTipsView showTips:XYAddLikeMsg];
        }else {
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
        
    } failureBlock:^(NSString *error) {
        _likeBtn.isZan = NO;
        [XYNetworkAPI cancelAllRequest];
    }];
    
}

-(void)deleteMyLikeMethod:(NSString *)goodsId{
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                                 @"goodsid":goodsId,
                                                                                 @"token":UserAccessToken                        }];
    param[SignKey] = [NSString getSignStringWithDictionary:param];
    [SVProgressHUD show];
    [[XYNetworkAPI sharedManager] postResultWithParameter:param url:_api_home_deletemylike successBlock:^(id responseBody) {
        NSDictionary *dict = responseBody;
        XYLog(@"responseBody is %@",responseBody);
        if ([NSString checkIsSuccess:dict[XYSuccess] andElement:@"1"]) {
            
            [FNTipsView showTips:XYDeleteLikeMsg];
        }else {
            [XYNetworkAPI queryFinishTip:dict];
            [XYNetworkAPI cancelAllRequest];
        }
        
    } failureBlock:^(NSString *error) {
        _likeBtn.isZan = YES;
        [XYNetworkAPI cancelAllRequest];
    }];
    
}

-(void)cellWillDisplay{
    
}
-(void)setModel:(FNBaseProductModel *)model{
    _model =model;
    [self.productImg setUrlImg:model.goods_img];
    
    self.title.text = model.goods_title;
    NSString *pricestrValue=[NSString stringWithFormat:@"%0.2f", [model.goods_price floatValue]];
    self.price.text = [NSString stringWithFormat:@"￥%@",pricestrValue];
    
    //中划线
    NSString *oldpricestrValue = [NSString stringWithFormat:@"￥%0.2f", [model.goods_cost_price floatValue]];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:oldpricestrValue attributes:attribtDic];
    self.oldPriceLabel.attributedText = attribtStr;
    
    self.sales.text = [NSString stringWithFormat:@"月销量%@",model.goods_sales];
    if ([model.shop_type isEqualToString:@"淘宝"]) {
        self.shopImgView.image = IMAGE(@"");
        self.title.text = model.goods_title;
    }else if ([model.shop_type isEqualToString:@"天猫"]){
        self.title.text = [NSString stringWithFormat:@"     %@",model.goods_title];
        self.shopImgView.image = IMAGE(@"Tmall");
    }else if ([model.shop_id isEqualToString:@"3"]){
        self.title.text = [NSString stringWithFormat:@"     %@",model.goods_title];
        self.shopImgView.image = IMAGE(@"JD");
        
    }
    self.likeBtn.goodsId = model.ID;
    if (model.is_mylike == 0) {
        self.likeBtn.isZan = NO;
    }else{
        self.likeBtn.isZan = YES;
    }
    
    [_couponBtn setTitle:[NSString stringWithFormat:@"  %@  ",_model.yhq_span] forState:UIControlStateNormal];
    if (![NSString checkIsSuccess:_model.yhq andElement:@"1"]) {
        self.couponview.hidden = YES;

    }else{
        self.couponview.hidden = NO;
    }
}

#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    static NSString *reuseIdentifier = @"ProductCell";
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[ProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}
@end
