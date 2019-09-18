//
//  FNtendOrderItemDaNeCell.m
//  69橙子
//
//  Created by Jimmy on 2018/12/6.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNtendOrderItemDaNeCell.h"

@interface FNtendOrderItemDaNeCell()

@property (nonatomic, strong) UIButton *confirmButton;

@end

@implementation FNtendOrderItemDaNeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=FNWhiteColor;
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
    self.contentView.backgroundColor=FNColor(240,240,240);
    self.bgView=[[UIView alloc]init];
    self.bgView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    //时间
    self.dateLB=[UILabel new];
    self.dateLB.font=kFONT11;
    self.dateLB.textColor=RGB(140, 140, 140);
    self.dateLB.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:self.dateLB];
    //状态
    self.stateLB=[UILabel new];
    self.stateLB.font=kFONT11;
    self.stateLB.textColor=RGB(140, 140, 140);
    self.stateLB.textAlignment=NSTextAlignmentRight;
    [self.bgView addSubview:self.stateLB];
    //商品图片
    self.goodsImage=[UIImageView new];
    //self.goodsImage.backgroundColor=[UIColor lightGrayColor];
    //self.goodsImage.contentMode=UIViewContentModeScaleToFill;
    //self.goodsImage.image=IMAGE(@"btn__more_nor");
    [self.bgView addSubview:self.goodsImage];
    //商品名字
    self.nameLB=[UILabel new];
    self.nameLB.font=kFONT14;
    [self.bgView addSubview:self.nameLB];
    //商品简介
    self.messageLB=[UILabel new];
    self.messageLB.font=kFONT12;
    self.messageLB.textColor=RGB(140, 140, 140);
    [self.bgView addSubview:self.messageLB];
    //商品价格
    self.priceLB=[UILabel new];
    self.priceLB.font=kFONT16;
    [self.bgView addSubview:self.priceLB];
    //预计
    self.predictLB=[UILabel new];
    self.predictLB.font=kFONT12;
    self.predictLB.textColor=RGB(255, 93, 93);
    [self.bgView addSubview:self.predictLB];
    //点击
    self.seletedButton= [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.seletedButton];
    [self.seletedButton setTitleColor:RGB(255, 155, 48) forState:UIControlStateNormal];
    [self.seletedButton addTarget:self action:@selector(seletedButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    self.seletedButton.backgroundColor=RGB(255, 155, 48);
//    self.seletedButton.cornerRadius=28/2;
    self.seletedButton.titleLabel.font=kFONT11;
    
    self.cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.cancleButton];
    [self.cancleButton setTitle:@"取消订单" forState:UIControlStateNormal];
    [self.cancleButton setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    self.cancleButton.layer.cornerRadius = 14;
    self.cancleButton.layer.borderWidth = 1;
    self.cancleButton.layer.borderColor = RGB(153, 153, 153).CGColor;
    self.cancleButton.titleLabel.font=kFONT11;
    [self.cancleButton addTarget:self action:@selector(cancleButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.confirmButton];
    [self.confirmButton setTitle:@"确认送达" forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    self.confirmButton.layer.cornerRadius = 14;
    self.confirmButton.layer.borderWidth = 1;
    self.confirmButton.layer.borderColor = RGB(153, 153, 153).CGColor;
    self.confirmButton.titleLabel.font=kFONT11;
    [self.confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.confirmButton.hidden = YES;
    
    [self placeViewFrame];
}
-(void)placeViewFrame{
    CGFloat space_10=10;
    CGFloat space_5=5;
    self.bgView.sd_layout
    .topSpaceToView(self.contentView, space_10).leftSpaceToView(self.contentView, space_10).rightSpaceToView(self.contentView, space_10).bottomSpaceToView(self.contentView, space_10);
    
    self.dateLB.sd_layout
    .topSpaceToView(self.bgView, space_10).leftSpaceToView(self.bgView, space_10).heightIs(20);
    [self.dateLB setSingleLineAutoResizeWithMaxWidth:180];
    
    self.stateLB.sd_layout
    .topSpaceToView(self.bgView, space_10).rightSpaceToView(self.bgView, space_10).heightIs(20);
    [self.stateLB setSingleLineAutoResizeWithMaxWidth:160];
    
    self.goodsImage.sd_layout
    .topSpaceToView(self.dateLB, space_10).leftSpaceToView(self.bgView, space_10).heightIs(87).widthIs(96);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.goodsImage, space_10).heightIs(20).topEqualToView(self.goodsImage).rightSpaceToView(self.bgView, space_10);
    
    self.messageLB.sd_layout
    .leftSpaceToView(self.goodsImage, space_10).heightIs(15).topSpaceToView(self.nameLB, space_5).rightSpaceToView(self.bgView, space_10);
    
    self.seletedButton.sd_layout
    .bottomEqualToView(self.goodsImage).widthIs(40).heightIs(28).rightSpaceToView(self.cancleButton, space_10);
    
    self.cancleButton.sd_layout
    .bottomEqualToView(self.goodsImage).widthIs(70).heightIs(28).rightSpaceToView(self.bgView, space_10);
    
    self.confirmButton.sd_layout
    .bottomSpaceToView(self.cancleButton, space_5).widthIs(70).heightIs(28).rightSpaceToView(self.bgView, space_10);
    
    self.predictLB.sd_layout
    .leftSpaceToView(self.goodsImage, space_10).heightIs(15).bottomEqualToView(self.goodsImage).rightSpaceToView(self.seletedButton, space_5);
    
    self.priceLB.sd_layout
    .leftSpaceToView(self.goodsImage, space_10).heightIs(20).bottomSpaceToView(self.predictLB, space_5).rightSpaceToView(self.seletedButton, space_5);
    
    
    
}
-(void)setModel:(FNtendOderItemNeModel *)model{
    _model=model;
    if(model){
        [self.goodsImage setUrlImg:model.img];
        self.dateLB.text= [NSString stringWithFormat:@"下单时间：%@",[NSString getTimeStr:self.model.createDate]];//@"下单时间: 2018-11-21 15:58:05";
        self.stateLB.text=model.type;//@"请在15分钟内完成付款";
        self.nameLB.text=model.store_name;//@"虾兵蟹将海鲜自助餐";
        self.messageLB.text=model.content;//@"海鲜下午单人自助餐 等一件商品";
        self.priceLB.text=model.payment;//@"¥28.8";
        self.predictLB.text=model.str;//@"预估可得赏金¥8.9";
        [self.seletedButton setTitle:model.status forState:UIControlStateNormal];
//        self.seletedButton.backgroundColor=[UIColor colorWithHexString:model.color];
        [self.seletedButton setTitleColor:[UIColor colorWithHexString:model.color] forState:UIControlStateNormal];
        
        self.confirmButton.hidden = ![model.confirm_service isEqualToString:@"1"];
        
        NSString *string = model.status ? model.status : @"";
        CGRect rect = [string boundingRectWithSize:(CGSizeMake(JMScreenWidth-60, 34)) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:kFONT11} context:nil];
        
        if ([model.apply_refund isEqualToString:@"1"] || [model.apply_refund isEqualToString:@"2"]) {
            self.cancleButton.hidden = NO;
            [self.cancleButton setTitle:[model.apply_refund isEqualToString:@"1"] ? @"取消订单" : @"取消申请" forState:UIControlStateNormal];
            self.seletedButton.sd_layout
            .bottomEqualToView(self.goodsImage).widthIs(rect.size.width + 20).heightIs(28).rightSpaceToView(self.cancleButton, 10);
        } else if ([model.has_comment isEqualToString:@"1"]) {
            self.cancleButton.hidden = NO;
            [self.cancleButton setTitle:@"评价" forState:UIControlStateNormal];
            self.seletedButton.sd_layout
            .bottomEqualToView(self.goodsImage).widthIs(rect.size.width + 20).heightIs(28).rightSpaceToView(self.cancleButton, 10);
        }
        else {
            self.cancleButton.hidden = YES;
            self.seletedButton.sd_layout
            .bottomEqualToView(self.goodsImage).widthIs(rect.size.width + 20).heightIs(28).rightSpaceToView(self.bgView, 10);
        }
    }
}
-(void)seletedButtonAction{
    if ([self.delegate respondsToSelector:@selector(InTendOrderItemAction:)]) {
        [self.delegate InTendOrderItemAction:self.indexPath];
    }
}

-(void)cancleButtonAction{
    
    if ([_model.apply_refund isEqualToString:@"1"] || [_model.apply_refund isEqualToString:@"2"]) {
        if ([self.delegate respondsToSelector:@selector(InTendOrderCancleAction:)]) {
            [self.delegate InTendOrderCancleAction:self.indexPath];
        }
    } else if ([_model.has_comment isEqualToString:@"1"]) {
        if ([self.delegate respondsToSelector:@selector(InTendOrderCommentAction:)]) {
            [self.delegate InTendOrderCommentAction:self.indexPath];
        }
    }
    
}

-(void)confirmButtonAction{

    if ([self.delegate respondsToSelector:@selector(InTendOrderConfirmAction:)]) {
        [self.delegate InTendOrderConfirmAction:self.indexPath];
    }

    
}
@end
