//
//  FNRushCommodityMeNeCell.m
//  69橙子
//
//  Created by Jimmy on 2018/11/29.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNRushCommodityMeNeCell.h"

@implementation FNRushCommodityMeNeCell

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
    
    self.goodsView = [[UIImageView alloc]init];
    self.goodsView.backgroundColor=[UIColor lightGrayColor];
    [self.contentView addSubview:self.goodsView];
    
    self.nameLb = [[UILabel alloc]init];
    self.nameLb.font=kFONT13;
    [self.contentView addSubview:self.nameLb];
    
    self.lineLb = [[UILabel alloc]init];
    //self.lineLb.backgroundColor=RGB(237, 237, 237);
    [self.contentView addSubview:self.lineLb];
    
    self.quantityLb = [[UILabel alloc]init];
    self.quantityLb.font=kFONT14;
    self.quantityLb.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:self.quantityLb];
    
    [self compositionFrame];
    
}
-(void)compositionFrame{
    CGFloat space_10=10;
    CGFloat space_20=20;
    
    self.goodsView.sd_layout
    .centerYEqualToView(self.contentView).widthIs(25).heightIs(25).leftSpaceToView(self.contentView, space_20);
    
    self.nameLb.sd_layout.centerYEqualToView(self.contentView).leftSpaceToView(self.goodsView, space_10).heightIs(25);
    [self.nameLb setSingleLineAutoResizeWithMaxWidth:100];
    
    self.lineLb.sd_layout.bottomSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, space_20).rightSpaceToView(self.contentView, space_20).heightIs(1);
    
    self.quantityLb.sd_layout
    .rightSpaceToView(self.contentView, space_20).centerYEqualToView(self.contentView).heightIs(20);
    [self.quantityLb setSingleLineAutoResizeWithMaxWidth:160];
    
    
    
}
-(void)setModel:(FNrushPurchCartNeModel *)model{
    _model=model;
    if(model){
        [self.goodsView setUrlImg:model.goods_img];
        self.nameLb.text=model.goods_title;//@"黄金糕点 (5片)";
        self.quantityLb.text=[NSString stringWithFormat:@"%@     %@",model.count,model.sum];//@"x1     ¥13.8";
    }
}
@end
