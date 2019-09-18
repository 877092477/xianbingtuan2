//
//  FNUpOrderDetailsMeCell.m
//  THB
//
//  Created by Jimmy on 2018/9/30.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNUpOrderDetailsMeCell.h"

@implementation FNUpOrderDetailsMeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        [self setup];
    }
    return self;
}

- (void)setup{
    self.OrdertitleLB=[UILabel new];
    self.OrdertitleLB.font=[UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.OrdertitleLB];
    
    
    self.timeLabel=[UILabel new];
    self.timeLabel.font=[UIFont systemFontOfSize:12];
    self.goodsImageView.backgroundColor=[UIColor lightGrayColor];
    [self.contentView addSubview:self.timeLabel];
    
    self.bgView=[UIView new];
    self.bgView.backgroundColor=FNColor(240,240,240);
    [self.contentView addSubview:self.bgView];
    
    self.goodsImageView=[[UIImageView alloc]init];
    self.goodsImageView.backgroundColor=[UIColor whiteColor];
    self.goodsImageView.layer.cornerRadius=5/2;
    self.goodsImageView.layer.masksToBounds=YES;
    [self.bgView addSubview:self.goodsImageView];
    
    self.nameLB=[UILabel new];
    self.nameLB.font=[UIFont systemFontOfSize:14];
    //self.nameLB.backgroundColor=FNColor(240,240,240);
    self.nameLB.numberOfLines=2;
    [self.bgView addSubview:self.nameLB];
    
    self.statusLabel=[UILabel new];
    self.statusLabel.font=[UIFont systemFontOfSize:14];
    self.statusLabel.backgroundColor=[UIColor redColor];
    self.statusLabel.textColor=[UIColor whiteColor];
    self.statusLabel.layer.cornerRadius=5/2;
    self.statusLabel.layer.masksToBounds=YES;
    [self.bgView addSubview:self.statusLabel];
    
    self.restsLabel=[UILabel new];
    self.restsLabel.textColor=[UIColor grayColor];
    self.restsLabel.font=[UIFont systemFontOfSize:12];
    //self.restsLabel.backgroundColor=FNColor(240,240,240);
    [self.bgView addSubview:self.restsLabel];
    
    self.priceLabel=[UILabel new];
    self.priceLabel.textColor=[UIColor redColor];
    self.priceLabel.font=[UIFont systemFontOfSize:12];
    //self.priceLabel.backgroundColor=FNColor(240,240,240);
    [self.bgView addSubview:self.priceLabel];
    
    self.amountLabel=[UILabel new];
    self.amountLabel.font=[UIFont systemFontOfSize:12];
    //self.amountLabel.backgroundColor=FNColor(240,240,240);
    [self.bgView addSubview:self.amountLabel];
    
    self.totalpricesLeft=[UILabel new];
    self.totalpricesLeft.textColor=[UIColor grayColor];
    self.totalpricesLeft.font=[UIFont systemFontOfSize:12];
    //self.totalpricesLeft.backgroundColor=FNColor(240,240,240);
    [self.contentView addSubview:self.totalpricesLeft];
    
    self.totalpricesRight=[UILabel new];
    self.totalpricesRight.textColor=[UIColor grayColor];
    self.totalpricesRight.font=[UIFont systemFontOfSize:12];
    //self.totalpricesRight.backgroundColor=FNColor(240,240,240);
    [self.contentView addSubview:self.totalpricesRight];
    
    self.freightLeft=[UILabel new];
    self.freightLeft.textColor=[UIColor grayColor];
    self.freightLeft.font=[UIFont systemFontOfSize:12];
    //self.freightLeft.backgroundColor=FNColor(240,240,240);
    [self.contentView addSubview:self.freightLeft];
    
    self.freightRight=[UILabel new];
    self.freightRight.textColor=[UIColor grayColor];
    self.freightRight.font=[UIFont systemFontOfSize:12];
    //self.freightRight.backgroundColor=FNColor(240,240,240);
    [self.contentView addSubview:self.freightRight];
    
    self.saleLeft=[UILabel new];
    self.saleLeft.textColor=[UIColor grayColor];
    self.saleLeft.font=[UIFont systemFontOfSize:12];
    //self.saleLeft.backgroundColor=FNColor(240,240,240);
    [self.contentView addSubview:self.saleLeft];
    
    self.saleRight=[UILabel new];
    self.saleRight.textColor=[UIColor grayColor];
    self.saleRight.font=[UIFont systemFontOfSize:12];
    //self.saleRight.backgroundColor=FNColor(240,240,240);
    [self.contentView addSubview:self.saleRight];
    
    self.actualLeft=[UILabel new];
    self.actualLeft.textColor=[UIColor blackColor];
    self.actualLeft.font=[UIFont systemFontOfSize:14];
    //self.actualLeft.backgroundColor=FNColor(240,240,240);
    [self.contentView addSubview:self.actualLeft];
    
    self.actualRight=[UILabel new];
    self.actualRight.textColor=[UIColor redColor];
    self.actualRight.font=[UIFont systemFontOfSize:12];
    //self.actualRight.backgroundColor=FNColor(240,240,240);
    [self.contentView addSubview:self.actualRight];
    
    self.stateRight=[UILabel new];
    self.stateRight.textColor=[UIColor whiteColor];
    self.stateRight.font=[UIFont systemFontOfSize:12]; 
    self.stateRight.layer.cornerRadius=5/2;
    self.stateRight.layer.masksToBounds=YES;
    self.stateRight.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:self.stateRight];
    
    [self inDistribution];
    
}
-(void)inDistribution{
    CGFloat margin = 10;
    self.OrdertitleLB.sd_layout
    .leftSpaceToView(self.contentView, margin).topSpaceToView(self.contentView, margin).heightIs(20);
    [self.OrdertitleLB setSingleLineAutoResizeWithMaxWidth:80];
    
    self.timeLabel.sd_layout
    .rightSpaceToView(self.contentView,margin).topSpaceToView(self.contentView, margin).heightIs(20);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.bgView.sd_layout
    .rightSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, 0).topSpaceToView(self.OrdertitleLB, margin).heightIs(100);
    
    self.goodsImageView.sd_layout
    .leftSpaceToView(self.bgView, margin).topSpaceToView(self.bgView, margin).heightIs(80).widthIs(80);
    
    self.nameLB.sd_layout
    .topSpaceToView(self.bgView, margin).leftSpaceToView(self.goodsImageView, margin).rightSpaceToView(self.bgView, margin).heightIs(20);
    
    self.statusLabel.sd_layout
    .topSpaceToView(self.bgView, margin).leftSpaceToView(self.goodsImageView, margin).heightIs(20);
    [self.statusLabel setSingleLineAutoResizeWithMaxWidth:50];
    
    self.restsLabel.sd_layout
    .leftSpaceToView(self.goodsImageView, margin).rightSpaceToView(self.bgView, margin).topSpaceToView(self.nameLB, 2.5).heightIs(20);
    
    self.priceLabel.sd_layout
    .leftSpaceToView(self.goodsImageView, margin).bottomEqualToView(self.goodsImageView).heightIs(20);
    [self.priceLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    self.amountLabel.sd_layout
    .rightSpaceToView(self.bgView, margin).heightIs(20).bottomSpaceToView(self.bgView,margin);
    [self.amountLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.totalpricesLeft.sd_layout
    .leftSpaceToView(self.contentView, margin).heightIs(20).topSpaceToView(self.bgView,margin/2);
    [self.totalpricesLeft setSingleLineAutoResizeWithMaxWidth:100];
    
    self.totalpricesRight.sd_layout
    .rightSpaceToView(self.contentView, margin).heightIs(20).topSpaceToView(self.bgView,margin/2);
    [self.totalpricesRight setSingleLineAutoResizeWithMaxWidth:150];
    
    self.freightLeft.sd_layout
    .leftSpaceToView(self.contentView, margin).heightIs(20).topSpaceToView(self.totalpricesLeft,margin/2);
    [self.freightLeft setSingleLineAutoResizeWithMaxWidth:100];
    
    self.freightRight.sd_layout
    .rightSpaceToView(self.contentView, margin).heightIs(20).topSpaceToView(self.totalpricesLeft,margin/2);
    [self.freightRight setSingleLineAutoResizeWithMaxWidth:150];
    
    self.saleLeft.sd_layout
    .leftSpaceToView(self.contentView, margin).heightIs(20).topSpaceToView(self.freightLeft,margin/2);
    [self.saleLeft setSingleLineAutoResizeWithMaxWidth:100];
    
    self.saleRight.sd_layout
    .rightSpaceToView(self.contentView, margin).heightIs(20).topSpaceToView(self.freightLeft,margin/2);
    [self.saleRight setSingleLineAutoResizeWithMaxWidth:150];
    
    
    self.actualLeft.sd_layout
    .leftSpaceToView(self.contentView, margin).heightIs(20).topSpaceToView(self.saleLeft,margin/2);
    [self.actualLeft setSingleLineAutoResizeWithMaxWidth:100];
    
    self.actualRight.sd_layout
    .rightSpaceToView(self.contentView, margin).heightIs(20).topSpaceToView(self.saleLeft,margin/2);
    [self.actualRight setSingleLineAutoResizeWithMaxWidth:100];
    
    self.stateRight.sd_layout
    .rightSpaceToView(self.contentView, margin).heightIs(20).topSpaceToView(self.actualRight,margin/2).widthIs(50); 
    
}
-(void)setModel:(FNUpOrderdetailitemNeHModel *)model{
    _model=model;
    if(model){
        FNOrderdetailitemGoodsNeHModel* goodsModel=[FNOrderdetailitemGoodsNeHModel mj_objectWithKeyValues:model.goods];
        self.OrdertitleLB.text=model.str;//@"升级订单";
        self.timeLabel.text=model.create_time;//@"2018-09-21 09:54:05";
        self.goodsImageView.image=IMAGE(@"APP底图");
        [self.goodsImageView setUrlImg:goodsModel.img];
        self.nameLB.text=[NSString stringWithFormat:@"%@ %@",goodsModel.label1,goodsModel.title];//@"优品 夏季学生韩版修身竖条纹7分袖白衬衫潮流短袖衬衣服帅气百搭";
        self.statusLabel.text=goodsModel.label1;//@"优品";
        self.statusLabel.textColor=[UIColor colorWithHexString:goodsModel.label_fontcolor1];
        UIColor *extractedExpr = [UIColor colorWithHexString:goodsModel.label_bjcolor1];
        self.statusLabel.backgroundColor=extractedExpr;
        self.restsLabel.text=goodsModel.attr;//@"尺码: M码 颜色: c-21451";
        self.priceLabel.text=[NSString stringWithFormat:@"¥%@",goodsModel.price];//@"¥69.00";
        self.amountLabel.text=goodsModel.num;//@"x1";
        self.totalpricesLeft.text=@"总价";
        self.totalpricesRight.text=model.goods_payment;//@"¥69.00";
        self.freightLeft.text=@"运费(快递)";
        self.freightRight.text=model.postage;//@"¥0.00";
        self.saleLeft.text=@"优惠";
        self.saleRight.text=[NSString stringWithFormat:@"%@",model.discount];//@"-¥0.00";
        self.actualLeft.text=@"实际支付";
        self.actualRight.text=[NSString stringWithFormat:@"¥%@",model.payment];//@"¥69.00";
        //self.stateRight.text=@"已付款";
        NSInteger status_num=[model.status_num integerValue];
        NSArray *statearr=@[@"",@"已付款",@"已发货 ",@"已签收 ",@"失效 ",@"未付款",];
        self.stateRight.text=statearr[status_num];
        UIColor *staterightBGcolor = [UIColor colorWithHexString:model.color];
        self.stateRight.backgroundColor=staterightBGcolor;
    }
}

@end
