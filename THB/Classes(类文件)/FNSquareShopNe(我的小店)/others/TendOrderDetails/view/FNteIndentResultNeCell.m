//
//  FNteIndentResultNeCell.m
//  69橙子
//
//  Created by Jimmy on 2018/12/6.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//下单结果 115
#import "FNteIndentResultNeCell.h"

@implementation FNteIndentResultNeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=FNWhiteColor;
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
    self.contentView.backgroundColor=[UIColor whiteColor];
    //标题
    self.titleLB=[UILabel new];
    self.titleLB.font=kFONT16; 
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLB];
    
    //致语
    self.sendLB=[UILabel new];
    self.sendLB.font=kFONT14;
    self.sendLB.textColor=RGB(140, 140, 140);
    self.sendLB.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:self.sendLB];
    
    //line
    self.lineLB=[UILabel new];
    self.lineLB.backgroundColor=RGB(245, 245, 245);
    [self.contentView addSubview:self.lineLB];
    
    //金额
    self.figureLB=[UILabel new];
    self.figureLB.font=kFONT14;
    self.figureLB.textColor=RGB(244, 47, 25);
    self.figureLB.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:self.figureLB];
    
    //点击
    self.recurButton= [UIButton buttonWithType:UIButtonTypeCustom];
    [self.recurButton setTitleColor:RGB(1, 172, 243) forState:UIControlStateNormal];
    [self.recurButton addTarget:self action:@selector(recurButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.recurButton.cornerRadius=5/2;
    self.recurButton.titleLabel.font=kFONT13;
    self.recurButton.borderWidth=0.5;
    self.recurButton.borderColor =RGB(1, 172, 243);
    [self.contentView addSubview:self.recurButton];
    
    self.cancleButton= [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancleButton setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    [self.cancleButton addTarget:self action:@selector(cancleButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.cancleButton.cornerRadius=5/2;
    self.cancleButton.titleLabel.font=kFONT13;
    self.cancleButton.borderWidth=0.5;
    self.cancleButton.borderColor =RGB(153, 153, 153);
    [self.contentView addSubview:self.cancleButton];
    
    [self placeViewFrame];
}
-(void)placeViewFrame{
    CGFloat space_20=20;
    CGFloat space_10=10;
    CGFloat space_5=5;
    
    self.lineLB.sd_layout
    .centerYEqualToView(self.contentView).leftSpaceToView(self.contentView, space_20).rightSpaceToView(self.contentView, space_20).heightIs(1);
    
    self.sendLB.sd_layout
    .bottomSpaceToView(self.lineLB, space_10).leftSpaceToView(self.contentView, space_20).rightSpaceToView(self.contentView, space_10).heightIs(15);
    
    self.titleLB.sd_layout
    .bottomSpaceToView(self.sendLB, space_5).leftSpaceToView(self.contentView, space_20).rightSpaceToView(self.contentView, space_10).heightIs(20);
    
    self.recurButton.sd_layout
    .topSpaceToView(self.lineLB, space_10+space_5).rightSpaceToView(self.contentView, space_20).heightIs(25).widthIs(65);
    
    self.cancleButton.sd_layout
    .topSpaceToView(self.lineLB, space_10+space_5).rightSpaceToView(self.recurButton, space_10).heightIs(25).widthIs(65);
    
    self.figureLB.sd_layout
    .centerYEqualToView(self.recurButton).leftSpaceToView(self.contentView, space_20).rightSpaceToView(self.cancleButton, space_10).heightIs(20);
    
    
    
}
-(void)setModel:(FNtendOrderDetailsDeModel *)model{
    _model=model;
    if(model){
        self.titleLB.text=model.str2;//@"下单成功";
        self.sendLB.text=model.str3;//@"感谢您的购物, 期待您的再次光临";
        self.figureLB.text=model.str;//@"获得赏金¥8.9";
        if ([model.t isEqualToString:@"1"]) {
            [self.recurButton setTitle:@"立即付款" forState:UIControlStateNormal];
        } else {
            [self.recurButton setTitle:@"再来一单" forState:UIControlStateNormal];
        }
        
        self.cancleButton.hidden = NO;
        if ([model.apply_refund isEqualToString:@"1"]) {
            [self.cancleButton setTitle:@"取消订单" forState: UIControlStateNormal];
        } else if ([model.apply_refund isEqualToString:@"2"]) {
            [self.cancleButton setTitle:@"取消申请" forState: UIControlStateNormal];
        } else {
            self.cancleButton.hidden = YES;
        }
        
    }
    
}
-(void)recurButtonAction{
    if ([_model.t isEqualToString:@"1"]) {
        if ([self.delegate respondsToSelector:@selector(inTeIndentPayAction)]) {
            [self.delegate inTeIndentPayAction];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(inTeIndentRecurAction)]) {
            [self.delegate inTeIndentRecurAction];
        }
    }
}

-(void)cancleButtonAction{
    if ([self.delegate respondsToSelector:@selector(inTeIndentCancleAction)]) {
        [self.delegate inTeIndentCancleAction];
    }
}
@end
