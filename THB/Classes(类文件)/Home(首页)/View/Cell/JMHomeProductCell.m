//
//  JMHomeProductCell.m
//  THB
//
//  Created by jimmy on 2017/4/8.
//  Copyright © 2017年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */
#import "JMHomeProductCell.h"
#import "JMProgressView.h"
#import "DiscountLabel.h"
#import "FNBaseProductModel.h"
#define quanPadding 6
#define textPadding 5

@interface JMHomeProductCell ()
@end
@implementation JMHomeProductCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
    }
    return self;
}

#pragma mark - public, get instance
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    static NSString *reuseIdentifier = @"JMHomeProductCell";
    JMHomeProductCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[JMHomeProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.indexPath = indexPath;
    return cell;
}

-(void)initUI{
    //商品图片
    self.GoodsImage=[UIImageView new];
    self.GoodsImage.contentMode=UIViewContentModeScaleToFill;
    self.GoodsImage.image=IMAGE(@"APP底图.png");
    [self.contentView addSubview:self.GoodsImage];
    
    //商品分类图片
    self.GoodsTypeImage=[UIImageView new];
    self.GoodsTypeImage.contentMode=UIViewContentModeScaleToFill;
    self.GoodsTypeImage.cornerRadius=5;
    [self.contentView addSubview:self.GoodsTypeImage];
    
    //商品标题
    self.GoodsTitleLabel=[UILabel new];
    self.GoodsTitleLabel.numberOfLines=2;
    self.GoodsTitleLabel.textColor=FNBlackColor;
    self.GoodsTitleLabel.font=kFONT12;
    [self.contentView addSubview:self.GoodsTitleLabel];
    
    //券背景View
    self.discountsBgView=[UIView new];
    [self.contentView addSubview:self.discountsBgView];
    
    //券面额背景
    self.discountsView=[UIImageView new];
    self.discountsView.cornerRadius=2;
    [self.discountsBgView addSubview:self.discountsView];
    
    //券
    self.ticketImg=[UIImageView new];
    [self.discountsBgView addSubview:self.ticketImg];
    
    //券面值
    self.ticketPriceLable=[UILabel new];
    [self.ticketPriceLable sizeToFit];
    self.ticketPriceLable.textColor=FNColor(246, 71, 111);
    self.ticketPriceLable.font=kFONT12;
    [self.discountsBgView addSubview:self.ticketPriceLable];
    
    //下单文字背景
    self.placeAnorderView=[UIImageView new];
    //_placeAnorderView.image=[UIImage imageNamed:@"today_multiple"];
    [self.placeAnorderView sizeToFit];
    self.placeAnorderView.cornerRadius=2;
    [self.contentView addSubview:self.placeAnorderView];
    
    
    //下单标题
    self.placeAnOrderLable=[UILabel new];
    self.placeAnOrderLable.textColor=FNColor(246, 71, 111);
    self.placeAnOrderLable.font=kFONT12;
    self.placeAnOrderLable.textAlignment=NSTextAlignmentCenter;
    [self.placeAnOrderLable sizeToFit];
    [self.placeAnorderView addSubview:self.placeAnOrderLable];
    
    //券后价标题
    self.qhPriceTitleLabel = [UILabel new];
    self.qhPriceTitleLabel.textColor = FNMainGobalControlsColor;
    self.qhPriceTitleLabel.font = kFONT10;
    self.qhPriceTitleLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.qhPriceTitleLabel];
    
    //券后价
    self.qhPriceLabel = [UILabel new];
    self.qhPriceLabel.textColor = FNMainGobalControlsColor;
    self.qhPriceLabel.font = kFONT13;
    [self.contentView addSubview:self.qhPriceLabel];
    
    //分享
    self.shareBtn = [UIButton new];
    self.shareBtn.titleLabel.textAlignment=NSTextAlignmentRight;
    self.shareBtn.titleLabel.font = kFONT10;
    [self.shareBtn setTitleColor:FNColor(246, 71, 111) forState:UIControlStateNormal];
    [self.shareBtn sizeToFit];
    [self.contentView addSubview:self.shareBtn];
    
    //原价
    _originPriceLabel = [UILabel new];
    _originPriceLabel.textColor = FNGlobalTextGrayColor;
    _originPriceLabel.font = kFONT10;
    _originPriceLabel.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:self.originPriceLabel];
    
    //店铺icon
    self.shopIconImg=[UIImageView new];
    self.shopIconImg.contentMode=UIViewContentModeScaleToFill;
    [self.contentView addSubview:self.shopIconImg];
    
    //店铺名
    self.shopNameLabel = [UILabel new];
    self.shopNameLabel.textAlignment=NSTextAlignmentLeft;
    self.shopNameLabel.font = kFONT10;
    self.shopNameLabel.textColor = FNGlobalTextGrayColor;
    [self.contentView addSubview:self.shopNameLabel];
    
    //月销量
    self.countLabel = [UILabel new];
    self.countLabel.textAlignment=NSTextAlignmentRight;
    self.countLabel.font = kFONT10;
    self.countLabel.textColor = FNGlobalTextGrayColor;
    [self.contentView addSubview:self.countLabel];
    
    //热销图片
    self.countIconImg=[UIImageView new];
    self.countIconImg.contentMode=UIViewContentModeScaleToFill;
    [self.contentView addSubview:self.countIconImg];
    
    [self initializedSubviews];
}
#pragma mark - initializedSubviews
- (void)initializedSubviews {
    
    //商品图片
    //券背景视图
    
    CGFloat w = 120;//FNDeviceWidth/3;
    [self.GoodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.mas_equalTo(_jm_margin10);
        make.bottom.mas_equalTo(-_jmsize_10);
        make.width.mas_equalTo(w);
    }];
    
    
    //    //商品分类图片
    [self.GoodsTypeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.GoodsImage.mas_right).offset(_jmsize_10/2);
        make.top.mas_equalTo(_jm_margin10);
        make.width.equalTo(@23);
        make.height.equalTo(@13);
    }];
    
    //商品标题
    //    [self.GoodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(self.GoodsTypeImage.mas_right).offset(_jmsize_10/2);
    //        make.centerY.equalTo(self.GoodsTypeImage);
    //        make.right.equalTo(self.contentView.mas_right).offset(-5);
    //        make.height.equalTo(@20);
    //    }];
    self.GoodsTitleLabel
    .sd_layout
    .heightIs(20)
    .leftSpaceToView(self.GoodsTypeImage, 2)
    .rightSpaceToView(self.contentView, 0)
    .centerYEqualToView(self.GoodsTypeImage);
    
    //优惠Bg
    //    self.discountsBgView.sd_layout
    //    .leftEqualToView(self.GoodsTypeImage)
    //    .topSpaceToView(self.GoodsTypeImage, 5)
    //    .heightIs(15);
    //券logo
    //    self.ticketImg.sd_layout
    //    .leftSpaceToView(self.discountsView, 0)
    //    .topEqualToView(self.discountsView)
    //    .widthIs(17.5).heightIs(15);
    //券面额背景
    //    self.discountsView.sd_layout
    //    .topEqualToView(self.discountsBgView)
    //    .bottomEqualToView(self.discountsBgView)
    //    .leftSpaceToView(self.ticketImg, 0);
    //券面值
    //    self.ticketPriceLable
    //    .sd_layout
    //    .leftSpaceToView(self.ticketImg, 0)
    //    .topSpaceToView(self.discountsView, 0)
    //    .heightIs(15);
    
    //券背景视图
    [self.discountsBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.GoodsTypeImage.mas_right).offset(5);
        make.top.equalTo(self.GoodsTypeImage.mas_bottom).offset(_jm_margin10);
        make.height.equalTo(@15);
    }];
    
    //券
    [self.ticketImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@15);
        make.width.equalTo(@17.5);
    }];
    
    //优惠Bg
    [self.discountsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ticketImg.mas_right);
        make.top.equalTo(self.ticketImg.mas_top);
        make.height.equalTo(self.ticketImg);
        
    }];
    
    
    
    //券面值
    //    [self.ticketPriceLable sizeToFit];
    [self.ticketPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ticketImg.mas_right).offset(quanPadding);
        make.top.equalTo(self.ticketImg.mas_top);
        make.bottom.equalTo(self.ticketImg.mas_bottom);
    }];
    [self.ticketPriceLable setSingleLineAutoResizeWithMaxWidth:90];
    
    //下单文字背景
    [self.placeAnorderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.discountsView.mas_right).offset(10);
        make.top.equalTo(self.discountsBgView.mas_top);
        make.height.equalTo(self.discountsBgView);
        
    }];
    //下单标题
    [self.placeAnOrderLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(textPadding);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    [self.placeAnOrderLable setSingleLineAutoResizeWithMaxWidth:90];
    
    
    //分享
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.discountsView.mas_bottom).offset(_jm_margin10);
        make.right.equalTo(self.contentView).offset(-_jm_margin10);
        make.height.equalTo(@20);
        
    }];
    
    [self.shareBtn.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@20);
        make.right.equalTo(self.shareBtn.mas_right).offset(0);
        make.left.equalTo(self.shareBtn.imageView.mas_right).offset(5);
    }];
    [self.shareBtn.titleLabel setSingleLineAutoResizeWithMaxWidth:(90)];
    
    self.shareBtn.imageView.sd_layout.widthIs(15).heightIs(15).topSpaceToView(self.shareBtn, 2.5);
    
    
    //券后价标题
    self.qhPriceTitleLabel
    .sd_layout
    .leftSpaceToView(self.GoodsImage, 5)
    //.topSpaceToView(self.discountsBgView, _jmsize_10)
    .topEqualToView(self.shareBtn)
    .heightIs(20);
    
    
    [self.qhPriceTitleLabel setSingleLineAutoResizeWithMaxWidth:(60)];
    //券后价
    self.qhPriceLabel
    .sd_layout
    .leftSpaceToView(self.qhPriceTitleLabel, 5)
    //.topSpaceToView(self.discountsBgView, _jmsize_10)
    .topEqualToView(self.qhPriceTitleLabel)
    .heightIs(20);
    [self.qhPriceLabel setSingleLineAutoResizeWithMaxWidth:(100)];
    
    //店铺icon
    self.shopIconImg
    .sd_layout
    .widthIs(15)
    .heightIs(15)
    .leftSpaceToView(self.GoodsImage,5)
    .bottomSpaceToView(self.contentView, 15);
    //.topSpaceToView(self.originPriceLabel, 5)
    
    //店铺名
    self.shopNameLabel
    .sd_layout
    .topEqualToView(self.shopIconImg)
    .leftSpaceToView(self.shopIconImg, 5)
    .heightIs(15);
    [self.shopNameLabel setSingleLineAutoResizeWithMaxWidth:(120)];
    
    //原价
    self.originPriceLabel
    .sd_layout
    .leftSpaceToView(self.GoodsImage, 5)
    .bottomSpaceToView(self.shopIconImg, 10)
    .heightIs(20);
    [self.originPriceLabel setSingleLineAutoResizeWithMaxWidth:(150)];
    
    //月销量
    self.countLabel
    .sd_layout
    .heightIs(15)
    .topEqualToView(self.shopIconImg)
    .rightSpaceToView(self.contentView, _jmsize_10);
    [self.countLabel setSingleLineAutoResizeWithMaxWidth:(90)];
    
    //热销图片
    self.countIconImg
    .sd_layout
    .widthIs(15)
    .heightIs(15)
    .bottomSpaceToView(self.contentView, 15).rightSpaceToView(self.countLabel, 5);
    
    UILabel *lineLB=[UILabel new];
    lineLB.backgroundColor=FNColor(246, 246, 246);
    [self.contentView addSubview:lineLB];
    lineLB.sd_layout
    .heightIs(1).leftEqualToView(self.contentView).bottomEqualToView(self.contentView).rightEqualToView(self.contentView);
    
    
}
-(void)setModel:(FNBaseProductModel *)model{
    
    _model = model;
    
    if (model) {
        //商品图片
        [self.GoodsImage setUrlImg:model.goods_img];
        //商品来源
        [self.GoodsTypeImage setUrlImg:model.shop_img];
        NSLog(@"shop_img:%@",model.shop_img);
        //商品标题
        self.GoodsTitleLabel.text=model.goods_title;
        
        
        
        if([model.fxz kr_isNotEmpty]){
            if ([model.is_hide_sharefl isEqualToString:@"1"]) {
                _shareBtn.hidden = YES;
                
            }else{
                _shareBtn.hidden = NO;

            [_shareBtn sd_setImageWithURL:URL(model.share_img) forState:UIControlStateNormal];
            [_shareBtn setTitle:model.fxz forState:UIControlStateNormal];
            [_shareBtn addTarget:self action:@selector(shareBtnMethod)];
                //防止按钮位置多次偏移
//            [self.shareBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//
//                make.width.mas_equalTo(15+self.shareBtn.titleLabel.width+5);
//
//            }];
            }
            
        }else{
            _shareBtn.hidden = YES;
        }
        
        
        //优惠券logo
        [self.ticketImg setUrlImg:model.goods_quanfont_bjimg];
        //判断优惠券,没有就隐藏
        if ([model.yhq_span kr_isNotEmpty]&&![model.yhq_price isEqualToString:@"0"]) {
            self.discountsBgView.hidden = NO;
            _qhPriceTitleLabel.text= [FNBaseSettingModel settingInstance].app_quanhoujia_name;
            //优惠券金额
            self.ticketPriceLable.text=model.yhq_span;
            
            //优惠券金额字体颜色
            self.ticketPriceLable.textColor = [UIColor colorWithHexString:model.goodsyhqstr_color];

            //优惠券面额的背景，根据券价格的长度来计算券背景的宽度
            [_discountsView setUrlImg:model.goods_quanbj_bjimg];
            //券
            [self.ticketImg mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@0);
                make.top.equalTo(@0);
                make.height.equalTo(@15);
                make.width.equalTo(@17.5);
                
            }];
            [self.discountsView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.ticketImg.mas_right);
                make.top.equalTo(self.ticketImg.mas_top);
                make.height.equalTo(self.ticketImg);
                make.width.mas_equalTo(self.ticketPriceLable.width+quanPadding*2+2);
            }];
            
            [self.discountsBgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.GoodsImage.mas_right).offset(5);
                make.top.equalTo(self.GoodsTypeImage.mas_bottom).offset(_jm_margin10);
                make.height.equalTo(@15);
                make.width.mas_equalTo(self.ticketImg.width + self.discountsView.width);
                
            }];
        }else{
            //显示到手价标题
            _qhPriceTitleLabel.text=[FNBaseSettingModel settingInstance].app_daoshoujia_name;
            [self.discountsBgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(@0);
                
            }];
            [self.discountsView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(@0);
                
            }];
            
            [self.ticketImg mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(@0);
                
            }];
            
            self.discountsBgView.hidden = YES;
        }
        //返利样式
        NSInteger goods_flstyle=[[FNBaseSettingModel settingInstance].goods_flstyle integerValue ];
        [_placeAnorderView setUrlImg:model.goods_fanli_bjimg];
        //判断模式
        if([FNBaseSettingModel settingInstance].app_choujiang_onoff.boolValue){//判断是否是抽奖模式
            
            
            self.placeAnorderView.hidden = NO;
            _placeAnOrderLable.text=[NSString stringWithFormat:@"%@",[FNBaseSettingModel settingInstance].app_fanli_off_str];//抽奖模式文字
            
            [self.placeAnorderView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(self.discountsView).offset(self.discountsBgView.hidden?0:_jm_margin10);
                if (self.discountsBgView.hidden) {
                    make.left.equalTo(self.GoodsImage.mas_right).offset(5);
                } else {
                    make.left.equalTo(self.discountsView.mas_right).offset(self.discountsBgView.hidden?0:_jm_margin10);
                }
                make.top.equalTo(self.GoodsTypeImage.mas_bottom).offset(_jm_margin10);
                make.height.equalTo(self.discountsBgView);
                make.width.mas_equalTo(self.placeAnOrderLable.width+textPadding*2);
                
            }];
            
            
        }else{
            
            
            if (goods_flstyle == 0) {
                if ([model.fcommission kr_isNotEmpty]&&![model.fcommission isEqualToString:@"0"]) {
                    if ([model.is_hide_fl isEqualToString:@"1"]) {
                        self.placeAnorderView.hidden = YES;
                    }else{
                        self.placeAnorderView.hidden = NO;
                        _placeAnOrderLable.text=[NSString stringWithFormat:@"%@%@",model.fan_all_str,model.fcommission];//返回佣金
                        _placeAnOrderLable.textColor = [UIColor colorWithHexString:model.goodsfcommissionstr_color];
                        [self.placeAnorderView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                            make.left.equalTo(self.discountsView.mas_right).offset(self.discountsBgView.hidden?0:_jm_margin10);
                            if (self.discountsBgView.hidden) {
                                make.left.equalTo(self.GoodsImage.mas_right).offset(5);
                            } else {
                                make.left.equalTo(self.discountsView.mas_right).offset(self.discountsBgView.hidden?0:_jm_margin10);
                            }
                            
                            make.top.equalTo(self.GoodsTypeImage.mas_bottom).offset(_jm_margin10);
                            make.height.equalTo(self.discountsBgView);
                            make.width.mas_equalTo(self.placeAnOrderLable.width+textPadding*2);
                            
                        }];
                    }
                }else{
                    self.placeAnorderView.hidden = YES;
                }
            }else{
                self.placeAnorderView.hidden = YES;
            }
        }
        
        //券后价
        _qhPriceLabel.text=[NSString stringWithFormat:@"¥ %@",model.goods_price];
        //原价
        _originPriceLabel.text=[NSString stringWithFormat:@"%@价¥ %@",model.shop_type,model.goods_cost_price];
        //热销图片
        [_countIconImg setUrlImg:model.goods_sales_ico];
        
        if (goods_flstyle==0 || goods_flstyle==1) {
            //热销
            _countLabel.text=[NSString stringWithFormat:@"热销 %@",model.goods_sales];//@"热销5111";
        }else{
            _countLabel.text=[NSString stringWithFormat:@"%@人已买",model.goods_sales];//@"热销5111";
        }
        // 店铺Icon;
        [_shopIconImg setUrlImg:model.goods_store_img];
        //店铺名字
        _shopNameLabel.text=[NSString stringWithFormat:@"%@ %@",model.shop_title,model.provcity];
        
        if ([model.shop_title kr_isNotEmpty]) {
            _shopIconImg.hidden=NO;
            _shopNameLabel.hidden=NO;
        }else{
            _shopIconImg.hidden=YES;
            _shopNameLabel.hidden=YES;
            
        }
        
        
    }
    
    //[self.contentView setNeedsLayout];
    
    
}
//分享赚点击方法
-(void)shareBtnMethod{
    
    if (self.sharerightNow) {
        self.sharerightNow(self.model);
    }
}

@end
