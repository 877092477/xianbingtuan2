//
//  FNClienteleDeCell.m
//  THB
//
//  Created by Jimmy on 2018/12/20.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNClienteleDeCell.h"

@implementation FNClienteleDeCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews{
    
    self.iconImageView=[[UIImageView alloc]init];
    [self addSubview:self.iconImageView];
    
    self.nameLB=[UILabel new];
    self.nameLB.textColor=FNBlackColor;
    self.nameLB.font=kFONT14;
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.nameLB];
    
    self.rightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.rightButton.titleLabel.font=kFONT12;
    [self addSubview:self.rightButton];
    self.rightButton.borderWidth=0.5;
    //self.rightButton.borderColor = FNGlobalTextGrayColor;
    self.rightButton.cornerRadius=5;
    self.rightButton.clipsToBounds = YES;
    [self.rightButton addTarget:self action:@selector(rightButtonClick)];
    
    CGFloat inter_15=15;
    CGFloat inter_10=10;
    
    self.iconImageView.sd_layout
    .leftSpaceToView(self, inter_15).widthIs(40).heightIs(40).centerYEqualToView(self);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.iconImageView, inter_10).heightIs(20).centerYEqualToView(self);
    [self.nameLB setSingleLineAutoResizeWithMaxWidth:180];
    
    self.rightButton.sd_layout
    .rightSpaceToView(self, inter_15).heightIs(30).widthIs(70).centerYEqualToView(self);
}
-(void)setModel:(FNclienteleDeModel *)model{
    _model=model;
    if(model){
        [self.iconImageView setUrlImg:model.img];
        
        [self.rightButton setTitle:model.btn_str forState:UIControlStateNormal];
        self.rightButton.borderColor = [UIColor colorWithHexString:model.btn_color];
        [self.rightButton setTitleColor:[UIColor colorWithHexString:model.btn_color] forState:UIControlStateNormal];
        NSString *typeString=model.type;
        NSString *jointString=@"";
        if([typeString isEqualToString:@"weixin"]){
            jointString=@"微信:";
        }
        if([typeString isEqualToString:@"qq"]){
            jointString=@"QQ:";
        }
        if([typeString isEqualToString:@"phone"]){
            jointString=@"电话:";
        }
        self.nameLB.text=[NSString stringWithFormat:@"%@%@",jointString,model.str];
        
    }
}

-(void)rightButtonClick{
    if ([self.delegate respondsToSelector:@selector(relationClienteleClick:)]) {
        [self.delegate relationClienteleClick:self.model];
    }
}
@end
