//
//  FNRushToPurchaseNewCell.m
//  THB
//
//  Created by Jimmy on 2018/9/14.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNRushToPurchaseNewCell.h"
#import "JMProgressView.h"

#define _plt_cell_height 120
@interface FNRushToPurchaseNewCell()
@property (nonatomic, strong) UIView* BGView;

@property (nonatomic, strong) UIImageView* imgview;
@property (nonatomic, strong) UIView* emptyView;
@property (nonatomic, strong) UIImageView* emptyImageView;

@property (nonatomic, strong) UILabel* desLabel;
@property (nonatomic, strong) UILabel* subLabel;
@property (nonatomic, strong) JMProgressView* progressview;
@property (nonatomic, strong) UIImageView* progressimgview;
@property (nonatomic, strong) UILabel* salesLabel;
@property (nonatomic, strong) UILabel* priceLabel;
@property (nonatomic, strong) UIImageView* couponimview;
@property (nonatomic, strong) UILabel* couponLabel;
@property (nonatomic, strong) UIImageView* operationview;

@property (nonatomic, strong) UILabel* genrepriceLabel;

@end

@implementation FNRushToPurchaseNewCell

#pragma mark - model
- (void)setModel:(FNBaseProductModel *)model{
    _model = model;
    if (_model) {
        //商品图片
        [self.imgview setUrlImg:_model.goods_img];
        //商品标题
        self.desLabel.text = self.model.goods_title;
        [self.desLabel HttpLabelLeftImage:self.model.shop_img label:self.desLabel imageX:0 imageY:-1.5 imageH:13 atIndex:0];
        //返
        CGFloat commission=[model.fcommission floatValue];
        if(commission>0){
            if(![FNCurrentVersion isEqualToString:Setting_checkVersion]){
                self.subLabel.text =[NSString stringWithFormat:@"%@:¥%@",model.fan_all_str,model.fcommission];
            }else{
                self.subLabel.text=@" ";
            }
        }
        
        //已抢光view
        _emptyView.hidden = !_model.is_qiangguang.boolValue;
        NSString *originalprice=[NSString stringWithFormat:@"¥%@",self.model.goods_price];
        self.priceLabel.text = originalprice;
        NSString* price = self.model.goods_price;
        if ([NSString checkIsSuccess:_model.yhq andElement:@"1"]) {
            self.couponLabel.text = _model.yhq_span;
        }else{
            self.couponLabel.text = _model.zhe;
        }
        self.couponLabel.textColor=[UIColor colorWithHexString:model.taoqianggou_quan_color];
        if ([self.priceLabel.text containsString:price]) {
             [self.priceLabel addSingleAttributed:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} ofRange:[self.priceLabel.text rangeOfString:price]];
        }
        self.genrepriceLabel.text=[NSString stringWithFormat:@"%@¥%@",self.model.shop_type,self.model.goods_cost_price];
        //进度条
        [self.progressview setPersentNum:self.model.jindu.integerValue];
        //已售
        self.salesLabel.text = [NSString stringWithFormat:@"已售%@",self.model.goods_sales];
        [self.couponimview setUrlImg:self.model.taoqianggou_quan_img];
        
    }
     [self.contentView setNeedsLayout];
}
 
#pragma mark - set up view
- (void)setAllDistributeKQView{
    //Bgview
    self.BGView.sd_layout
    .topSpaceToView(self.contentView, 5).bottomSpaceToView(self.contentView, 5).leftSpaceToView(self.contentView, _jmsize_10/2).rightSpaceToView(self.contentView,_jmsize_10/2);
    //商品图片
     self.imgview.sd_layout
     .leftSpaceToView(self.BGView,_jmsize_10/2).centerYEqualToView(self.BGView).widthIs(90).heightIs(90);
    
    //商品标题
    self.desLabel.sd_layout
    .topSpaceToView(self.BGView,_jmsize_10).leftSpaceToView(self.imgview,_jmsize_10/2).rightSpaceToView(self.BGView, _jmsize_10/2).heightIs(15);
 
    //商品副标题
    self.subLabel.sd_layout
    .topSpaceToView(self.desLabel,_jmsize_10).leftSpaceToView(self.imgview,_jmsize_10/2).rightSpaceToView(self.BGView, _jmsize_10/2).heightIs(15);
 
    //优惠券
    self.couponimview.sd_layout
    .topSpaceToView(self.progressview, _jmsize_10).rightSpaceToView(self.BGView, _jmsize_10/2).heightIs(15).widthIs(self.couponimview.size.width);
     [self.couponLabel autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
    //进度条
    self.progressview.sd_layout
    .topSpaceToView(self.subLabel,_jmsize_10).leftSpaceToView(self.imgview,_jmsize_10/2).heightIs(self.progressview.height).widthIs(self.progressview.width);
    
    //商品价格
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgview.mas_right).offset(_jmsize_10/2);
        make.top.equalTo(self.progressview.mas_bottom).offset(_jmsize_10);
        make.height.equalTo(@20);
    }];
    [self.priceLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    //已售
    [self.BGView addSubview:self.salesLabel];
    [self.salesLabel autoSetDimensionsToSize:(CGSizeMake(self.progressview.width-15, self.progressview.height-4))];
    [self.salesLabel autoAlignAxis:(ALAxisHorizontal) toSameAxisOfView:self.progressview];
    [self.salesLabel autoAlignAxis:(ALAxisVertical) toSameAxisOfView:self.progressview];
    
    //其他价格
    [self.genrepriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel.mas_right).offset(_jmsize_10/2);
        make.top.equalTo(self.progressview.mas_bottom).offset(_jmsize_10);
        make.height.equalTo(@20);
    }];
    [self.genrepriceLabel setSingleLineAutoResizeWithMaxWidth:100];
}
-(void)setUpAllKQView{
    //Bgview
    _BGView = [UIView new];
    _BGView.backgroundColor=FNWhiteColor;
    _BGView.cornerRadius=5;
    [self.contentView addSubview:self.BGView];
    
    //商品图片
    _imgview = [UIImageView new];
    _imgview.contentMode = UIViewContentModeScaleAspectFit;
    _imgview.cornerRadius=5;
    [self.BGView addSubview:self.imgview];
    
    //已抢光 无商品 view
    _emptyView = [UIView new];
    _emptyView.backgroundColor = [FNBlackColor colorWithAlphaComponent:0.2];
    [_imgview addSubview:self.emptyView];
    [self.emptyView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
   
    //已抢光图片
    _emptyImageView = [[UIImageView alloc]init];
    _emptyImageView.image = IMAGE(@"home_soldout");
    _emptyImageView.contentMode = UIViewContentModeCenter;
    [_emptyView addSubview:self.emptyImageView];
    [self.emptyImageView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    
    //商品标题
    _desLabel = [UILabel new];
    _desLabel.font = kFONT14;
    [self.BGView addSubview:self.desLabel];
    
    
    //商品副标题
    _subLabel = [UILabel new];
    _subLabel.font = kFONT12;
    _subLabel.textColor=RED;
    [self.BGView addSubview:self.subLabel];
    
    
    //优惠券
    _couponimview = [[UIImageView alloc]initWithImage:IMAGE(@"rob_quan_bj")];
    [self.BGView addSubview:self.couponimview];
    
    //优惠券文字
    _couponLabel = [UILabel new];
    _couponLabel.textColor = FNWhiteColor;
    _couponLabel.font = kFONT10;
    _couponLabel.textAlignment = NSTextAlignmentCenter;
    [_couponimview addSubview:self.couponLabel];
   
    
    //进度条
    _progressview = [[JMProgressView alloc]initWithFrame:(CGRectMake(0, 0, JMScreenWidth*0.33, 15))];
    _progressview.bgColor =FNColor(255, 204, 211);
    _progressview.highlightedColor =FNColor(252, 90, 142);
    _progressview.maxNum = 100;
    _progressview.cornerRadius=15/2;
    [self.BGView addSubview:self.progressview];
    
    
    //已售
    _salesLabel = [UILabel new];
    _salesLabel.font = [UIFont systemFontOfSize:10];
    _salesLabel.textColor = FNWhiteColor;
    [self.BGView addSubview:self.salesLabel];
    
    //商品价格
    _priceLabel = [UILabel new];
    _priceLabel.font = [UIFont systemFontOfSize:12];
    _priceLabel.textColor = RED;
    _priceLabel.adjustsFontSizeToFitWidth = YES;
    [self.BGView addSubview:self.priceLabel];
    
    //其他价格
    _genrepriceLabel = [UILabel new];
    _genrepriceLabel.font = [UIFont systemFontOfSize:12];
    _genrepriceLabel.textColor = GrayColor;
    _genrepriceLabel.adjustsFontSizeToFitWidth = NO;
    [self.BGView addSubview:self.genrepriceLabel];
    
    
    [self setAllDistributeKQView];
    
}

#pragma mark - public, get instance

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
         self.backgroundColor=FNColor(246, 246, 246);
        [self setUpAllKQView];
    }
    return self;
}


@end
