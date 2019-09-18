//
//  FNRushToPurchaseNoCell.m
//  THB
//
//  Created by Jimmy on 2018/9/14.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNRushToPurchaseNoCell.h"
#define _plt_cell_height 120
@interface FNRushToPurchaseNoCell()

@property (nonatomic, strong) UIView* BGView;
@property (nonatomic, strong) UIImageView* imgview;
@property (nonatomic, strong) UIView* emptyView;
@property (nonatomic, strong) UIImageView* emptyImageView;
@property (nonatomic, strong) UILabel* desLabel;
@property (nonatomic, strong) UILabel* subLabel;
@property (nonatomic, strong) UILabel* salesLabel;
@property (nonatomic, strong) UILabel* priceTLabel;
@property (nonatomic, strong) UIImageView* couponimview;
@property (nonatomic, strong) UILabel* couponLabel;
@property (nonatomic, strong) UIImageView* operationview;
@property (nonatomic, strong) UILabel* genrepriceLabel;

@end

@implementation FNRushToPurchaseNoCell 


- (void)setModel:(FNBaseProductModel *)model{
    _model = model;
    if (_model) {
        //商品图片
        [self.imgview setUrlImg:_model.goods_img];
        //商品标题
        self.desLabel.text = self.model.goods_title;
        [self.desLabel HttpLabelLeftImage:self.model.shop_img label:self.desLabel imageX:0 imageY:-1.5 imageH:13 atIndex:0];
        //返
//        NSInteger commission=[model.fcommission integerValue];
//        if(commission>0){
            self.subLabel.text =[NSString stringWithFormat:@"%@:¥%@",model.fan_all_str,model.fcommission];
//        }
        //已抢光view
        _emptyView.hidden = !_model.is_qiangguang.boolValue;
        NSString *originalprice=[NSString stringWithFormat:@"¥%@",self.model.goods_price];
        //描述
        self.salesLabel.text = self.model.miaoshu;
        self.priceTLabel.text = originalprice;
        NSString* price = self.model.goods_price;
        if ([self.priceTLabel.text containsString:price]) {
            [self.priceTLabel addSingleAttributed:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} ofRange:[self.priceTLabel.text rangeOfString:price]];
        }
        //其他价格
        self.genrepriceLabel.text=[NSString stringWithFormat:@"%@¥%@",self.model.shop_type,self.model.goods_cost_price];
        NSInteger remind=[self.model.remind integerValue];
        if(remind==1){
          [self.couponimview setUrlImg:self.model.taoqianggou_cancelremind_img];
        }else{
          [self.couponimview setUrlImg:self.model.taoqianggou_remind_img];
        }
    }
    //[self.contentView updateLayout];
}
-(void)setUpAllView{
    //背景view
    _BGView = [UIView new];
    _BGView.backgroundColor=FNWhiteColor;
    _BGView.cornerRadius=5;
    [self.contentView addSubview:_BGView];
    //商品图片
    _imgview = [UIImageView new];
    _imgview.contentMode = UIViewContentModeScaleAspectFit;
    _imgview.cornerRadius=5;
    [_BGView addSubview:_imgview];
    
    //已抢光 无商品时显示
    _emptyView = [UIView new];
    _emptyView.backgroundColor = [FNBlackColor colorWithAlphaComponent:0.2];
    [_imgview addSubview:_emptyView];
    [self.emptyView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    //已抢光图片
    _emptyImageView = [[UIImageView alloc]init];
    _emptyImageView.image = IMAGE(@"home_soldout");
    _emptyImageView.contentMode = UIViewContentModeCenter;
    [_emptyView addSubview:_emptyImageView];
    [self.emptyImageView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    //商品标题
    _desLabel = [UILabel new];
    _desLabel.font = kFONT14;
    [self.BGView addSubview:self.desLabel];
    
    //商品副标题
    _subLabel = [UILabel new];
    _subLabel.font = kFONT11;
    _subLabel.textColor=RED;
    [self.BGView addSubview:self.subLabel];
    
    //优惠券
    _couponimview = [[UIImageView alloc]initWithImage:IMAGE(@"btn_off")];
    _couponimview.size=CGSizeMake(55, 25);
    _couponimview.userInteractionEnabled = YES;
    UITapGestureRecognizer *couponimtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(couponimtapClick)];
    [_couponimview addGestureRecognizer:couponimtap];
    [self.BGView addSubview:self.couponimview];
    
    //商品价格
    _priceTLabel = [UILabel new];
    _priceTLabel.font =[UIFont systemFontOfSize:12];
    _priceTLabel.textColor = RED;
    _priceTLabel.adjustsFontSizeToFitWidth = YES;
    [self.BGView addSubview:self.priceTLabel];
    
    //其他价格
    _genrepriceLabel = [UILabel new];
    _genrepriceLabel.font = [UIFont systemFontOfSize:12];
    _genrepriceLabel.textColor = GrayColor;
    _genrepriceLabel.adjustsFontSizeToFitWidth = NO;
    [self.BGView addSubview:self.genrepriceLabel];
    
    //描述
    _salesLabel = [UILabel new];
    _salesLabel.font = kFONT11;
    _salesLabel.textColor = FNColor(255, 177, 45);
    [self.BGView addSubview:self.salesLabel];
    
    [self setAllDistributeView];
}
#pragma mark - set up view
- (void)setAllDistributeView{
    
    //背景view
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
    
    //描述
    self.salesLabel.sd_layout
    .topSpaceToView(self.subLabel,_jmsize_10).leftSpaceToView(self.imgview,_jmsize_10/2).heightIs(15)
    .rightSpaceToView(self.BGView,_jmsize_10/2).heightIs(15);
    
    //优惠券
    [self.couponimview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.BGView.mas_right).offset(-(_jmsize_10/2));
        make.top.equalTo(self.salesLabel.mas_bottom).offset(_jmsize_10);
        make.height.equalTo(@25);
        make.width.equalTo(@55);
    }];
    //商品价格
    [self.priceTLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgview.mas_right).offset(_jmsize_10/2);
        make.top.equalTo(self.salesLabel.mas_bottom).offset(_jmsize_10);
        make.height.equalTo(@20);
        
    }];
    [self.priceTLabel setSingleLineAutoResizeWithMaxWidth:100];
    //其他价格
    [self.genrepriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceTLabel.mas_right).offset(_jmsize_10/2);
        make.top.equalTo(self.salesLabel.mas_bottom).offset(_jmsize_10);
        make.height.equalTo(@20);
    }];
    [self.genrepriceLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    

    
   
}
#pragma mark - public, get instance

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor=FNColor(246, 246, 246);
        [self setUpAllView];
    }
    return self;
}
-(void)couponimtapClick{
    if (self.ActionAdmonishNow) {
        self.ActionAdmonishNow(self.model);
    }
}


@end
