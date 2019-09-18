//
//  FNheatProductNCell.m
//  THB
//
//  Created by 李显 on 2018/9/10.
//  Copyright © 2018年 方诺科技. All rights reserved.
//
//
#import "FNheatProductNCell.h"
#define quanPadding 6
#define textPadding 5
@implementation FNheatProductNCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"HeatCell";
    FNheatProductNCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    return cell;
}


-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}


-(void)initUI{
    
    //商品图片
    self.GoodsImage=[UIImageView new];
    _GoodsImage.contentMode=UIViewContentModeScaleToFill;
    _GoodsImage.userInteractionEnabled = YES;
    [self.contentView addSubview:self.GoodsImage];
    
    
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
    self.ticketPriceLable.textColor=FNColor(246, 71, 111);
    self.ticketPriceLable.font=kFONT12;
    [self.discountsBgView addSubview:self.ticketPriceLable];
    
    //下单文字背景
    self.placeAnorderView=[UIImageView new];
    self.placeAnorderView.image=[UIImage imageNamed:@"today_multiple"];
    self.placeAnorderView.cornerRadius=2;
    [self.contentView addSubview:self.placeAnorderView];
    
    //下单标题
    self.placeAnOrderLable=[UILabel new];
    self.placeAnOrderLable.textColor=FNColor(246, 71, 111);
    self.placeAnOrderLable.font=kFONT12;
    self.placeAnOrderLable.textAlignment=NSTextAlignmentCenter;
    [self.placeAnorderView addSubview:self.placeAnOrderLable];
    
   
    //原价
    self.originPriceLabel = [UILabel new];
    self.originPriceLabel.textColor = FNGlobalTextGrayColor;
    self.originPriceLabel.font = kFONT12;
    [self.contentView addSubview:self.originPriceLabel];
    
   
    
    
    [self initializedSubviews];
    
}
#pragma mark - initializedSubviews
- (void)initializedSubviews {
    
    
    
    
    //商品图片
    [self.GoodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.equalTo(self.GoodsImage.mas_width);
    }];
    
   
    
    //商品标题
    [self.GoodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(2);
        make.top.equalTo(self.GoodsImage.mas_bottom).offset(0);
        make.right.equalTo(@0);
        make.height.equalTo(@15);
        
    }];
    
    //券背景视图
    [self.discountsBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.top.equalTo(self.GoodsTitleLabel.mas_bottom).offset(5);
        make.height.equalTo(@15);
    }];
    
    
    //优惠Bg
    [self.discountsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@15);
    }];
    
    //券面值
    [self.ticketPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.discountsView.mas_left).offset(2);
        make.top.equalTo(self.discountsView.mas_top);
        make.bottom.equalTo(self.discountsView.mas_bottom);
    }];
    [self.ticketPriceLable setSingleLineAutoResizeWithMaxWidth:90];
    
    //下单文字背景
    [self.placeAnorderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.discountsView.mas_right).offset(_jm_margin10);
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
    
    //原价
    self.originPriceLabel.sd_layout
    .leftSpaceToView(self.contentView, 5)
    .bottomSpaceToView(self.contentView, 5)
    .heightIs(15);
    [self.originPriceLabel setSingleLineAutoResizeWithMaxWidth:90];

    
}

-(void)setModel:(FNBaseProductModel *)model{
    _model = model;
    NSLog(@"商品名字:%@",model.goods_title);
    if (model) {
        
        //商品图片
        [self.GoodsImage setUrlImg:model.goods_img];
        
       
        //商品标题
        self.GoodsTitleLabel.text=model.goods_title;
        
        NSString *priceTitle=@"";
        
        
        //判断优惠券,没有就隐藏
        if ([model.yhq_span kr_isNotEmpty]&&![model.yhq_price isEqualToString:@"0"]) {
           
            priceTitle=[FNBaseSettingModel settingInstance].app_quanhoujia_name;
            
            self.discountsBgView.hidden = NO;
           
            //优惠券金额
            self.ticketPriceLable.text=model.yhq_span;
            //优惠券金额字体颜色
            self.ticketPriceLable.textColor = [UIColor colorWithHexString:model.goodsyhqstr_color];
            
            
            //优惠券面额的背景，根据券价格的长度来计算券背景的宽度
            [_discountsView setUrlImg:model.goods_quanbj_bjimg];
            
            [self.discountsView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@0);
                make.top.equalTo(@0);
                make.height.equalTo(@15);
                make.width.mas_equalTo(self.ticketPriceLable.width+2*2+2);
                
            }];
            
            [self.discountsBgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@5);
                make.top.equalTo(self.GoodsTitleLabel.mas_bottom).offset(5);
                make.height.equalTo(@15);
                make.width.mas_equalTo(self.ticketImg.width + self.discountsView.width+2);
                
            }];
            
        }else{
            //显示到手价标题
             priceTitle=[FNBaseSettingModel settingInstance].app_daoshoujia_name;
            [self.discountsBgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(@0);
                
            }];
            [self.discountsView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(@0);
                
            }];
            
            self.discountsBgView.hidden = YES;
            
        }
        
        //什么价
        self.originPriceLabel.text=[NSString stringWithFormat:@"%@¥ %@",priceTitle,model.goods_price];//原价
        //优惠券金额字体颜色
        self.originPriceLabel.textColor = [UIColor colorWithHexString:model.goodsyhqstr_color];
        
        //返利样式
        NSInteger goods_flstyle=[[FNBaseSettingModel settingInstance].goods_flstyle integerValue ];
        [_placeAnorderView setUrlImg:model.goods_fanli_bjimg];
        
        //判断模式
        if([FNBaseSettingModel settingInstance].app_choujiang_onoff.boolValue){//判断是否是抽奖模式
            self.placeAnorderView.hidden = NO;
            
            _placeAnOrderLable.text=[NSString stringWithFormat:@"%@",[FNBaseSettingModel settingInstance].app_fanli_off_str];//抽奖模式文字
            [self.placeAnorderView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.discountsView.mas_right).offset(self.discountsBgView.hidden?0:_jm_margin10);
                make.top.equalTo(self.discountsBgView.mas_top);
                make.height.equalTo(self.discountsBgView);
                make.width.mas_equalTo(self.placeAnOrderLable.width+textPadding*2);
                
            }];
            
        }else{
            // goods_flstyle:0.有返利样式，1.无返利样式
            if (goods_flstyle == 0) {
                if ([model.fcommission kr_isNotEmpty]&&![model.fcommission isEqualToString:@"0"]) {
                    if ([model.is_hide_fl isEqualToString:@"1"]) {
                        self.placeAnorderView.hidden = YES;
                        
                    }else{
                        
                        self.placeAnorderView.hidden = NO;
                        _placeAnOrderLable.text=[NSString stringWithFormat:@"%@%@",model.fan_all_str,model.fcommission];//返回佣金
                        _placeAnOrderLable.textColor = [UIColor colorWithHexString:model.goodsfcommissionstr_color];
                        
                        [self.placeAnorderView mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.left.equalTo(self.discountsView.mas_right).offset(self.discountsBgView.hidden?0:_jm_margin10);
                            make.top.equalTo(self.discountsBgView.mas_top);
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
    }
    
    [self.contentView setNeedsLayout];
}


 
@end
