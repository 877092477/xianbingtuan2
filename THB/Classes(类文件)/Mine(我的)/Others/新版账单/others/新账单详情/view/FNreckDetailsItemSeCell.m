//
//  FNreckDetailsItemSeCell.m
//  THB
//
//  Created by Jimmy on 2018/12/26.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNreckDetailsItemSeCell.h"

@implementation FNreckDetailsItemSeCell
-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}
-(void)initUI{
    self.backgroundColor=[UIColor whiteColor];//RGB(246, 245, 245);
    
    self.titleLB=[UILabel new];
    self.titleLB.font=kFONT12;
    self.titleLB.textColor=RGB(140,140,140);
    [self addSubview:self.titleLB];
    
    self.orderDuplicateBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.orderDuplicateBtn.hidden=YES;
    self.orderDuplicateBtn.titleLabel.font=kFONT13;
    [self.orderDuplicateBtn setTitle:@"复制" forState:UIControlStateNormal];
    [self.orderDuplicateBtn setTitleColor:RGB(54, 134, 255) forState:UIControlStateNormal];
    [self.orderDuplicateBtn addTarget:self action:@selector(orderButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.orderDuplicateBtn];
    
    self.contentLB=[UILabel new];
    self.contentLB.font=kFONT13;
    self.contentLB.textAlignment=NSTextAlignmentRight;
    self.contentLB.textColor=[UIColor blackColor];
    [self addSubview:self.contentLB];
    
    CGFloat inter_10=10;
    
    self.titleLB.sd_layout
    .heightIs(20).centerYEqualToView(self).leftSpaceToView(self, inter_10);
    [self.titleLB setSingleLineAutoResizeWithMaxWidth:150];
    
    self.orderDuplicateBtn.sd_layout
    .heightIs(20).centerYEqualToView(self).rightSpaceToView(self, inter_10);
    [self.orderDuplicateBtn setupAutoSizeWithHorizontalPadding:0 buttonHeight:20];
    
    self.contentLB.sd_layout
    .heightIs(20).centerYEqualToView(self).rightSpaceToView(self, inter_10);
    [self.contentLB setSingleLineAutoResizeWithMaxWidth:220]; 
    
}
-(void)orderButtonClick{
    if ([self.delegate respondsToSelector:@selector(inDuplicateOrderIDClick:)]) {
        [self.delegate inDuplicateOrderIDClick:self.indexPath];
    }
}
-(void)setModel:(FNreckDetailsItemModel *)model{
    _model=model;
    if(model){
        self.titleLB.text=model.name;//@"订单号";
        self.contentLB.text=model.val;//@"116655778899609956";
        NSUInteger is_order=[model.is_order integerValue];
        NSString *DuplicateString=@"复制";
        if(is_order==1){
            CGFloat orderDuplicateW=[self getWidthWithText:DuplicateString height:20 font:13];
            self.contentLB.sd_layout
            .heightIs(20).centerYEqualToView(self).rightSpaceToView(self, orderDuplicateW+5+10);
            [self.contentLB setSingleLineAutoResizeWithMaxWidth:220];
            self.orderDuplicateBtn.hidden=NO;
        }else{
            self.orderDuplicateBtn.hidden=YES;
            self.contentLB.sd_layout
            .heightIs(20).centerYEqualToView(self).rightSpaceToView(self, 10);
            [self.contentLB setSingleLineAutoResizeWithMaxWidth:220];
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
@end
