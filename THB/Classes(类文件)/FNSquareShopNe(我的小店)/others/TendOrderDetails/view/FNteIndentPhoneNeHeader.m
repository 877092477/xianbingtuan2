//
//  FNteIndentPhoneNeHeader.m
//  69橙子
//
//  Created by Jimmy on 2018/12/6.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//订单详情打电话
#import "FNteIndentPhoneNeHeader.h"

@implementation FNteIndentPhoneNeHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
    
    UIView *subgView=[[UIView alloc]init];
    subgView.backgroundColor=RGB(237, 237, 237);
    [self addSubview:subgView];
    subgView.sd_layout
    .topEqualToView(self).leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    UIView *bgView=[[UIView alloc]init];
    bgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:bgView];
    bgView.sd_layout
    .topEqualToView(self).leftSpaceToView(self, 10).rightSpaceToView(self, 10).bottomSpaceToView(self, 0);
    
    UIView *lineView=[[UIView alloc]init];
    lineView.backgroundColor=RGB(237, 237, 237);
    [self addSubview:lineView];
    lineView.sd_layout
    .leftSpaceToView(self, 10).rightSpaceToView(self, 10).bottomSpaceToView(self, 0).heightIs(10);
    
    
    self.topLineLb= [[UILabel alloc]init];
    self.topLineLb.backgroundColor=RGB(237, 237, 237);
    [self addSubview:self.topLineLb];
    
    self.phoneBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 10 , 20, 20)];
    //self.phoneBtn.backgroundColor=[UIColor cyanColor];
    [self.phoneBtn addTarget:self action:@selector(phoneBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.phoneBtn];
    
    self.relationBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 10 , 20, 20)];
    self.relationBtn.titleLabel.font=kFONT14;
    [self.relationBtn setTitleColor:RGB(47, 140, 255) forState:UIControlStateNormal];
    [self.relationBtn addTarget:self action:@selector(phoneBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.relationBtn];
    
    self.sumLb= [[UILabel alloc]init];
    self.sumLb.font=kFONT13;
    self.sumLb.textAlignment=NSTextAlignmentRight;
    [self addSubview:self.sumLb];
    [self compositionFrame];
}
-(void)compositionFrame{
    
    CGFloat space_20=20;
    CGFloat space_5=5;
    self.topLineLb.sd_layout
    .topEqualToView(self).leftSpaceToView(self, space_20).rightSpaceToView(self, space_20).heightIs(1);
    
    self.phoneBtn.sd_layout
    .centerYEqualToView(self).leftSpaceToView(self, space_20).widthIs(20).heightIs(20);
    
    self.relationBtn.sd_layout
    .centerYEqualToView(self).leftSpaceToView(self.phoneBtn, space_5).heightIs(20);
    [self.relationBtn setupAutoSizeWithHorizontalPadding:5 buttonHeight:20];
    
    self.sumLb.sd_layout
    .centerYEqualToView(self).heightIs(25).rightSpaceToView(self, space_20);
    [self.sumLb setSingleLineAutoResizeWithMaxWidth:150];
    
    [self.phoneBtn setImage:IMAGE(@"pay_photo") forState:UIControlStateNormal];
    [self.relationBtn setTitle:@"联系商家" forState:UIControlStateNormal];
    self.sumLb.text=@"实付 ¥ ";
    
}
-(void)phoneBtnAction{
    if ([self.delegate respondsToSelector:@selector(inTeIndentPhoneAction)]) {
        [self.delegate inTeIndentPhoneAction];
    }
}
-(void)setModel:(FNtendOrderDetailsDeModel *)model{
    _model=model;
    if(model){
        self.sumLb.text = [NSString stringWithFormat:@"实付 ¥%@", model.payment];
    }
    
}
@end
