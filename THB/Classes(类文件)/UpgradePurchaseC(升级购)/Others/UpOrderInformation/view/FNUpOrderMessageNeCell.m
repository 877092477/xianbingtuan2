//
//  FNUpOrderMessageNeCell.m
//  THB
//
//  Created by Jimmy on 2018/9/28.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNUpOrderMessageNeCell.h"

@implementation FNUpOrderMessageNeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
    
    self.contentView.backgroundColor=FNWhiteColor;
    //商品BGView
    self.goodsBGview=[UIView new];
    self.goodsBGview.frame=CGRectMake(0, 0, FNDeviceWidth, 110);
    self.goodsBGview.backgroundColor=FNColor(240, 240, 240);
    [self.contentView addSubview:self.goodsBGview];
    
    //商品图片
    self.GoodsImage=[UIImageView new];
    self.GoodsImage.contentMode=UIViewContentModeScaleToFill;
    self.GoodsImage.image=IMAGE(@"APP底图.png");
    [self.goodsBGview addSubview:self.GoodsImage];
    
    //商品标题
    self.GoodsTitleLabel=[UILabel new];
    self.GoodsTitleLabel.numberOfLines=1;
    self.GoodsTitleLabel.textColor=FNBlackColor;
    self.GoodsTitleLabel.font=kFONT12;
    [self.goodsBGview addSubview:self.GoodsTitleLabel];
    
    //原价
    self.originPriceLabel=[UILabel new];
    [self.originPriceLabel sizeToFit];
    self.originPriceLabel.textColor=FNColor(246, 71, 111);
    self.originPriceLabel.font=kFONT14;
    [self.goodsBGview addSubview:self.originPriceLabel];
    
    //月销量
    self.countLabel=[UILabel new];
    [self.countLabel sizeToFit];
    self.countLabel.textColor=FNGlobalTextGrayColor;
    self.countLabel.font=kFONT12;
    [self.goodsBGview addSubview:self.countLabel];
    
    //其他
    self.restsLabel=[UILabel new];
    [self.restsLabel sizeToFit];
    self.restsLabel.textColor=FNColor(246, 71, 111);
    self.restsLabel.font=kFONT12;
    self.restsLabel.cornerRadius=5;
    [self.goodsBGview addSubview:self.restsLabel];
    
    //优选
    self.optimizationLB=[UILabel new];
    self.optimizationLB.font=kFONT12;
    self.optimizationLB.backgroundColor=[UIColor redColor];
    self.optimizationLB.textColor=FNWhiteColor;
    [self.goodsBGview addSubview:self.optimizationLB];
    self.optimizationLB.cornerRadius=5/2;
    
    /** 支付方式 **/
    self.mannerLeft=[UILabel new];
    self.mannerLeft.textColor=FNBlackColor;
    self.mannerLeft.font=kFONT12;
    self.mannerLeft.userInteractionEnabled = YES;
    UITapGestureRecognizer *mannerLefttap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mannertapClick:)];
    [self.mannerLeft addGestureRecognizer:mannerLefttap];
    [self.contentView addSubview:self.mannerLeft];
    
    /** 支付 **/
    self.mannerLB=[UILabel new];
    self.mannerLB.textColor=FNColor(86, 149, 251);
    self.mannerLB.textAlignment=NSTextAlignmentRight;
    self.mannerLB.font=kFONT12;
    self.mannerLB.userInteractionEnabled = YES;
    UITapGestureRecognizer *mannertap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mannertapClick:)];
    [self.mannerLB addGestureRecognizer:mannertap];
    [self.contentView addSubview:self.mannerLB];
    
    /** 方向 **/
    self.directionImage=[UIImageView new];
    self.directionImage.image=IMAGE(@"APP底图.png");
    [self.contentView addSubview:self.directionImage];
    
//    /** line **/
//    self.lineLB=[UILabel new];
//    self.lineLB.backgroundColor=FNColor(240, 240, 240);
//    [self.contentView addSubview:self.lineLB];
//
//    /** 提交时间 **/
//    self.timeLeft=[UILabel new];
//    self.timeLeft.textColor=FNGlobalTextGrayColor;
//    self.timeLeft.font=kFONT12;
//    [self.contentView addSubview:self.timeLeft];
//
//    /** 提交时间 **/
//    self.timeLB=[UILabel new];
//    self.timeLB.textColor=FNGlobalTextGrayColor;
//    self.timeLB.font=kFONT12;
//    [self.contentView addSubview:self.timeLB];
//
//    /** 订单金额 **/
//    self.sumLeft=[UILabel new];
//    self.sumLeft.textColor=FNGlobalTextGrayColor;
//    self.sumLeft.font=kFONT12;
//    [self.contentView addSubview:self.sumLeft];
//
//    /** 订单金额 **/
//    self.sumLB=[UILabel new];
//    self.sumLB.textColor=FNGlobalTextGrayColor;
//    self.sumLB.font=kFONT12;
//    [self.contentView addSubview:self.sumLB];
//
//    /** 配送方式 **/
//    self.carriageLeft=[UILabel new];
//    self.carriageLeft.textColor=FNGlobalTextGrayColor;
//    self.carriageLeft.font=kFONT12;
//    [self.contentView addSubview:self.carriageLeft];
//
//    /** 配送方式 **/
//    self.carriageLB=[UILabel new];
//    self.carriageLB.textColor=FNGlobalTextGrayColor;
//    self.carriageLB.font=kFONT12;
//    [self.contentView addSubview:self.carriageLB];
    
    [self initializedSubviews];
   
}
#pragma mark - initializedSubviews
- (void)initializedSubviews {
    
    CGFloat interval_10 = 10;
    //商品BGView
    self.goodsBGview.sd_layout
    .topSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, 0).heightIs(110).rightSpaceToView(self.contentView, 0);
    //商品图片
    self.GoodsImage.sd_layout
    .topSpaceToView(self.goodsBGview, interval_10).leftSpaceToView(self.goodsBGview, interval_10).widthIs(90).heightIs(90);
    
    //商品标题
    self.GoodsTitleLabel.sd_layout
    .topSpaceToView(self.goodsBGview, interval_10).leftSpaceToView(self.GoodsImage, interval_10).heightIs(20).rightSpaceToView(self.goodsBGview, interval_10);
    
    //其他 尺码
    self.restsLabel.sd_layout
    .leftSpaceToView(self.GoodsImage, interval_10).heightIs(20).rightSpaceToView(self.goodsBGview, interval_10).topSpaceToView(self.GoodsTitleLabel, interval_10/2);
    
    
    //原价
    self.originPriceLabel.sd_layout
    .leftSpaceToView(self.GoodsImage, interval_10).heightIs(20).bottomEqualToView(self.GoodsImage);
    [self.originPriceLabel setSingleLineAutoResizeWithMaxWidth:120];
    
    //数量
    self.countLabel.sd_layout
    .rightSpaceToView(self.goodsBGview, interval_10).heightIs(20).bottomEqualToView(self.GoodsImage);
    [self.countLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    //优品
    self.optimizationLB.sd_layout
    .topSpaceToView(self.goodsBGview, interval_10).leftSpaceToView(self.GoodsImage, interval_10).heightIs(20);
    [self.optimizationLB setSingleLineAutoResizeWithMaxWidth:60]; 
    
    //支付方式
    self.mannerLeft.sd_layout
    .topSpaceToView(self.goodsBGview, 0).leftSpaceToView(self.contentView, interval_10).heightIs(40).widthIs(100);
    //[self.mannerLeft setSingleLineAutoResizeWithMaxWidth:100];
    
    // 方向
    self.directionImage.sd_layout
    .topSpaceToView(self.goodsBGview, interval_10+2.5).heightIs(15).rightSpaceToView(self.contentView, interval_10).widthIs(10);
    
    //支付
    self.mannerLB.sd_layout
    .topSpaceToView(self.goodsBGview, 0).heightIs(40).rightSpaceToView(self.directionImage, interval_10).leftSpaceToView(self.mannerLeft, 0);
    //[self.mannerLB setSingleLineAutoResizeWithMaxWidth:120];
    
    // line
//    self.lineLB.sd_layout
//    .topSpaceToView(self.mannerLeft, 0).leftSpaceToView(self.contentView, interval_10).heightIs(1).rightSpaceToView(self.contentView, interval_10);
    
//    // 提交时间
//    self.timeLeft.sd_layout
//    .topSpaceToView(self.lineLB, 0).leftSpaceToView(self.contentView, interval_10).heightIs(40);
//    [self.timeLeft setSingleLineAutoResizeWithMaxWidth:100];
//
//    // 提交时间
//    self.timeLB.sd_layout
//    .topSpaceToView(self.lineLB, 0).heightIs(40).rightSpaceToView(self.contentView, interval_10);
//    [self.timeLB setSingleLineAutoResizeWithMaxWidth:150];
//
//    // 订单金额
//    self.sumLeft.sd_layout
//    .topSpaceToView(self.timeLeft, 0).leftSpaceToView(self.contentView, interval_10).heightIs(40);
//    [self.sumLeft setSingleLineAutoResizeWithMaxWidth:100];
//
//    // 订单金额
//    self.sumLB.sd_layout
//    .topSpaceToView(self.timeLeft, 0).heightIs(40).rightSpaceToView(self.contentView, interval_10);
//    [self.sumLB setSingleLineAutoResizeWithMaxWidth:150];
//
//    // 配送方式
//    self.carriageLeft.sd_layout
//    .topSpaceToView(self.sumLeft, 0).leftSpaceToView(self.contentView, interval_10).heightIs(40);
//    [self.carriageLeft setSingleLineAutoResizeWithMaxWidth:100];
//    // 配送方式
//    self.carriageLB.sd_layout
//    .topSpaceToView(self.sumLeft, 0).heightIs(40).rightSpaceToView(self.contentView, interval_10);
//    [self.carriageLB setSingleLineAutoResizeWithMaxWidth:150];
    
    
   
}
-(void)setModel:(FNUpOrderinformationNModel *)model{
    _model=model;
    if(model){
        FNUpOrderGoodsInfoNModel *goodsmodel=[FNUpOrderGoodsInfoNModel mj_objectWithKeyValues:model.goodsInfo];
        //商品图片
        self.GoodsImage.image=IMAGE(@"APP底图.png");
        [self.GoodsImage setUrlImg:goodsmodel.img];
        //商品标题
        self.GoodsTitleLabel.text=[NSString stringWithFormat:@"%@ %@",goodsmodel.label1,goodsmodel.title];//@"优品 夏季学生韩版修身横竖条纹7分又白衬衫潮流短袖百搭";
        //其他 尺码
        self.restsLabel.text=goodsmodel.attr;//@"尺码:M码 颜色:层-21451";
        //原价
        self.originPriceLabel.text=goodsmodel.price;//@"¥69.00";
        //月销量
        self.countLabel.text=goodsmodel.num;//@"x1";
        //优品
        self.optimizationLB.text=goodsmodel.label1;//@"优品";
        self.optimizationLB.textColor=[UIColor colorWithHexString:goodsmodel.label_fontcolor1];
        UIColor *extractedExpr = [UIColor colorWithHexString:goodsmodel.label_bjcolor1];
        self.optimizationLB.backgroundColor=extractedExpr;
        //支付方式
        self.mannerLeft.text=@"支付方式";
        // 方向
        self.directionImage.image=IMAGE(@"btn__more_nor");
        //支付
        self.mannerLB.text=@"请选择";
//        // 提交时间
//        self.timeLeft.text=@"提交时间";
//        // 提交时间
//        self.timeLB.text=@"2018-9-27 12:00:00";
//        // 订单金额
//        self.sumLeft.text=@"订单金额";
//        // 订单金额
//        self.sumLB.text=@"¥1200.00";
//        // 配送方式
//        self.carriageLeft.text=@"配送方式";
//        // 配送方式
//        self.carriageLB.text=@"快递包邮";
    }
}
// 选择支付方式事件
-(void)mannertapClick:(UITapGestureRecognizer *)sender{
    if ([self.delegate respondsToSelector:@selector(selectPatternofpaymentAction:)] ) {
        [self.delegate selectPatternofpaymentAction:self.indexPath];
    }
}
@end
