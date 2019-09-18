//
//  FNredPackageNaFooter.m
//  THB
//
//  Created by Jimmy on 2019/2/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNredPackageNaFooter.h"

@implementation FNredPackageNaFooter
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    self.backgroundColor=RGB(243, 243, 243);
    
    self.remarkLB=[[UILabel alloc]init];
    self.remarkLB.font=kFONT14;
    self.remarkLB.textColor=RGB(204, 204, 204);
    self.remarkLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.remarkLB];
    
    self.alterBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.alterBtn.titleLabel.font=kFONT14;
    [self.alterBtn setTitleColor:RGB(51, 102, 255) forState:UIControlStateNormal];
    [self.alterBtn setTitle:@"改为拼手气红包" forState:UIControlStateNormal];
    //[self.alterBtn setTitle:@"改为拼普通红包" forState:UIControlStateSelected];
    [self.alterBtn addTarget:self action:@selector(alterBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.alterBtn];
    
    [self incomposition];
    
}
-(void)incomposition{
    
    CGFloat inter_10=10;
    CGFloat inter_20=20;
    CGFloat inter_40=40;
    
    self.remarkLB.sd_layout
    .leftSpaceToView(self,inter_40).topSpaceToView(self, 0).heightIs(40).widthIs(100);
    
    self.alterBtn.sd_layout
    .leftSpaceToView(self.remarkLB,inter_10).centerYEqualToView(self).heightIs(40).widthIs(100);
    
}
-(void)setModel:(FNRedPackageNaModel *)model{
    _model=model;
    if(model){
        self.remarkLB.text=model.hint;
        [self.alterBtn setTitle:model.amend forState:UIControlStateNormal];
        CGFloat remarkLBW=[self getWidthWithText:self.remarkLB.text height:40 font:14];
        CGFloat alterBtnW=0;
        if([model.amend kr_isNotEmpty]){
            alterBtnW=[self getWidthWithText:model.amend height:40 font:14];
        }
        if([model.amendState integerValue]==1){
           self.alterBtn.selected=YES;
           [self.alterBtn setTitle:@"改为拼普通红包" forState:UIControlStateNormal];
        }else{
           self.alterBtn.selected=NO;
           [self.alterBtn setTitle:@"改为拼手气红包" forState:UIControlStateNormal];
        }
        self.remarkLB.sd_layout
        .leftSpaceToView(self,40).topSpaceToView(self, 0).heightIs(40).widthIs(remarkLBW);
        
        self.alterBtn.sd_layout
        .leftSpaceToView(self.remarkLB,10).centerYEqualToView(self).heightIs(40).widthIs(alterBtnW);
    }
}
-(void)setStateInt:(NSInteger)stateInt{
    _stateInt=stateInt;
    if(stateInt==1||stateInt==0){
       self.remarkLB.hidden=YES;
    }else{
       self.remarkLB.hidden=NO;
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
-(void)alterBtnAction:(UIButton *)btn{
    btn.selected=!btn.selected;
    NSInteger state=0;
    if(btn.selected==YES){
        state=1;
    }else{
        state=0;
    } 
    if ([self.delegate respondsToSelector:@selector(inWithRedPacketState:)]) {
        [self.delegate inWithRedPacketState:state];
    }
}
@end
