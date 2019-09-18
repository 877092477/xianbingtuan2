//
//  ProductCollectionViewCell.m
//  THB
//
//  Created by zhongxueyu on 16/4/1.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有 2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "ProductCollectionViewCell.h"

@implementation ProductCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //加边框
//        self.contentView.layer.borderWidth = 0.2;
//        self.contentView.layer.borderColor = [UIColor grayColor].CGColor;

        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(1, 1, CGRectGetWidth(self.frame)-2, CGRectGetWidth(self.frame)-2)];
        //        self.imgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//        self.imgView.alpha = 0.f;
//        
//        // 执行动画
//        [UIView animateWithDuration:IMGDuration animations:^{
//            self.imgView.alpha = 1.f;
//        }];
        [self addSubview:self.imgView];
        
       
        
        self.goodsTitle = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.imgView.frame)+5, CGRectGetWidth(self.frame)-10, 40)];
        self.goodsTitle.lineBreakMode = NSLineBreakByWordWrapping;
        self.goodsTitle.numberOfLines = 2;
        self.goodsTitle.text = @"2016春季韩版甜美吊带背心连衣裙+仿貂绒百搭开衫两件套套装";
        self.goodsTitle.font = kFONT14;
        self.goodsTitle.textAlignment = NSTextAlignmentLeft;
//        self.goodsTitle.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:self.goodsTitle];
        CGFloat midLableY = CGRectGetMaxY(self.goodsTitle.frame);
        
        self.price = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_goodsTitle.frame), midLableY, 0 , 21)];
        self.price.font = kFONT14;
        self.price.text = @"￥39.0";
        self.price.textColor = [UIColor blackColor];
        self.price.textAlignment = NSTextAlignmentLeft;
        self.price.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:self.price];
        
        self.shopImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 6, 18, 10)];
        [self.goodsTitle addSubview:self.shopImgView];
        
        _oldPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_price.frame)+2,midLableY, 80, 21)];
        _oldPriceLabel.text = @"4.9";
        _oldPriceLabel.textColor = [UIColor grayColor];
        _oldPriceLabel.font = kFONT13;
        _oldPriceLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_oldPriceLabel];
        
        CGFloat bottomLableY;
        bottomLableY = CGRectGetMaxY(_price.frame);
        _sales = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_goodsTitle.frame),bottomLableY, 120, 21)];
        _sales.text = @"月销100";
        _sales.textColor = [UIColor grayColor];
        _sales.font = kFONT13;
        _sales.textAlignment = NSTextAlignmentLeft;
        _sales.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_sales];
        [_sales autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:5];
        [_sales autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:5];
        [_sales autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:5];
        [_sales autoSetDimension:(ALDimensionHeight) toSize:16];
        
        _likeBtn=[[CatZanButton alloc] initWithFrame:CGRectMake(self.frame.size.width-24,bottomLableY, 17, 15)];
//        [self.contentView addSubview:_likeBtn];
        [_likeBtn setType:CatZanButtonTypeFirework];
        __block ProductCollectionViewCell *controller = self;
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
        
        [_couponview autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:_sales];
        [_couponview autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeTop) ofView:_sales withOffset:-5];
        
      self.couponViewH = [_couponview autoSetDimension:(ALDimensionHeight) toSize:_couponImg.height];
        [_couponview autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jm_margin10];
        
        [_couponImg autoSetDimensionsToSize:_couponImg.size];
        [_couponImg autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        [_couponImg autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        
        [_couponBtn autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:_couponImg];
        [_couponBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [_couponBtn autoSetDimension:(ALDimensionHeight) toSize:_couponImg.height];
        [_couponBtn autoSetDimension:(ALDimensionWidth) toSize:(FNDeviceWidth-_jm_margin10*2) relation:(NSLayoutRelationLessThanOrEqual)];
        
        [self.price autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeLeft) ofView:self.couponview];
        [self.price autoPinEdge:(ALEdgeBottom) toEdge:(ALEdgeTop) ofView:self.couponview];
        [self.price autoSetDimension:(ALDimensionWidth) toSize:((FNDeviceWidth-20)*0.5-10)*0.5];

        [_oldPriceLabel autoPinEdge:(ALEdgeLeft) toEdge:(ALEdgeRight) ofView:self.price];
        [_oldPriceLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:self.price];
        [_oldPriceLabel autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:5];
    }
    return self;
}

-(void)addMyLikeMethod:(NSString *)goodsId{
    NSMutableDictionary* param = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],
                                                                                 @"goodsid":goodsId,
                                                                                 @"token":UserAccessToken           }];
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
                                                                                 @"token":UserAccessToken            }];
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

-(void)setModel:(FNBaseProductModel *)model{
    _model = model;
    [self.imgView setUrlImg:model.goods_img];
    
    NSString *pricestrValue=[NSString stringWithFormat:@"%0.2f", [model.goods_price floatValue]];
    
    self.price.text = [NSString stringWithFormat:@"￥%@",pricestrValue];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f",[model.fcommission floatValue]]];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:[NSString stringWithFormat:@"%.2f",[model.fcommission floatValue]]].location, [[noteStr string] rangeOfString:[NSString stringWithFormat:@"%.2f",[model.fcommission floatValue]]].length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:RED range:redRange];
    [noteStr addAttribute:NSFontAttributeName value:kFONT14 range:redRange];
    
    //中划线
    NSString *oldpricestrValue = [NSString stringWithFormat:@"￥%0.2f", [model.goods_cost_price floatValue]];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:oldpricestrValue attributes:attribtDic];
    self.oldPriceLabel.attributedText = attribtStr;
    
    self.sales.text = [NSString stringWithFormat:@"月销量%@",model.goods_sales];
    self.likeBtn.goodsId = model.ID;
    if ([model.shop_type isEqualToString:@"淘宝"]) {
        self.shopImgView.image = IMAGE(@"");
        self.goodsTitle.text = model.goods_title;
    }else if ([model.shop_type isEqualToString:@"天猫"]){
        self.goodsTitle.text = [NSString stringWithFormat:@"     %@",model.goods_title];
        self.shopImgView.image = IMAGE(@"Tmall");
    }else if ([model.shop_id isEqualToString:@"3"]){
        self.goodsTitle.text = [NSString stringWithFormat:@"     %@",model.goods_title];
        self.shopImgView.image = IMAGE(@"JD");
    }
    if (model.is_mylike == 0) {
        self.likeBtn.isZan = NO;
    }else{
        self.likeBtn.isZan = YES;
    }
    
    
    [_couponBtn setTitle:[NSString stringWithFormat:@"  %@  ",_model.yhq_span] forState:UIControlStateNormal];
    if ([_model.yhq isEqualToString:@"1"] || _model.yhq.integerValue == 1) {
      
        self.couponview.hidden = NO;
        self.couponViewH.constant  = self.couponImg.height;
    }else{
        self.couponview.hidden = YES;
        self.couponViewH.constant  = 8;
    }
}
@end
