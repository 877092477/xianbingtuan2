//
//  FNUpgradegoodsNCell.m
//  THB
//
//  Created by Jimmy on 2018/9/25.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNUpgradegoodsNCell.h"
#import "FNUpgradeNMode.h"

@interface FNUpgradegoodsNCell()

@property (nonatomic, strong) UIImageView *imgFan;
@property (nonatomic, strong) UILabel *lblFan;

@property (nonatomic, strong) UIButton *grabBtn;

@end

@implementation FNUpgradegoodsNCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
    //商品图片
    self.GoodsImage=[UIImageView new];
    self.GoodsImage.contentMode=UIViewContentModeScaleToFill;
    self.GoodsImage.image=IMAGE(@"APP底图.png");
    self.GoodsImage.layer.cornerRadius = 10;
    [self.contentView addSubview:self.GoodsImage];
    
    //商品标题
    self.GoodsTitleLabel=[UILabel new];
    self.GoodsTitleLabel.numberOfLines=1;
    self.GoodsTitleLabel.textColor=FNBlackColor;
    self.GoodsTitleLabel.font=kFONT14;
    [self.contentView addSubview:self.GoodsTitleLabel];
    
    //原价
    self.originPriceLabel=[UILabel new];
    [self.originPriceLabel sizeToFit];
    self.originPriceLabel.textColor=FNColor(246, 71, 111);
    self.originPriceLabel.font=kFONT14;
    [self.contentView addSubview:self.originPriceLabel];
    
    //月销量
    self.countLabel=[UILabel new];
    [self.countLabel sizeToFit];
    self.countLabel.textColor=FNGlobalTextGrayColor;
    self.countLabel.font=kFONT12;
    [self.contentView addSubview:self.countLabel];
    
    //新品或其他
//    self.restsLabel=[UILabel new];
//    [self.restsLabel sizeToFit];
//    self.restsLabel.textColor=FNColor(246, 71, 111);
//    self.restsLabel.font=kFONT12;
//    self.restsLabel.cornerRadius=5/2;
//    [self.contentView addSubview:self.restsLabel];
    
    
    //邮费
    self.freightLabel=[UILabel new];
    [self.freightLabel sizeToFit];
    self.freightLabel.textColor=FNColor(246, 71, 111);
    self.freightLabel.font=kFONT12;
    self.freightLabel.cornerRadius=5/2;
    [self.contentView addSubview:self.freightLabel];
    
    //优惠之类
    self.discountsLabel=[UILabel new];
    [self.discountsLabel sizeToFit];
    self.discountsLabel.textColor=FNColor(246, 71, 111);
    self.discountsLabel.font=kFONT12;
    self.discountsLabel.cornerRadius=5/2;
    [self.GoodsImage addSubview:self.discountsLabel];
    
    //优选
    self.optimizationLB=[UILabel new];
    [self.optimizationLB sizeToFit];
    self.optimizationLB.font=kFONT12;
    [self.contentView addSubview:self.optimizationLB];
    self.optimizationLB.cornerRadius=5/2;
 
    self.discountsLabel.textAlignment=NSTextAlignmentCenter;
    self.countLabel.textAlignment=NSTextAlignmentCenter;
    self.freightLabel.textAlignment=NSTextAlignmentCenter;
    self.GoodsImage.cornerRadius=5/2;
    
    self.imgFan = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgFan];
    
    self.lblFan = [[UILabel alloc] init];
    self.lblFan.font = kFONT11;
    [self.imgFan addSubview:self.lblFan];
    
    self.grabBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.grabBtn setTitleColor:FNWhiteColor forState:UIControlStateNormal];
    //self.grabBtn.backgroundColor=RGB(244, 62, 121);
    self.grabBtn.titleLabel.font=kFONT12;
    self.grabBtn.cornerRadius=5;
    [self.grabBtn addTarget:self action:@selector(grabBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.grabBtn];
    
    
    [self initializedSubviews];
}
#pragma mark - initializedSubviews
- (void)initializedSubviews {
    
    //CGFloat w = FNDeviceWidth/3;
    CGFloat interval_10 = 10;
    //商品图片
    [self.GoodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@18);
        make.width.height.mas_equalTo(100);
        make.centerY.equalTo(@0);
    }];
    
    //商品标题
    self.GoodsTitleLabel.sd_layout
    .topSpaceToView(self.contentView, interval_10).leftSpaceToView(self.GoodsImage, 15).rightSpaceToView(self.contentView, interval_10).heightIs(20);
    
    [self.imgFan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.GoodsTitleLabel.mas_bottom).offset(14);
        make.left.equalTo(self.GoodsImage.mas_right).offset(15);
        make.height.mas_equalTo(14);
    }];
    
    [self.lblFan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgFan).offset(5);
        make.right.equalTo(self.imgFan).offset(-5);
        make.center.equalTo(self.imgFan);
    }];
    
    [self.freightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-15);
        make.centerY.equalTo(self.imgFan);
        make.left.greaterThanOrEqualTo(self.imgFan.mas_right).offset(10);
    }];
    //原价
    [self.originPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.GoodsImage.mas_right).offset(15);
        make.top.equalTo(self.imgFan.mas_bottom).offset(12);
        make.right.lessThanOrEqualTo(@-15);
    }];
    //月销量
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.GoodsImage.mas_right).offset(15);
        make.bottom.equalTo(self.GoodsImage);
//        make.right.lessThanOrEqualTo(@-15);
    }];
    //优惠之类
    self.discountsLabel.sd_layout
    .bottomSpaceToView(self.GoodsImage, 0).leftSpaceToView(self.GoodsImage, 0).heightIs(20).rightSpaceToView(self.GoodsImage, 0);
    
    self.optimizationLB.sd_layout
    .topSpaceToView(self.contentView, interval_10).leftSpaceToView(self.GoodsImage, interval_10).heightIs(20);
    [self.optimizationLB setSingleLineAutoResizeWithMaxWidth:60];
   
    
    [self.grabBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(25);
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self.GoodsImage);
    }];
    
    [self.grabBtn.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@20);
        make.right.equalTo(self.grabBtn.mas_right).offset(-5);
    }];
    [self.grabBtn.titleLabel setSingleLineAutoResizeWithMaxWidth:(90)];
    
    [self.grabBtn.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.width.mas_equalTo(11);
        make.centerY.equalTo(self.grabBtn);
        make.left.equalTo(self.grabBtn).offset(7);
        make.right.equalTo(self.grabBtn.titleLabel.mas_left).offset(-4);
    }];
    
}
-(void)setModel:(FNRecommendNMode *)model{
    _model=model;
    if(model){
        [self.GoodsImage setUrlImg:model.img];
        self.GoodsTitleLabel.text=[NSString stringWithFormat:@"%@ %@",model.label1,model.title];
        //self.GoodsTitleLabel.text=@"邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费邮费了杜拉拉";
//        self.restsLabel.text=[NSString stringWithFormat:@"%@",model.label3];
//        self.restsLabel.backgroundColor=[UIColor colorWithHexString:model.label_bjcolor3];
//        self.restsLabel.textColor=[UIColor colorWithHexString:model.label_fontcolor3];
//        self.freightLabel.backgroundColor=[UIColor colorWithHexString:@"FFB76A"];
        self.freightLabel.textColor=RGB(255, 134, 0) ;
        
        self.discountsLabel.backgroundColor=[UIColor colorWithHexString:model.label_bjcolor2];
        self.discountsLabel.textColor=[UIColor colorWithHexString:model.label_fontcolor2];
        self.freightLabel.text=[NSString stringWithFormat:@"邮费¥ %@",model.postage];
        self.originPriceLabel.text=[NSString stringWithFormat:@"¥%@",model.price];
        self.countLabel.text=[NSString stringWithFormat:@"月销%@",model.goods_sales];
        self.discountsLabel.text=model.label2;
        self.optimizationLB.text=model.label1;
        self.optimizationLB.backgroundColor=[UIColor colorWithHexString:model.label_bjcolor1];
        self.optimizationLB.textColor=[UIColor colorWithHexString:model.label_fontcolor1];
        
        @weakify(self)
        [self.imgFan sd_setImageWithURL:URL(model.goods_fanli_bjimg) placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            @strongify(self)
            if(image){
                self.lblFan.text = model.f_str;
                self.lblFan.textColor = [UIColor colorWithHexString: model.goodsfcommissionstr_color];
            }
        }];
        self.imgFan.hidden = ![model.f_str kr_isNotEmpty];
        self.lblFan.hidden = ![model.f_str kr_isNotEmpty];
        
        if([model.fxz kr_isNotEmpty]){
            self.grabBtn.hidden = NO;
            [self.grabBtn sd_setImageWithURL:URL(model.goods_sharebtn_bjico) forState:UIControlStateNormal];
            [self.grabBtn setTitle:model.fxz forState:UIControlStateNormal];
            //                [self.grabBtn addTarget:self action:@selector(shareBtnMethod)];
            [self.grabBtn setTitleColor: [UIColor colorWithHexString:model.goodssharestr_btncolor] forState:UIControlStateNormal];
            [self.grabBtn sd_setBackgroundImageWithURL:URL(model.goods_sharebtn_bjimg) forState:UIControlStateNormal];
        } else{
            self.grabBtn.hidden = YES;
        }
    }
}

#pragma mark - Action
- (void)grabBtnAction {
    if ([_delegate respondsToSelector:@selector(cellDidShareClick:)]) {
        [_delegate cellDidShareClick:self];
    }
}
@end
