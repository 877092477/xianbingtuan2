//
//  FNActivityNightNeCell.m
//  THB
//
//  Created by Jimmy on 2018/10/23.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNActivityNightNeCell.h"

@implementation FNActivityNightNeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        [self initUI];
        
    }
    return self;
}
-(void)initUI{
    //背景图片1
    self.bgOneImageView=[UIImageView new];
    [self.contentView addSubview:self.bgOneImageView];
    //背景图片
    self.bgImageView=[UIImageView new];
    self.bgImageView.userInteractionEnabled=YES;
    [self.contentView addSubview:self.bgImageView];
    [self.contentView bringSubviewToFront:self.bgImageView];
   
    //商品图片
    self.goodsImage=[UIImageView new];
    self.goodsImage.backgroundColor=RED;
    [self.bgImageView addSubview:self.goodsImage];
    //半透明
    self.goodsShadeView=[UIImageView new];
    self.goodsShadeView.backgroundColor=FNBlackColorWithAlpha(0.3);
    self.goodsShadeView.backgroundColor=FNWhiteColor;
    [self.goodsImage addSubview:self.goodsShadeView];
    //商品名字
    self.goodstitleLB=[UILabel new];
    self.goodstitleLB.textColor=FNWhiteColor;
    self.goodstitleLB.font=kFONT12;
    self.goodstitleLB.backgroundColor=FNBlackColorWithAlpha(0.3);
    [self.goodsImage addSubview:self.goodstitleLB];
    //排名图片
    self.rankingImageView=[UIImageView new];
    [self.goodsImage addSubview:self.rankingImageView];
    //排名
    self.rankingLB=[UILabel new];
    self.rankingLB.textColor=FNWhiteColor;
    self.rankingLB.font=kFONT12;
    [self.rankingImageView addSubview:self.rankingLB];
    //连线图片
    self.circleImageView=[UIImageView new];
    [self.bgImageView addSubview:self.circleImageView];
    //原价BGView
    self.goodsPriceBGView=[UIView new];
    self.goodsPriceBGView.backgroundColor=FNWhiteColor;
    [self.bgImageView addSubview:self.goodsPriceBGView];
    //原价
    self.goodsPrice=[UILabel new];
    self.goodsPrice.textColor=FNBlackColor;
    self.goodsPrice.textColor=FNColor(123, 92, 92);
    self.goodsPrice.font=kFONT12;
    [self.goodsPriceBGView addSubview:self.goodsPrice];
    
    //优惠券
    self.onSaleTitleLB=[UILabel new];
    self.onSaleTitleLB.textColor=RED;
    self.onSaleTitleLB.font=kFONT11;
    self.onSaleTitleLB.textColor=FNColor(252, 83, 76);
    [self.bgImageView addSubview:self.onSaleTitleLB];
    
    //优惠券金额
    self.onSalePriceLB=[UILabel new];
    self.onSalePriceLB.textColor=RED;
    self.onSalePriceLB.font=kFONT15;
    self.onSalePriceLB.textColor=FNColor(252, 83, 76);
    [self.bgImageView addSubview:self.onSalePriceLB];
    
    // 淘礼金title
    self.cashTitleLB=[UILabel new];
    self.cashTitleLB.textColor=RED;
    self.cashTitleLB.font=kFONT11;
    self.cashTitleLB.textColor=FNColor(252, 83, 76);
    [self.bgImageView addSubview:self.cashTitleLB];
    // 淘礼金金额
    self.cashPriceLB=[UILabel new];
    self.cashPriceLB.textColor=RED;
    self.cashPriceLB.font=kFONT15;
    self.cashPriceLB.textColor=FNColor(252, 83, 76);
    [self.bgImageView addSubview:self.cashPriceLB];
    
    //立即购买
    self.purchaseBtn=[[UIButton alloc]init]; 
    [self.purchaseBtn addTarget:self action:@selector(purchaseButton:) forControlEvents:UIControlEventTouchUpInside];
    self.purchaseBtn.backgroundColor=[UIColor whiteColor];
    [self.bgImageView addSubview:self.purchaseBtn];
    
    //中心
    self.middleView=[UIView new];
    self.middleView.backgroundColor=FNBlackColor;
    self.middleView.backgroundColor=FNColor(123, 92, 92);
    [self.goodsPriceBGView addSubview:self.middleView];
    
    [self initdistribute];
    
}
-(void)initdistribute{
    CGFloat goodswith=150;
    CGFloat interval_5=5;
    CGFloat interval_10=10;
    //背景图片1
    self.bgOneImageView.sd_layout
    .leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0);
    //背景图片
    self.bgImageView.sd_layout
    .leftSpaceToView(self.contentView, interval_10).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, interval_10);
    //中心
    //self.middleView.sd_layout
    //.widthIs(1).centerYEqualToView(self.bgImageView).centerXEqualToView(self.bgImageView).topSpaceToView(self.bgImageView, 0).bottomSpaceToView(self.bgImageView, 0);
    //商品图片
    self.goodsImage.sd_layout
    .leftSpaceToView(self.bgImageView, interval_10+2.5).topSpaceToView(self.bgImageView, 0).bottomSpaceToView(self.bgImageView, 1).widthIs(165);
    self.goodsShadeView.sd_layout
    .leftSpaceToView(self.goodsImage, 0).topSpaceToView(self.goodsImage, 0).bottomSpaceToView(self.goodsImage, 0).topSpaceToView(self.goodsImage, 0);
    //商品名字
    self.goodstitleLB.sd_layout
    .leftSpaceToView(self.goodsImage, 0).bottomSpaceToView(self.goodsImage, 0).rightSpaceToView(self.goodsImage, 0).heightIs(30);
    //排名图片
    self.rankingImageView.sd_layout
    .leftSpaceToView(self.goodsImage, 0).topSpaceToView(self.goodsImage, 0).heightIs(20).widthIs(80);
    //排名
    self.rankingLB.sd_layout
    .topSpaceToView(self.rankingImageView, 0).bottomSpaceToView(self.rankingImageView, 0).leftSpaceToView(self.rankingImageView, 0).rightSpaceToView(self.rankingImageView, 0);
    //连圆线图片
    self.circleImageView.sd_layout
    .topSpaceToView(self.bgImageView, interval_5).leftSpaceToView(self.goodsImage, interval_10+5).heightIs(65).widthIs(10);
    //原价背景view
    self.goodsPriceBGView.sd_layout
    .topSpaceToView(self.bgImageView, interval_5).leftSpaceToView(self.circleImageView, interval_10+2.5).heightIs(20).rightSpaceToView(self.bgImageView, interval_10*2);
    //原价
    self.goodsPrice.sd_layout
    .topSpaceToView(self.goodsPriceBGView, 0).leftSpaceToView(self.goodsPriceBGView, 2.5).heightIs(20).rightSpaceToView(self.goodsPriceBGView, interval_5);
    //[self.goodsPrice setSingleLineAutoResizeWithMaxWidth:100];
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsPriceBGView.mas_left);
        make.top.equalTo(self.goodsPriceBGView.mas_top).offset(_jm_margin10);
        make.height.equalTo(@1);
        // make.width.mas_equalTo(self.goodsPrice.width+5);
    }];
    NSString *joint=@"优惠券:";
    CGFloat jointW =  [self getWidthWithText:joint height:20 font:12];
    //优惠券
    self.onSaleTitleLB.sd_layout
    .topSpaceToView(self.goodsPriceBGView, interval_5/2).leftSpaceToView(self.circleImageView, interval_10+5).heightIs(20).widthIs(jointW);
    //[self.onSaleTitleLB setSingleLineAutoResizeWithMaxWidth:100];
    //优惠券金额
    self.onSalePriceLB.sd_layout
    .topSpaceToView(self.goodsPriceBGView, interval_5/2).leftSpaceToView(self.onSaleTitleLB, 0).heightIs(20).widthIs(100);
    //[self.onSalePriceLB setSingleLineAutoResizeWithMaxWidth:100];
    
    // 淘礼金title
    self.cashTitleLB.sd_layout
    .topSpaceToView(self.onSaleTitleLB, interval_5/2).leftSpaceToView(self.circleImageView, interval_10+5).heightIs(20).widthIs(jointW);
    //[self.cashTitleLB setSingleLineAutoResizeWithMaxWidth:100];
    // 淘礼金金额
    self.cashPriceLB.sd_layout
    .topSpaceToView(self.onSaleTitleLB, interval_5/2).leftSpaceToView(self.cashTitleLB, 0).heightIs(20).widthIs(100);
    //[self.cashPriceLB setSingleLineAutoResizeWithMaxWidth:100];
    
    //立即购买 
    self.purchaseBtn.sd_layout
    .topSpaceToView(self.cashTitleLB, interval_10).leftSpaceToView(self.circleImageView, interval_10+5).heightIs(40).widthIs(95);
    
    
//    self.bgOneImageView.image=IMAGE(@"activity_singRowImage");
//    self.bgImageView.image=IMAGE(@"h5_smallbg_middle");
//    self.rankingImageView.image=IMAGE(@"h5_tab_nor");
//    self.rankingLB.text=@"前5000名";
//    self.goodstitleLB.text=@"运动背包男时双肩双肩";
//    self.circleImageView.image=IMAGE(@"h5_office_nor");
//    self.goodsPrice.text=@"原价:¥69";
//    self.onSaleTitleLB.text=@"优惠券:";
//    self.onSalePriceLB.text=@"¥30";
//    self.cashTitleLB.text=@"淘礼金:";
//    self.cashPriceLB.text=@"¥29";
//    [self.purchaseBtn setImage:IMAGE(@"h5_btn_ing") forState:UIControlStateNormal]; 
    
}
-(void)purchaseButton:(UIButton*)btn{
    if ([self.delegate respondsToSelector:@selector(acNightPurchaseAction:)]) {
        [self.delegate acNightPurchaseAction:self.itemModel];
    }
}
-(void)setItemModel:(NSDictionary *)itemModel{
    _itemModel=itemModel;
    if(itemModel){
        FNCashActivityItemNeModel *model=[FNCashActivityItemNeModel mj_objectWithKeyValues:itemModel];
        [self.goodsImage setUrlImg:model.goods_img];
        //self.bgOneImageView.image=IMAGE(@"activity_singRowImage");
        //self.bgImageView.image=IMAGE(@"h5_smallbg_middle"); 
        self.rankingImageView.image=IMAGE(@"h5_tab_nor");
        if([model.str kr_isNotEmpty]){
           self.rankingLB.text=[NSString stringWithFormat:@"%@",model.str];//@"前5000名";
        }
        self.goodstitleLB.text=model.goods_title;//@"运动背包男时双肩双肩";
        //self.circleImageView.image=IMAGE(@"h5_office_nor");
        [self.circleImageView setUrlImg:model.tlj_goods_qg_img3];
        NSString *Price=[NSString stringWithFormat:@"原价:¥%@",model.goods_cost_price];//@"原价:¥69";
        self.goodsPrice.text=Price;//@"原价:¥69";
        self.onSaleTitleLB.text=@"优惠券:";
        self.onSalePriceLB.text=[NSString stringWithFormat:@"¥%@",model.yhq_price];//@"¥30";
        self.cashTitleLB.text=@"淘礼金:";
        self.cashPriceLB.text=[NSString stringWithFormat:@"¥%@",model.one_tlj_val];//@"¥29";
        //[self.purchaseBtn setImage:IMAGE(@"h5_btn_ing") forState:UIControlStateNormal];
        NSInteger is_join=[model.is_join integerValue];
        if (is_join==0) {
            [self.purchaseBtn sd_setImageWithURL:URL(model.tlj_goods_qg_img1) forState:UIControlStateNormal];
        }else if(is_join==1){
            [self.purchaseBtn sd_setImageWithURL:URL(model.tlj_goods_qg_img2) forState:UIControlStateNormal];
        }
        CGFloat middleViewW =  [self getWidthWithText:Price height:20 font:12];
        [self.middleView mas_updateConstraints:^(MASConstraintMaker *make) {
              make.width.mas_equalTo(middleViewW+5);
        }];
        
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
