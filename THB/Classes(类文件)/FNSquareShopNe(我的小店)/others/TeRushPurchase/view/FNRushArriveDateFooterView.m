//
//  FNRushArriveDateFooterView.m
//  69橙子
//
//  Created by Jimmy on 2018/11/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//送达时间
#import "FNRushArriveDateFooterView.h"

@implementation FNRushArriveDateFooterView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
    UIView *bgView=[[UIView alloc]init];
    bgView.backgroundColor=[UIColor whiteColor];
    [self addSubview:bgView];
    bgView.sd_layout
    .topEqualToView(self).leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    self.sendTitle= [[UILabel alloc]init];
    self.sendTitle.font=kFONT16;
    [self addSubview:self.sendTitle];
    
    self.sendDateLb= [[UILabel alloc]init];
    self.sendDateLb.textColor=RGB(70, 146, 250);
    self.sendDateLb.font=kFONT14;
    self.sendDateLb.textAlignment=NSTextAlignmentRight;
    [self addSubview:self.sendDateLb];
    
    [self compositionFrame];
}
-(void)compositionFrame{
    CGFloat space_20=20;
    CGFloat space_5=5;
    self.sendTitle.sd_layout
    .leftSpaceToView(self, space_20).centerYEqualToView(self).heightIs(25);
    [self.sendTitle setSingleLineAutoResizeWithMaxWidth:100];
    
    self.sendDateLb.sd_layout
    .rightSpaceToView(self, space_20).centerYEqualToView(self).heightIs(25);
    [self.sendDateLb setSingleLineAutoResizeWithMaxWidth:160];
    
    
}
-(void)setDicModel:(NSDictionary *)dicModel{
    _dicModel=dicModel;
    if(dicModel){
        FNrushPurchaseNeModel *model=[FNrushPurchaseNeModel mj_objectWithKeyValues:dicModel];
        FNrushBuyMsgModel *buymsg=[FNrushBuyMsgModel mj_objectWithKeyValues:model.buy_msg];
        self.sendTitle.text=@"送达时间";
        
        NSString *describeString=buymsg.str;//@"尽快送达";
        NSString *dateString=@"(17:24s送达)";
        NSString *jointString=[NSString stringWithFormat:@"%@%@",describeString,dateString];
        NSMutableAttributedString *valbutedString = [[NSMutableAttributedString alloc] initWithString: jointString];
        [valbutedString addAttribute:NSForegroundColorAttributeName value:RGB(70, 187, 250) range:NSMakeRange(describeString.length, dateString.length)];
        self.sendDateLb.attributedText=valbutedString;
        
        self.sendDateLb.text=describeString;
    }
}
@end
