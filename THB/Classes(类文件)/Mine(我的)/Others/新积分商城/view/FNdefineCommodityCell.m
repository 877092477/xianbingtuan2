//
//  FNdefineCommodityCell.m
//  THB
//
//  Created by Jimmy on 2019/1/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//
//130
#import "FNdefineCommodityCell.h"

@interface FNdefineCommodityCell()

@property (nonatomic, strong) UIImageView *imgFan;
@property (nonatomic, strong) UILabel *lblFan;

@end

@implementation FNdefineCommodityCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    self.backgroundColor=RGB(245, 245, 245);
    self.goodsImageView=[UIImageView new];
    self.goodsImageView.layer.cornerRadius = 10;
    self.goodsImageView.layer.masksToBounds = YES;
    [self addSubview:self.goodsImageView];
    
    self.nameLB=[UILabel new];
    self.nameLB.textColor=FNBlackColor;
    self.nameLB.font=kFONT14;
    self.nameLB.numberOfLines=1;
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.nameLB];
    
    self.imgFan = [[UIImageView alloc] init];
    [self addSubview: self.imgFan];
    
    self.lblFan = [[UILabel alloc] init];
    self.lblFan.font = kFONT11;
    [self addSubview: self.lblFan];
    
    self.priceLB=[UILabel new];
    [self.priceLB sizeToFit];
    self.priceLB.textColor=RGB(244, 62, 121);
    self.priceLB.font=kFONT15;
    self.priceLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.priceLB];
    
    self.rawLB=[UILabel new];
    [self.rawLB sizeToFit];
    self.rawLB.textColor=RGB(129, 128, 129);
    self.rawLB.font=[UIFont systemFontOfSize:12];
    self.rawLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.rawLB];
    
    self.grabBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.grabBtn setTitleColor:FNWhiteColor forState:UIControlStateNormal];
    //self.grabBtn.backgroundColor=RGB(244, 62, 121);
    self.grabBtn.titleLabel.font=kFONT12;
    self.grabBtn.cornerRadius=5;
    //[self.grabBtn addTarget:self action:@selector(grabBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.grabBtn];
    
    self.amountLB=[UILabel new];
    [self.amountLB sizeToFit];
    self.amountLB.textColor=RGB(129, 128, 129);
    self.amountLB.font=[UIFont systemFontOfSize:9];
    self.amountLB.textAlignment=NSTextAlignmentRight;
    [self addSubview:self.amountLB];
    
    self.tallyLB=[UILabel new];
    self.tallyLB.textColor=FNBlackColor;
    self.tallyLB.font=kFONT11;
    self.tallyLB.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.tallyLB];
    
//    self.line=[[UIView alloc]init];
//    self.line.backgroundColor=RGB(129, 128, 129);
//    [self addSubview:self.line];
    
    
    [self incomposition];
}

-(void)incomposition{
    CGFloat inter_13=17;
    CGFloat inter_10=10;
    CGFloat inter_7=7;
    CGFloat inter_5=5;
    
    self.goodsImageView.sd_layout
    .heightIs(110).widthIs(110).leftSpaceToView(self, inter_13).topSpaceToView(self, inter_10);
    
    self.nameLB.sd_layout
    .heightIs(20).leftSpaceToView(self.goodsImageView, inter_10).rightSpaceToView(self, inter_10).topSpaceToView(self, inter_10);
    
    [self.imgFan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImageView.mas_right).offset(inter_10);
        make.top.equalTo(self.nameLB.mas_bottom).offset(10);
        make.height.mas_equalTo(15);
//        make.width.mas_equalTo(0);
    }];
    
    [self.lblFan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgFan).offset(4);
        make.right.equalTo(self.imgFan).offset(-4);
        make.centerY.equalTo(self.imgFan);
    }];
    
    [self.priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImageView.mas_right).offset(inter_10);
        make.top.equalTo(self.imgFan.mas_bottom).offset(10);
    }];
//    self.priceLB.sd_layout
//    .heightIs(20).widthIs(100).leftSpaceToView(self.goodsImageView, inter_10).centerYEqualToView(self);
    
//    self.rawLB.sd_layout
//    .heightIs(20).widthIs(100).leftSpaceToView(self.priceLB, inter_7).centerYEqualToView(self);
    [self.rawLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLB.mas_right).offset(10);
        make.centerY.equalTo(self.priceLB);
        make.right.lessThanOrEqualTo(@-20);
        
    }];
    
//    self.line.sd_layout
//    .heightIs(1).widthIs(1).leftSpaceToView(self.priceLB, inter_5).centerYEqualToView(self.rawLB);
    
//    self.amountLB.sd_layout
//    .heightIs(12).leftSpaceToView(self.goodsImageView, inter_10).topSpaceToView(self.priceLB, inter_5);
    [self.amountLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-15);
//        make.top.equalTo(self.nameLB.mas_bottom).offset(16);
        make.centerY.equalTo(self.imgFan);
    }];
    [self.amountLB setSingleLineAutoResizeWithMaxWidth:150];
    
    [self.grabBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(25);
        make.right.equalTo(self).offset(-inter_10);
        make.bottom.equalTo(self.goodsImageView);
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
    
    self.tallyLB.sd_layout
    .heightIs(17).widthIs(60).leftSpaceToView(self.goodsImageView, inter_10).topSpaceToView(self.priceLB, inter_10);
    
}

-(void)setModel:(FNDefiniteProductModel *)model{
    _model=model;
    if(model){
        [self.goodsImageView setUrlImg:model.goods_img];
        self.nameLB.text=model.goods_title;
        self.priceLB.text=model.str;//@"24积分 + 16.9元";
        self.priceLB.textColor=[UIColor colorWithHexString:model.str_color];
//        self.rawLB.text=model.goods_cost_price;//@"￥289.0";
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:model.goods_cost_price attributes:attribtDic];
        self.rawLB.attributedText = attribtStr;
        
        self.amountLB.text=model.sales_str;
//        [self.grabBtn setTitle:model.btn_str forState:UIControlStateNormal];
//        [self.grabBtn setBackgroundColor:[UIColor colorWithHexString:model.btn_bjcolor]];
//        [self.grabBtn setTitleColor:[UIColor colorWithHexString:model.btn_color] forState:UIControlStateNormal];
        self.tallyLB.text=model.label;
        self.tallyLB.textColor=[UIColor colorWithHexString:model.label_color];
        self.tallyLB.borderWidth=0.5;
        self.tallyLB.borderColor=[UIColor colorWithHexString:model.label_color];
        self.tallyLB.cornerRadius=2;
        self.tallyLB.clipsToBounds = YES;
        
        @weakify(self)
        [self.imgFan sd_setImageWithURL:URL(model.goods_fanli_bjimg) placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            @strongify(self)
            if(image){
//                [self.imgFan mas_updateConstraints:^(MASConstraintMaker *make) {
//                    make.width.mas_equalTo(15 * image.size.width / image.size.height);
//                }];
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
                [self.grabBtn addTarget:self action:@selector(shareBtnMethod)];
            [self.grabBtn setTitleColor: [UIColor colorWithHexString:model.goodssharestr_btncolor] forState:UIControlStateNormal];
            [self.grabBtn sd_setBackgroundImageWithURL:URL(model.goods_sharebtn_bjimg) forState:UIControlStateNormal];
        } else{
            self.grabBtn.hidden = YES;
        }
        
        //CGFloat nameLBW=  [self getWidthWithText:self.nameLB.text height:17.5 font:13];
        CGFloat priceW=  [self getWidthWithText:self.priceLB.text height:20 font:10];
        CGFloat rawW=  [self getWidthWithText:self.rawLB.text height:20 font:12];
        CGFloat tallyLBW=  [self getWidthWithText:self.tallyLB.text height:17 font:11];
        CGFloat inter_10=10;
        CGFloat inter_7=7;
        CGFloat inter_5=5;
//        self.priceLB.sd_layout
//        .heightIs(20).widthIs(priceW).leftSpaceToView(self.goodsImageView, inter_10).centerYEqualToView(self);
//
//        self.rawLB.sd_layout
//        .heightIs(20).widthIs(rawW).leftSpaceToView(self.priceLB, inter_7).centerYEqualToView(self);
        
//        self.line.sd_layout
//        .heightIs(1).widthIs(rawW+4).leftSpaceToView(self.priceLB, inter_5).centerYEqualToView(self.rawLB);
        
        self.tallyLB.sd_layout
        .heightIs(17).widthIs(tallyLBW+10).leftSpaceToView(self.goodsImageView, inter_10).topSpaceToView(self.priceLB, inter_10);
    }
}
//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}


- (void)shareBtnMethod {
    if ([_delegate respondsToSelector:@selector(onShareClick:)]) {
        [_delegate onShareClick:self];
    }
}

@end
