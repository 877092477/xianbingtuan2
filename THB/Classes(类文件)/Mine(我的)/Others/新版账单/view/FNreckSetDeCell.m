//
//  FNreckSetDeCell.m
//  THB
//
//  Created by Jimmy on 2018/12/25.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNreckSetDeCell.h"

@implementation FNreckSetDeCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNreckSetDeCellId";
    FNreckSetDeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    self.backgroundColor=RGB(245, 245, 245);
    self.bgView=[[UIView alloc]init];
    self.bgView.backgroundColor=[UIColor whiteColor];
    self.bgView.cornerRadius=5/2;
    [self addSubview:self.bgView];
    
    self.titleLB=[UILabel new];
    self.titleLB.textColor=FNBlackColor;
    self.titleLB.font=kFONT12;
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:self.titleLB];
    
    self.timeLB=[UILabel new];
    self.timeLB.textColor=RGB(200, 200, 200);
    self.timeLB.font=kFONT11;
    self.timeLB.textAlignment=NSTextAlignmentRight;
    [self.bgView addSubview:self.timeLB];
    
    self.nameLB=[UILabel new];
    self.nameLB.textColor=FNBlackColor;
    self.nameLB.font=kFONT14;
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:self.nameLB];
    
    self.priceLB=[UILabel new];
    self.priceLB.textColor=FNBlackColor;
    self.priceLB.font=kFONT14;
    self.priceLB.textAlignment=NSTextAlignmentRight;
    [self.bgView addSubview:self.priceLB];
    
    self.typeBtn=[[UIButton alloc]init];
    [self.typeBtn setTitleColor:RGB(255, 85, 85) forState:UIControlStateNormal];
    self.typeBtn.titleLabel.font=kFONT11;
    //self.typeBtn.borderColor = RGB(255, 85, 85);
    [self.bgView addSubview:self.typeBtn];
    
    self.orderDuplicateBtn=[[UIButton alloc]init];
    self.orderDuplicateBtn.titleLabel.font=kFONT11;
    [self.orderDuplicateBtn setTitleColor:RGB(200, 200, 200) forState:UIControlStateNormal];
    [self.orderDuplicateBtn addTarget:self action:@selector(orderButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.orderDuplicateBtn];
    
    self.orderLB=[UILabel new];
    self.orderLB.textColor=RGB(200, 200, 200);
    self.orderLB.font=kFONT11;
    self.orderLB.textAlignment=NSTextAlignmentRight;
    [self.bgView addSubview:self.orderLB];
    
    [self incomposition];
    
    
    
}
-(void)incomposition{
    CGFloat inter_20=20;
    CGFloat inter_10=10;
    CGFloat inter_5=5;
    self.bgView.sd_layout
    .bottomEqualToView(self).topSpaceToView(self, 0).rightSpaceToView(self, inter_10).leftSpaceToView(self, inter_10);
    
    self.titleLB.sd_layout
    .topSpaceToView(self.bgView, inter_5).leftSpaceToView(self.bgView, inter_10).heightIs(15);
    [self.titleLB setSingleLineAutoResizeWithMaxWidth:100];
    
    self.timeLB.sd_layout
    .rightSpaceToView(self.bgView, inter_10).heightIs(15).centerYEqualToView(self.titleLB);
    [self.timeLB setSingleLineAutoResizeWithMaxWidth:180];
    
    self.priceLB.sd_layout
    .rightSpaceToView(self.bgView, inter_10).heightIs(20).centerYEqualToView(self.bgView).widthIs(100);
    
    self.nameLB.sd_layout
    .heightIs(20).leftSpaceToView(self.bgView, inter_10).centerYEqualToView(self.bgView);
    [self.nameLB setSingleLineAutoResizeWithMaxWidth:220];
    
    self.typeBtn.sd_layout
    .bottomSpaceToView(self.bgView, inter_10).heightIs(15).leftSpaceToView(self.bgView, inter_10);
    [self.typeBtn setupAutoSizeWithHorizontalPadding:7 buttonHeight:15];
    
    self.orderDuplicateBtn.sd_layout
    .bottomSpaceToView(self.bgView, inter_10).heightIs(15).rightSpaceToView(self.bgView, inter_10);
    [self.orderDuplicateBtn setupAutoSizeWithHorizontalPadding:0 buttonHeight:15];
    
    self.orderLB.sd_layout
    .bottomSpaceToView(self.bgView, inter_10).heightIs(15).rightSpaceToView(self.orderDuplicateBtn, inter_5);
    [self.orderLB setSingleLineAutoResizeWithMaxWidth:200];
}
-(void)orderButtonClick{
    if ([self.delegate respondsToSelector:@selector(inOrderDupAction:)]) {
        [self.delegate inOrderDupAction:self.indexPath];
    }
}
-(void)setModel:(FNreckSetItemModel *)model{
    _model=model;
    if(model){
        self.titleLB.text=model.type_str;//@"自购订单";
        self.timeLB.text=model.time;//@"2018/12/17/15:32";
        self.nameLB.text=model.detail;//@"双十二狂欢价 长袖男士";
        if([model.label kr_isNotEmpty]){
           [self.typeBtn setTitleColor:[UIColor colorWithHexString:model.label_color] forState:UIControlStateNormal];
           [self.typeBtn setTitle:model.label forState:UIControlStateNormal];
            self.typeBtn.borderColor = [UIColor colorWithHexString:model.label_color];//RGB(255, 85, 85);
            self.typeBtn.borderWidth=0.5;
            self.typeBtn.cornerRadius=2.5;
            self.typeBtn.clipsToBounds = YES;
        }
        NSString *DuplicateString=@"复制";
        [self.orderDuplicateBtn setTitle:@"复制" forState:UIControlStateNormal];
        self.orderLB.text=model.o_str;//oid//@"168978728973898890800";
        
        NSArray *array = [model.str componentsSeparatedByString:@" "];
        NSString* coupon = array[0];//@"佣金 ";
        NSString* price = array[1];//@"+5.86";
        self.priceLB.text =[NSString stringWithFormat:@"%@ %@",coupon,price];
        [self.priceLB addSingleAttributed:@{NSForegroundColorAttributeName:RGB(250, 90, 0)} ofRange:[self.priceLB.text rangeOfString:price]];
        
        CGFloat orderDuplicateW=[self getWidthWithText:DuplicateString height:15 font:11];
        self.orderLB.sd_layout
        .bottomSpaceToView(self.bgView, 10).heightIs(15).rightSpaceToView(self.bgView, orderDuplicateW+5+10);
        [self.orderLB setSingleLineAutoResizeWithMaxWidth:200];
        if([model.o_str kr_isNotEmpty]){
            self.orderDuplicateBtn.hidden=NO;
        }else{
            self.orderDuplicateBtn.hidden=YES;
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
