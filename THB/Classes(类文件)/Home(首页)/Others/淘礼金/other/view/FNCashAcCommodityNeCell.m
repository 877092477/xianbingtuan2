//
//  FNCashAcCommodityNeCell.m
//  THB
//
//  Created by Jimmy on 2018/10/23.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNCashAcCommodityNeCell.h"

@implementation FNCashAcCommodityNeCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"CashAcCommodityNeCell";
    FNCashAcCommodityNeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
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
    self.goodsImage=[UIImageView new];
    self.goodsImage.backgroundColor=RED;
    [self.contentView addSubview:self.goodsImage];
    //商品名字
    self.goodstitleLB=[UILabel new];
    self.goodstitleLB.textColor=FNWhiteColor;
    self.goodstitleLB.font=kFONT12;
    self.goodstitleLB.textAlignment=NSTextAlignmentCenter;
    [self.goodsImage addSubview:self.goodstitleLB];
    self.goodstitleLB.backgroundColor=FNBlackColorWithAlpha(0.3);
    //排名图片
    self.rankingImageView=[UIImageView new];
    [self.goodsImage addSubview:self.rankingImageView];
    //排名
    self.rankingLB=[UILabel new];
    self.rankingLB.textColor=FNWhiteColor;
    self.rankingLB.font=kFONT12;
    self.rankingLB.textAlignment=NSTextAlignmentCenter;
    self.rankingLB.numberOfLines=2;
    [self.rankingImageView addSubview:self.rankingLB];
    
    //原价
    self.goodsPrice=[UILabel new];
    self.goodsPrice.textColor=FNBlackColor;
    self.goodsPrice.font=kFONT12;
    [self.contentView addSubview:self.goodsPrice];
    
    /** 优惠券 **/
    self.couponImageView=[UIImageView new];
    //self.couponImageView.backgroundColor=RED;
    [self.contentView addSubview:self.couponImageView];
    
    /** 优惠券金额 **/
    self.couponLB=[UILabel new];
    self.couponLB.textColor=RED;
    self.couponLB.font=kFONT10;
    self.couponLB.textAlignment=NSTextAlignmentCenter;
    [self.couponImageView addSubview:self.couponLB];
    /** 减 **/
    self.minusImageView=[UIImageView new];
    //self.minusImageView.backgroundColor=RED;
    [self.contentView addSubview:self.minusImageView];
    
    /** 减金额 **/
    self.minusLB=[UILabel new];
    self.minusLB.textColor=RED;
    self.minusLB.font=kFONT10;
    self.minusLB.textAlignment=NSTextAlignmentCenter;
    [self.minusImageView addSubview:self.minusLB];
    
    //专享价title
    self.cashTitleLB=[UILabel new];
    self.cashTitleLB.textColor=RED;
    self.cashTitleLB.textColor=FNColor(252, 83, 76);
    self.cashTitleLB.font=kFONT11;
    [self.contentView addSubview:self.cashTitleLB];
    // 专享价
    self.cashPriceLB=[UILabel new];
    self.cashPriceLB.textColor=RED;
    self.cashPriceLB.textColor=FNColor(252, 83, 76);
    self.cashPriceLB.font=kFONT15;
    [self.contentView addSubview:self.cashPriceLB];
    
    [self initdistribute];
}
-(void)initdistribute{
    
    CGFloat interval_5=5;
    CGFloat interval_10=10;
    
    //商品图片
    self.goodsImage.sd_layout
    .leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(165);
    //商品名字
    self.goodstitleLB.sd_layout
    .leftSpaceToView(self.goodsImage, 0).bottomSpaceToView(self.goodsImage, 0).rightSpaceToView(self.goodsImage, 0).heightIs(25);
    //销量图片
    self.rankingImageView.sd_layout
    .rightSpaceToView(self.goodsImage, 0).topSpaceToView(self.goodsImage, 0).heightIs(45).widthIs(50);
    //销量
    self.rankingLB.sd_layout
    .topSpaceToView(self.rankingImageView, 0).bottomSpaceToView(self.rankingImageView, 5).leftSpaceToView(self.rankingImageView, 0).rightSpaceToView(self.rankingImageView, 0);
    
    self.goodsPrice.sd_layout
    .topSpaceToView(self.goodsImage, interval_5).leftSpaceToView(self.contentView, interval_5).rightSpaceToView(self.contentView, interval_5).heightIs(20);
    
    //self.couponImageView.sd_layout
    //.topSpaceToView(self.goodsPrice, interval_5).leftSpaceToView(self.contentView, interval_5).heightIs(20).widthIs(10);
   
    //self.couponLB.sd_layout
    //.topSpaceToView(self.couponImageView, 0).leftSpaceToView(self.couponImageView, interval_10*2).heightIs(20).rightSpaceToView(self.couponImageView, interval_10);
    [self.couponLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.couponImageView.mas_left).offset(interval_10*2);
        make.right.equalTo(self.couponImageView.mas_right).offset(interval_10);
        make.top.equalTo(self.couponImageView.mas_top).offset(0);
        make.height.equalTo(@20);
    }];
    [self.couponImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(interval_5);
        make.top.equalTo(self.goodsPrice.mas_bottom).offset(interval_5);
        make.height.equalTo(@20);
        make.width.mas_equalTo(self.couponLB.width+5+20);
    }];
    
    [self.minusLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.minusImageView.mas_left).offset(interval_10*2);
        make.right.equalTo(self.minusImageView.mas_right).offset(interval_10);
        make.top.equalTo(self.minusImageView.mas_top).offset(0);
        make.height.equalTo(@20);
    }];
    [self.minusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.couponImageView.mas_right).offset(interval_5);
        make.top.equalTo(self.goodsPrice.mas_bottom).offset(interval_5);
        make.height.equalTo(@20);
        make.width.mas_equalTo(self.minusLB.width+5+20);
    }];
    //self.minusImageView.sd_layout
    //.topSpaceToView(self.goodsPrice, interval_5).leftSpaceToView(self.couponImageView, interval_5).heightIs(20).widthIs(70);
    
    //self.minusLB.sd_layout
    //.topSpaceToView(self.minusImageView, 0).leftSpaceToView(self.minusImageView, interval_10*2).heightIs(20).rightSpaceToView(self.minusImageView, interval_10);
    NSString *joint=@"专享价: ¥";
    CGFloat jointW =  [self getWidthWithText:joint height:20 font:12];
    self.cashTitleLB.sd_layout
    .bottomSpaceToView(self.contentView, interval_5).leftSpaceToView(self.contentView, interval_5).heightIs(25).widthIs(jointW);
    //[self.cashTitleLB setSingleLineAutoResizeWithMaxWidth:100];
    
    self.cashPriceLB.sd_layout
    .leftSpaceToView(self.cashTitleLB, 0).heightIs(25).bottomSpaceToView(self.contentView, interval_5);
    [self.cashPriceLB setSingleLineAutoResizeWithMaxWidth:100];
    
    
}

-(void)setItemDic:(NSDictionary *)itemDic{
    _itemDic=itemDic;
    if(itemDic){
        CGFloat interval_5=5;
        CGFloat interval_7=7;
        CGFloat interval_10=10;
        FNCashActivityItemNeModel *model=[FNCashActivityItemNeModel mj_objectWithKeyValues:itemDic];
        [self.goodsImage setUrlImg:model.goods_img];
        self.rankingImageView.image=IMAGE(@"h5_sales_volume");
        self.rankingLB.text=[NSString stringWithFormat:@"销量%@",model.goods_sales];//@"销量1.8万";
        self.goodstitleLB.text=model.goods_title;//@"运动背包男时双肩双肩";
        
        self.goodsPrice.text=[NSString stringWithFormat:@"%@¥%@",model.price_str,model.goods_cost_price];//@"天猫价¥15.60";
        self.couponImageView.image=IMAGE(@"h5_border_coupon");
        self.couponLB.text=[NSString stringWithFormat:@"¥%@",model.yhq_price];//@"¥10";
        self.minusImageView.image=IMAGE(@"h5_border_SUB");
        self.minusLB.text=[NSString stringWithFormat:@"¥%@",model.one_tlj_val];//@"¥5";
        // 专享价
        self.cashTitleLB.text=[NSString stringWithFormat:@"%@: ¥",model.price_str2];//@"专享价¥";
        // 专享价金额
        self.cashPriceLB.text=model.goods_price;//@"51.90";
        
        
        CGFloat couponW =  [self getWidthWithText:self.couponLB.text height:20 font:12];
        CGFloat minusW =  [self getWidthWithText:self.minusLB.text height:20 font:12];
        NSInteger yhqInt=[model.yhq integerValue];
        NSInteger is_tljInt=[model.is_tlj integerValue];
        CGFloat yhqImageW= couponW+30;
        CGFloat minusImageW= minusW+30;
        if(yhqImageW<60){
            yhqImageW=60;
        }
        if(minusImageW<60){
            minusImageW=60;
        }
        if(yhqInt==1){
            self.couponImageView.hidden=NO;
            self.couponLB.hidden=NO;
            [self.couponImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView.mas_left).offset(interval_5);
                make.top.equalTo(self.goodsPrice.mas_bottom).offset(interval_5);
                make.height.equalTo(@20);
                make.width.mas_equalTo(yhqImageW);
            }];
            [self.couponLB mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.couponImageView.mas_right).offset(-2.5);
                make.top.equalTo(self.couponImageView.mas_top).offset(0);
                make.height.equalTo(@20);
                make.width.mas_equalTo(couponW+5);
            }];
            if(is_tljInt==1){
                self.minusImageView.hidden=NO;
                self.minusLB.hidden=NO;
                [self.minusImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.couponImageView.mas_right).offset(interval_5);
                    make.top.equalTo(self.goodsPrice.mas_bottom).offset(interval_5);
                    make.height.equalTo(@20);
                    make.width.mas_equalTo(minusImageW);
                }];
                [self.minusLB mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.minusImageView.mas_right).offset(-2.5);
                    make.top.equalTo(self.minusImageView.mas_top).offset(0);
                    make.height.equalTo(@20);
                    make.width.mas_equalTo(minusW+5);
                }];
            }else{
                self.minusImageView.hidden=YES;
                self.minusLB.hidden=YES;
            }
        }
        if(yhqInt==0){
            self.couponImageView.hidden=YES;
            self.couponLB.hidden=YES;
            [self.couponImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView.mas_left).offset(interval_5);
                make.top.equalTo(self.goodsPrice.mas_bottom).offset(interval_5);
                make.height.equalTo(@20);
                make.width.mas_equalTo(@0);
            }];
            if(is_tljInt==1){
                self.minusImageView.hidden=NO;
                self.minusLB.hidden=NO;
                [self.minusImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.couponImageView.mas_right).offset(interval_5);
                    make.top.equalTo(self.goodsPrice.mas_bottom).offset(interval_5);
                    make.height.equalTo(@20);
                    make.width.mas_equalTo(minusImageW);
                }];
                [self.minusLB mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.minusImageView.mas_right).offset(-2.5);
                    make.top.equalTo(self.minusImageView.mas_top).offset(0);
                    make.height.equalTo(@20);
                    make.width.mas_equalTo(minusW+5);
                }];
            }else{
                self.minusImageView.hidden=YES;
                self.minusLB.hidden=YES;
            }
        }
    }
    [self.contentView setNeedsLayout];
}
//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}
@end
