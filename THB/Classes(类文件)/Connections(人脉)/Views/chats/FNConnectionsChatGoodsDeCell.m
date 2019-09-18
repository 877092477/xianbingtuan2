//
//  FNConnectionsChatGoodsDeCell.m
//  THB
//
//  Created by Jimmy on 2019/2/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConnectionsChatGoodsDeCell.h"

@interface FNConnectionsChatGoodsDeCell()

@property (nonatomic, strong) UIActivityIndicatorView *loading;
@property (nonatomic, strong) UIButton *btnResend;

@end

@implementation FNConnectionsChatGoodsDeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void) configUI {
    _imgHeader = [[UIImageView alloc] init];
    
    _loading = [[UIActivityIndicatorView alloc] init];
    _btnResend = [[UIButton alloc] init];
    
    [self.contentView addSubview:_imgHeader];
    [self.contentView addSubview:_loading];
    [self.contentView addSubview:_btnResend];
    
    @weakify(self)
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.width.height.mas_equalTo(40);
        make.bottom.lessThanOrEqualTo(@-65);
    }];
    
    [_loading mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(@0);
    }];
    [_btnResend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self_weak_.loading);
    }];
    
    self.backgroundColor = UIColor.clearColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _loading.color = UIColor.grayColor;
    
    [_btnResend setImage:IMAGE(@"connections_chat_resend") forState:UIControlStateNormal];
    [_btnResend addTarget:self action:@selector(onResend)];
    
    _imgHeader.cornerRadius = 20;
    
    self.bgView=[[UIImageView alloc]init];
//    self.bgView.cornerRadius=4;
//    self.bgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.bgView];
    
    self.goodsImg=[UIImageView new];
    [self.bgView addSubview:self.goodsImg];
    
    self.nameLB=[UILabel new];
    self.nameLB.font=kFONT14;
    self.nameLB.numberOfLines=2;
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:self.nameLB];
    
    self.sumLB=[UILabel new];
    self.sumLB.font=kFONT12;
    self.sumLB.textColor=RGB(185, 185, 185);
    self.sumLB.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:self.sumLB];
    
    self.soldLB=[UILabel new];
    self.soldLB.font=kFONT11;
    self.sumLB.textColor=RGB(185, 185, 185);
    self.soldLB.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:self.soldLB];
    
    self.estimateLB=[UILabel new];
    self.estimateLB.font=[UIFont systemFontOfSize:9];
    self.estimateLB.textAlignment=NSTextAlignmentCenter;
    self.estimateLB.textColor=RGB(239, 98, 112);
    self.estimateLB.backgroundColor=RGB(247, 226, 228);
    [self.bgView addSubview:self.estimateLB];
    
    self.ticketImg=[UIImageView new];
    [self.bgView addSubview:self.ticketImg];
    
    self.ticketLB=[UILabel new];
    self.ticketLB.font=[UIFont systemFontOfSize:9];
    self.ticketLB.textAlignment=NSTextAlignmentLeft;
    [self.ticketImg addSubview:self.ticketLB];
    [self incomposition:YES];
}
-(void)incomposition:(BOOL)isLeft{
    CGFloat inter_10=10;
    if(isLeft){
        self.bgView.sd_layout
        .leftSpaceToView(self,60).rightSpaceToView(self,40).topSpaceToView(self, 10).bottomSpaceToView(self, 10);
    }else{
        self.bgView.sd_layout
        .leftSpaceToView(self,40).rightSpaceToView(self,60).topSpaceToView(self, 10).bottomSpaceToView(self, 10);
    }
    
    self.goodsImg.sd_layout
    .centerYEqualToView(self.bgView).leftSpaceToView(self.bgView,5).widthIs(85).heightIs(85);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.goodsImg, inter_10).topEqualToView(self.goodsImg).rightSpaceToView(self.bgView, inter_10).heightIs(35);
    
    self.sumLB.sd_layout
    .leftSpaceToView(self.goodsImg, inter_10).topSpaceToView(self.nameLB, 0).rightSpaceToView(self.bgView, inter_10).heightIs(20);
    
    self.soldLB.sd_layout
    .leftSpaceToView(self.goodsImg, inter_10).topSpaceToView(self.sumLB, 0).rightSpaceToView(self.bgView, inter_10).heightIs(20);
    
    self.estimateLB.sd_layout
    .rightSpaceToView(self.bgView, inter_10).bottomSpaceToView(self.bgView, inter_10).widthIs(85).heightIs(15);
    
    self.ticketImg.sd_layout
    .leftSpaceToView(self.goodsImg, inter_10).bottomSpaceToView(self.bgView, inter_10).widthIs(45).heightIs(15);
    
    self.ticketLB.sd_layout
    .leftSpaceToView(self.ticketImg,0).rightSpaceToView(self.ticketImg,0).topSpaceToView(self.ticketImg, 0).bottomSpaceToView(self.ticketImg, 0);
    
}


-(void)setwithHeader:(NSString*)imgUrl isLeft:(BOOL)isLeft withStatus: (int)status {
    [_imgHeader sd_setImageWithURL:URL(imgUrl)];
    
    if (status == 1) {
        _loading.hidden = NO;
        [_loading startAnimating];
    } else {
        _loading.hidden = YES;
        [_loading stopAnimating];
    }

    _btnResend.hidden = status != 2;
    _bgView.image = isLeft ? IMAGE(@"connections_chat_message_left") : IMAGE(@"connections_chat_message_right");
    
    @weakify(self)
    if (isLeft) {
        [_imgHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.top.equalTo(@10);
            make.width.height.mas_equalTo(40);
            make.bottom.lessThanOrEqualTo(@-65);
        }];
        [_loading mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.centerY.equalTo(@0);
        }];
    } else {
        [_imgHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.top.equalTo(@10);
            make.width.height.mas_equalTo(40);
            make.bottom.lessThanOrEqualTo(@-65);
        }];
        [_loading mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.centerY.equalTo(@0);
        }];
    }
    [self incomposition:isLeft];
}
-(void)setModel:(FNChatGoodsModel *)model{
    _model=model;
    if(model){
        [self.goodsImg setUrlImg:model.goods_img];
        self.nameLB.text=[NSString stringWithFormat:@" %@",model.goods_title];
        if([model.shop_img kr_isNotEmpty]){
            [self.nameLB HttpLabelLeftImage:model.shop_img label:self.nameLB imageX:0 imageY:-1.5 imageH:14 atIndex:0];
        } 
        
        NSString* coupon = @"";
        if([model.goods_price kr_isNotEmpty]){
            coupon = [NSString stringWithFormat:@"¥%@%@",model.goods_price,@"  "];
        }
        NSString* importString=@"";
        if([model.pdd integerValue]==1){
            importString=@"拼多多价";
        }else if([model.jd integerValue]==1){
            importString=@"京东价";
        }else if([model.shop_id integerValue]==1){
            importString=@"淘宝价";
        }else if([model.shop_id integerValue]==2){
            importString=@"天猫价";
        }
        NSString* price = [NSString stringWithFormat:@"¥%@%@",importString,model.goods_cost_price];
        self.sumLB.text =[NSString stringWithFormat:@"%@%@",coupon,price];
        if ([coupon kr_isNotEmpty]) {
            [self.sumLB addSingleAttributed:@{NSForegroundColorAttributeName:RGB(239, 98, 112)} ofRange:[self.sumLB.text rangeOfString:coupon]];
        }
        
        self.soldLB.text= [NSString stringWithFormat:@"已售%@",model.goods_sales];;
        
        self.estimateLB.text=model.fcommission_str;
        
        [self.ticketImg setNoPlaceholderUrlImg:model.goodsbank_quan_img];
        
        NSString *ticketString=[NSString stringWithFormat:@"%@ ¥%@",model.quan_str,model.yhq_price];
        
        self.ticketLB.text=[NSString stringWithFormat:@" %@  ¥%@",model.quan_str,model.yhq_price];
        
        self.ticketLB.textColor=[UIColor colorWithHexString:model.quan_color];
        
        CGFloat inter_10=10;
        CGFloat ticketW=[self getWidthWithText:ticketString height:15 font:9];
        CGFloat estimateW=[self getWidthWithText:self.estimateLB.text height:15 font:9];
        if(ticketW<45){
            ticketW=45;
        }
        self.ticketImg.sd_layout
        .leftSpaceToView(self.goodsImg, inter_10).bottomSpaceToView(self.bgView, inter_10).widthIs(ticketW).heightIs(15);
        self.ticketLB.sd_layout
        .leftSpaceToView(self.ticketImg,0).rightSpaceToView(self.ticketImg,0).topSpaceToView(self.ticketImg, 0).bottomSpaceToView(self.ticketImg, 0);
        
        self.estimateLB.sd_layout
        .rightSpaceToView(self.bgView, inter_10).bottomSpaceToView(self.bgView, inter_10).widthIs(estimateW+10).heightIs(15);
        NSInteger yhqInt=[model.yhq integerValue];
        if (yhqInt==0) {
            self.ticketImg.hidden=YES;
            self.ticketLB.hidden=YES;
        }else{
            self.ticketImg.hidden=NO;
            self.ticketLB.hidden=NO;
        }
        
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


- (void)onResend {
    if ([_delegate respondsToSelector:@selector(didchatCellResendSelect:)]) {
        [_delegate didchatCellResendSelect:self];
    }
}

@end
