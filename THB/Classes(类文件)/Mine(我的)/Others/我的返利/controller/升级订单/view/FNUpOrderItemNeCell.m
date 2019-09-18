//
//  FNUpOrderItemNeCell.m
//  THB
//
//  Created by Jimmy on 2018/9/29.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNUpOrderItemNeCell.h"

@implementation FNUpOrderItemNeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
    
    
    /** 提交时间 **/
    self.OrderTitleLeft=[UILabel new];
    self.OrderTitleLeft.textColor=FNGlobalTextGrayColor;
    self.OrderTitleLeft.font=kFONT12;
    [self.contentView addSubview:self.OrderTitleLeft];
    
    /** 提交时间 **/
    self.timeLB=[UILabel new];
    self.timeLB.textColor=FNGlobalTextGrayColor;
    self.timeLB.font=kFONT12;
    [self.contentView addSubview:self.timeLB];
    
    //商品BGView
    self.goodsBGview=[UIView new];
    self.goodsBGview.frame=CGRectMake(0, 0, FNDeviceWidth, 110);
    self.goodsBGview.backgroundColor=FNColor(239, 239, 244);
    [self.contentView addSubview:self.goodsBGview];
    
    //商品图片
    self.GoodsImage=[UIImageView new];
    self.GoodsImage.contentMode=UIViewContentModeScaleToFill;
    self.GoodsImage.image=IMAGE(@"APP底图.png");
    self.GoodsImage.cornerRadius=5;
    [self.goodsBGview addSubview:self.GoodsImage];
    
    //商品标题
    self.GoodsTitleLabel=[UILabel new];
    self.GoodsTitleLabel.numberOfLines=2;
    self.GoodsTitleLabel.textColor=FNBlackColor;
    self.GoodsTitleLabel.font=kFONT12;
    [self.goodsBGview addSubview:self.GoodsTitleLabel];
    
    //优选
    self.optimizationLB=[UILabel new];
    self.optimizationLB.font=kFONT12;
    self.optimizationLB.backgroundColor=[UIColor redColor];
    self.optimizationLB.textColor=FNWhiteColor;
    [self.goodsBGview addSubview:self.optimizationLB];
    self.optimizationLB.cornerRadius=5/2;
    
    //其他
    self.restsLabel=[UILabel new];
    self.restsLabel.numberOfLines=2;
    self.restsLabel.textColor=FNBlackColor;
    self.restsLabel.font=kFONT12;
    
    [self.goodsBGview addSubview:self.restsLabel];
    self.priceLabel=[UILabel new];
    self.priceLabel.textColor=[UIColor redColor];
    self.priceLabel.font=[UIFont systemFontOfSize:12];
    //self.priceLabel.backgroundColor=FNColor(240,240,240);
    [self.goodsBGview addSubview:self.priceLabel];
    
    
    self.amountLabel=[UILabel new];
    self.amountLabel.font=[UIFont systemFontOfSize:12];
    //self.amountLabel.backgroundColor=FNColor(240,240,240);
    [self.goodsBGview addSubview:self.amountLabel];

    
    /** 物流单号 **/
    self.logisticsLeft=[UILabel new];
    self.logisticsLeft.textColor=FNGlobalTextGrayColor;
    self.logisticsLeft.font=kFONT12;
    [self.contentView addSubview:self.logisticsLeft];
    
    /** 复制按钮 **/
    self.copybtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //self.copybtn.backgroundColor=[UIColor grayColor];
    [self.copybtn addTarget:self action:@selector(copybtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.copybtn];
    
    /** 转态已发货 **/
    self.stateright=[UILabel new];
    self.stateright.textColor=FNWhiteColor;
    self.stateright.font=kFONT12;
    self.stateright.cornerRadius=5;
    self.stateright.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:self.stateright];
    
    /** 订单已发货 **/
    self.stateLeft=[UILabel new];
    self.stateLeft.textColor=FNBlackColor;
    self.stateLeft.font=kFONT12;
    [self.contentView addSubview:self.stateLeft];
    
    
    /** line **/
    //self.lineLB=[UILabel new];
    //self.lineLB.backgroundColor=FNColor(247, 247, 247);
    //[self.contentView addSubview:self.lineLB];
    
    [self initializedSubviews];
    
}
#pragma mark - initializedSubviews
- (void)initializedSubviews {
    
    CGFloat interval_10 = 10;
    CGFloat margin = 10;

    // 提交时间
    self.OrderTitleLeft.sd_layout
    .topSpaceToView(self.contentView, interval_10).leftSpaceToView(self.contentView, interval_10).heightIs(20);
    [self.OrderTitleLeft setSingleLineAutoResizeWithMaxWidth:100];
    
    // 提交时间
    self.timeLB.sd_layout
    .topSpaceToView(self.contentView, interval_10).heightIs(20).rightSpaceToView(self.contentView, interval_10);
    [self.timeLB setSingleLineAutoResizeWithMaxWidth:150];
    
    //商品BGView
    self.goodsBGview.sd_layout
    .topSpaceToView(self.OrderTitleLeft, interval_10).leftSpaceToView(self.contentView, 0).heightIs(90).rightSpaceToView(self.contentView, 0);
    //商品图片
    self.GoodsImage.sd_layout
    .topSpaceToView(self.goodsBGview, interval_10/2).leftSpaceToView(self.goodsBGview, interval_10).widthIs(80).heightIs(80);
    
    self.priceLabel.sd_layout
    .leftSpaceToView(self.GoodsImage, margin).bottomEqualToView(self.GoodsImage).heightIs(20);
    [self.priceLabel setSingleLineAutoResizeWithMaxWidth:150];

    self.amountLabel.sd_layout
    .rightSpaceToView(self.goodsBGview, margin).heightIs(20).bottomSpaceToView(self.goodsBGview,margin);
    [self.amountLabel setSingleLineAutoResizeWithMaxWidth:100];

    //商品标题
    self.GoodsTitleLabel.sd_layout
    .topSpaceToView(self.goodsBGview, interval_10/2).leftSpaceToView(self.GoodsImage, interval_10).heightIs(20).rightSpaceToView(self.goodsBGview, interval_10);
    
    //优品
    self.optimizationLB.sd_layout
    .topSpaceToView(self.goodsBGview, interval_10/2).leftSpaceToView(self.GoodsImage, interval_10).heightIs(20);
    [self.optimizationLB setSingleLineAutoResizeWithMaxWidth:60];
    
    //其他 尺码
    self.restsLabel.sd_layout
    .leftSpaceToView(self.GoodsImage, interval_10).heightIs(20).rightSpaceToView(self.goodsBGview, interval_10).topSpaceToView(self.GoodsTitleLabel, interval_10/2);
    
    
    // 改物流单号
    self.logisticsLeft.sd_layout
    .topSpaceToView(self.goodsBGview, interval_10).leftSpaceToView(self.contentView, interval_10).heightIs(20);
    [self.logisticsLeft setSingleLineAutoResizeWithMaxWidth:200];
    
    // 改复制按钮
    self.copybtn.sd_layout
    .heightIs(20).leftSpaceToView(self.logisticsLeft, interval_10).widthIs(20).centerYEqualToView(self.logisticsLeft);
    
    
    // 改转态已发货
    self.stateright.sd_layout
    .topSpaceToView(self.goodsBGview, interval_10).rightSpaceToView(self.contentView, interval_10).heightIs(20).widthIs(55);
    
    // 改订单已发货
    self.stateLeft.sd_layout
    .topSpaceToView(self.goodsBGview, interval_10).heightIs(20).rightSpaceToView(self.stateright, interval_10);
    [self.stateLeft setSingleLineAutoResizeWithMaxWidth:100];
    
    
    // line
    //self.lineLB.sd_layout
    //.bottomSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, 0).heightIs(10).rightSpaceToView(self.contentView, 0);
    
    
    
}

-(void)setModel:(FNUpgradeOrderitemNeHModel *)model{
    _model=model;
    if(model){
        FNUpgradeOrderitemGoodsNeHModel* goodsModel=[FNUpgradeOrderitemGoodsNeHModel mj_objectWithKeyValues:model.goods];
        //商品图片
        self.GoodsImage.image=IMAGE(@"APP底图.png");
        [self.GoodsImage setUrlImg:goodsModel.img];
        //商品标题
        self.GoodsTitleLabel.text=[NSString stringWithFormat:@"%@ %@",goodsModel.label1,goodsModel.title];//@"优品 夏季学生韩版修身横竖条纹7分又白衬衫潮流短袖百搭";
        self.priceLabel.text=[NSString stringWithFormat:@"¥%@",goodsModel.price];//@"¥69.00";
        self.amountLabel.text=goodsModel.num;//@"x1";

        //优品
        self.optimizationLB.text=goodsModel.label1;//@"优品";
        self.optimizationLB.textColor=[UIColor colorWithHexString:goodsModel.label_fontcolor1];
        UIColor *extractedExpr = [UIColor colorWithHexString:goodsModel.label_bjcolor1];
        self.optimizationLB.backgroundColor=extractedExpr;
        //其他 尺码
        self.restsLabel.text=goodsModel.attr;//@"尺码:M码 颜色:层-21451";
        
        // 升级订单
        self.OrderTitleLeft.text=model.str;//@"升级订单";
        //  时间
        self.timeLB.text=model.create_time;//@"2018-9-27 12:00:00";
       
        // 转态已发货
        self.stateright.text=model.status;//@"已发货";
        // 订单已发货
        self.stateLeft.text=model.status_str;//@"订单已发货";
        //self.stateRight.text=@"已付款";
        NSInteger status_num=[model.status_num integerValue];
        NSArray *statearr=@[@"",@"已付款",@"已发货 ",@"已签收 ",@"失效 ",@"未付款",];
        self.stateright.text=statearr[status_num];
        UIColor *staterightBGcolor = [UIColor colorWithHexString:model.color];
        self.stateright.backgroundColor=staterightBGcolor;
        if([model.wl_id kr_isNotEmpty]){
            // 物流单号
            self.logisticsLeft.text=[NSString stringWithFormat:@"物流单号:%@",model.wl_id];//@"物流单号: 20683771707218709";
            // 复制
            self.copybtn.hidden=NO;
            [self.copybtn setImage:[UIImage imageNamed:@"icon_copy_norNe"] forState:UIControlStateNormal];
        }else{
            self.copybtn.hidden=YES;
        }
    }
}
-(void)copybtnAction{
    if ([self.delegate respondsToSelector:@selector(InUpOrderCopyInfoAction:)]) {
        [self.delegate InUpOrderCopyInfoAction:self.indexPath];
    } 
}
@end
