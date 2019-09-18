//
//  FNRushPackagingMeNeCell.m
//  69橙子
//
//  Created by Jimmy on 2018/11/29.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNRushPackagingMeNeCell.h"

@implementation FNRushPackagingMeNeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllView];
    }
    return self;
}
-(void)setUpAllView{
    self.contentView.backgroundColor=RGB(237, 237, 237);
    UIView *bgView=[[UIView alloc]init];
    bgView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:bgView];
    bgView.sd_layout
    .topEqualToView(self.contentView).leftSpaceToView(self.contentView, 10).rightSpaceToView(self.contentView, 10).bottomSpaceToView(self.contentView, 0);
    
    self.packLb = [[UILabel alloc]init];
    self.packLb.font=kFONT12;
    self.packLb.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:self.packLb];
    
    self.nameLb = [[UILabel alloc]init];
    self.nameLb.font=kFONT12;
    [self.contentView addSubview:self.nameLb];
    
    self.lineLb = [[UILabel alloc]init];
    //self.lineLb.backgroundColor=RGB(237, 237, 237);
    [self.contentView addSubview:self.lineLb];
    
    self.priceLb = [[UILabel alloc]init];
    self.priceLb.font=kFONT12;
    self.priceLb.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:self.priceLb];
    
    [self compositionFrame];
    
}
-(void)compositionFrame{
    CGFloat space_10=10;
    CGFloat space_20=20;
    
    self.packLb.sd_layout
    .centerYEqualToView(self.contentView).widthIs(25).heightIs(15).leftSpaceToView(self.contentView, space_20);
    
    self.nameLb.sd_layout.centerYEqualToView(self.contentView).leftSpaceToView(self.packLb, space_10).heightIs(25);
    [self.nameLb setSingleLineAutoResizeWithMaxWidth:100];
    
    self.lineLb.sd_layout.bottomSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, space_20).rightSpaceToView(self.contentView, space_20).heightIs(1);
    
    self.priceLb.sd_layout
    .rightSpaceToView(self.contentView, space_20).centerYEqualToView(self.contentView).heightIs(25);
    [self.priceLb setSingleLineAutoResizeWithMaxWidth:100];
    
    
}
-(void)setModel:(FNrushPurchCartNeModel *)model{
    _model=model;
    if(model){
        self.packLb.textColor=[UIColor colorWithHexString:model.font_color];//RGB(96, 197, 255);
        self.packLb.backgroundColor=[UIColor colorWithHexString:model.color];//[UIColor lightGrayColor];
        self.packLb.text=model.str;//@"配送费";
        self.nameLb.text=model.str1;//@"配送官方";
        self.priceLb.text=model.sum;//@"-¥16.8";
        CGFloat space_10=10;
        CGFloat space_20=20;
        CGFloat packLbW =  [self getWidthWithText:self.packLb.text height:20 font:12];
        self.packLb.sd_layout
        .centerYEqualToView(self.contentView).heightIs(20).leftSpaceToView(self.contentView, space_20).widthIs(packLbW+5);
        self.nameLb.sd_layout.centerYEqualToView(self.contentView).leftSpaceToView(self.packLb, space_10).heightIs(25);
        [self.nameLb setSingleLineAutoResizeWithMaxWidth:100];
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
