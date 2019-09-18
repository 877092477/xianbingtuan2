//
//  FNmerIssueDateSCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/13.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerIssueDateSCell.h"

@implementation FNmerIssueDateSCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.bgView=[[UIView alloc]init];
    [self addSubview:self.bgView];
    
    self.leftStartLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.leftStartLB];
    
    self.leftEndLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.leftEndLB];
    
    self.startBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.startBtn];
    
    self.endBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.endBtn];
    
    self.lineView=[[UIView alloc]init];
    [self.bgView addSubview:self.lineView];
    
    self.issueBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.issueBtn];
    
    self.hintLB=[[UILabel alloc]init];
    [self addSubview:self.hintLB];
    
    self.bgView.backgroundColor=[UIColor whiteColor];
    self.bgView.cornerRadius=5;
    
    self.leftStartLB.font=[UIFont systemFontOfSize:14];
    self.leftStartLB.textColor=RGB(24, 24, 24);
    self.leftStartLB.textAlignment=NSTextAlignmentLeft;
    
    self.leftEndLB.font=[UIFont systemFontOfSize:14];
    self.leftEndLB.textColor=RGB(24, 24, 24);
    self.leftEndLB.textAlignment=NSTextAlignmentLeft;
    
    self.hintLB.font=[UIFont systemFontOfSize:11];
    self.hintLB.textColor=RGB(24, 24, 24);
    self.hintLB.textAlignment=NSTextAlignmentLeft;
    
    self.startBtn.titleLabel.font=kFONT12;
    self.startBtn.titleLabel.textAlignment=NSTextAlignmentRight;
    [self.startBtn setTitleColor:RGB(24, 24, 24) forState:UIControlStateNormal];
    
    self.endBtn.titleLabel.font=kFONT12;
    self.endBtn.titleLabel.textAlignment=NSTextAlignmentRight;
    [self.endBtn setTitleColor:RGB(24, 24, 24) forState:UIControlStateNormal];
    
    self.issueBtn.titleLabel.font=kFONT16;
    [self.issueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.issueBtn.cornerRadius=5;
    
    self.lineView.backgroundColor=RGB(246, 245, 245);
    
    self.bgView.sd_layout
    .leftSpaceToView(self, 20).rightSpaceToView(self, 20).topSpaceToView(self, 0).heightIs(90);
    
    self.leftStartLB.sd_layout
    .leftSpaceToView(self.bgView, 15).topSpaceToView(self.bgView, 2).widthIs(80).heightIs(41);
    
    self.leftEndLB.sd_layout
    .leftSpaceToView(self.bgView, 15).topSpaceToView(self.bgView, 47).widthIs(80).heightIs(41);
    
    self.hintLB.sd_layout
    .leftSpaceToView(self, 37).rightSpaceToView(self, 37).topSpaceToView(self.bgView, 2).heightIs(20);
    
    self.startBtn.sd_layout
    .rightSpaceToView(self.bgView, 15).centerYEqualToView(self.leftStartLB).leftSpaceToView(self.leftStartLB, 10).heightIs(30);
    
    self.startBtn.imageView.sd_layout
    .centerYEqualToView(self.startBtn).widthIs(13).heightIs(13).rightSpaceToView(self.startBtn, 2);
    
    self.startBtn.titleLabel.sd_layout
    .centerYEqualToView(self.startBtn).leftSpaceToView(self.startBtn, 5).heightIs(20).rightSpaceToView(self.startBtn, 25);
    
    self.endBtn.sd_layout
    .rightSpaceToView(self.bgView, 15).centerYEqualToView(self.leftEndLB).leftSpaceToView(self.leftEndLB, 10).heightIs(30);
    
    self.endBtn.imageView.sd_layout
    .centerYEqualToView(self.endBtn).widthIs(13).heightIs(13).rightSpaceToView(self.endBtn, 2);
    
    self.endBtn.titleLabel.sd_layout
    .centerYEqualToView(self.endBtn).leftSpaceToView(self.endBtn, 5).heightIs(20).rightSpaceToView(self.endBtn, 25);
    
    self.lineView.sd_layout
    .leftSpaceToView(self.bgView, 15).rightSpaceToView(self.bgView, 15).heightIs(1).centerYEqualToView(self.bgView);
    
    self.issueBtn.sd_layout
    .leftSpaceToView(self, 39).rightSpaceToView(self, 39).heightIs(40).bottomEqualToView(self); 
    
    [self.endBtn setImage:IMAGE(@"FN_menRiliimg") forState:UIControlStateNormal];
    [self.startBtn setImage:IMAGE(@"FN_menRiliimg") forState:UIControlStateNormal];
    //[self.issueBtn setTitle:@"发布红包" forState:UIControlStateNormal];
    //self.issueBtn.backgroundColor=RGB(252, 154, 131);
    self.leftStartLB.text=@"*开始有效期";
    self.leftEndLB.text=@"*结束有效期";
    
    self.hintLB.text=@"满减活动将于 0 天后开始，有效期 0 天";
}
-(void)setTypeStr:(NSString *)typeStr{
    _typeStr=typeStr;
    if([typeStr kr_isNotEmpty]){
        if([typeStr isEqualToString:@"pub_red_packet_list"]||[typeStr isEqualToString:@"red_packet"]){
            [self.leftStartLB fn_changeColorWithTextColor:RGB(255, 103, 35) changeText:@"*"];
            [self.leftEndLB fn_changeColorWithTextColor:RGB(255, 103, 35) changeText:@"*"];
            
        }
        if([typeStr isEqualToString:@"pub_yhq_list"]||[typeStr isEqualToString:@"yhq"]){
            [self.leftStartLB fn_changeColorWithTextColor:RGB(255, 114, 0) changeText:@"*"];
            [self.leftEndLB fn_changeColorWithTextColor:RGB(255, 103, 35) changeText:@"*"];
            
        } 
        if([typeStr isEqualToString:@"full_reduction"]){
            [self.leftStartLB fn_changeColorWithTextColor:RGB(2, 188, 165) changeText:@"*"];
            [self.leftEndLB fn_changeColorWithTextColor:RGB(2, 188, 165) changeText:@"*"];
            
        }
        if([typeStr isEqualToString:@"discount"]){
            [self.leftStartLB fn_changeColorWithTextColor:RGB(255, 76, 74) changeText:@"*"];
            [self.leftEndLB fn_changeColorWithTextColor:RGB(255, 103, 35) changeText:@"*"];
             
        }
    }
}
@end
