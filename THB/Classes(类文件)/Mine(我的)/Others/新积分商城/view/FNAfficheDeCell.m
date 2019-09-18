//
//  FNAfficheDeCell.m
//  THB
//
//  Created by Jimmy on 2019/1/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//
//跑马灯 55
#import "FNAfficheDeCell.h"

@implementation FNAfficheDeCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews
{
    self.backgroundColor=[UIColor whiteColor];
    
    self.definImage=[[UIImageView alloc]init];
    [self addSubview:self.definImage];
    
    //跑马灯模块
    self.FNMarqueeView = [[FNScrollmonkeyView alloc] initWithFrame:CGRectMake(96, 12.5, JMScreenWidth-96, 20)];
    self.FNMarqueeView.backgroundColor=FNWhiteColor;
    self.FNMarqueeView.ScrollTextView.textColor = RGBA(102, 102, 102, 102);
    //ScrollmonkeyView.Image.image=IMAGE(@"hhorn");
    [self addSubview:self.FNMarqueeView];
    
    self.leftLB=[UILabel new];
    self.leftLB.font=kFONT12;
    self.leftLB.hidden=YES;
    self.leftLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.leftLB];
    //[self.FNMarqueeView setSuper_msglist:@[@"恭喜“21451…”用户，成功获得24积分"]];
    
    self.definImage.sd_layout
    .heightIs(15).widthIs(56).centerYEqualToView(self).leftSpaceToView(self, 15);
    
    self.leftLB.sd_layout
    .heightIs(20).widthIs(40).centerYEqualToView(self).leftSpaceToView(self.definImage, 10);
    
}
-(void)setModel:(FNDefiniteStoreNeModel *)model{
    _model=model;
    if(model){
        FNDefiniteListItemModel *itemModel=[FNDefiniteListItemModel mj_objectWithKeyValues:model.list[0]];
        [self.definImage setNoPlaceholderUrlImg:itemModel.img];
        self.leftLB.text=@"[公告]";
        self.leftLB.textColor=RGB(233, 143, 0);
        
        CGFloat leftLBW=[self getWidthWithText:self.leftLB.text height:20 font:12];
        self.leftLB.sd_layout
        .heightIs(20).widthIs(leftLBW).centerYEqualToView(self).leftSpaceToView(self.definImage, 10);
    }
}
-(void)setMarqueeArray:(NSMutableArray *)marqueeArray{
    _marqueeArray=marqueeArray;
    if(marqueeArray.count>0){
        self.leftLB.hidden=NO;
        [self.FNMarqueeView setSuper_msglist:marqueeArray];
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
