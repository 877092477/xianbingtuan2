//
//  FNteIndentBrandNeCell.m
//  69橙子
//
//  Created by Jimmy on 2018/12/6.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//自取餐号 155
#import "FNteIndentBrandNeCell.h"

@implementation FNteIndentBrandNeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
    self.contentView.backgroundColor=FNColor(240,240,240);
    self.bgView=[[UIView alloc]init];
    self.bgView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    
    //标题
    self.titleLB=[UILabel new];
    self.titleLB.font=kFONT16;
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:self.titleLB];
    
    //状态
    self.stateLB=[UILabel new];
    self.stateLB.font=kFONT14;
    self.stateLB.textColor=RGB(244, 47, 25);
    self.stateLB.textAlignment=NSTextAlignmentRight;
    [self.bgView addSubview:self.stateLB]; 
    
    //值
    self.happenLB=[UILabel new];
    self.happenLB.font=[UIFont systemFontOfSize:36];
    self.happenLB.textAlignment=NSTextAlignmentCenter;
    [self.bgView addSubview:self.happenLB];
    
    
    [self placeViewFrame];
}
-(void)placeViewFrame{
    CGFloat space_20=20;
    CGFloat space_10=10;
    CGFloat space_5=5;
    
    self.bgView.sd_layout
    .topSpaceToView(self.contentView, space_10).leftSpaceToView(self.contentView, space_10).rightSpaceToView(self.contentView, space_10).bottomSpaceToView(self.contentView, space_10);
    
    self.titleLB.sd_layout
    .topSpaceToView(self.bgView, space_10).leftSpaceToView(self.bgView, space_10).heightIs(20);
    [self.titleLB setSingleLineAutoResizeWithMaxWidth:120];
    
    self.stateLB.sd_layout
    .topSpaceToView(self.bgView, space_10).rightSpaceToView(self.bgView, space_10).heightIs(20);
    [self.stateLB setSingleLineAutoResizeWithMaxWidth:100];
    
    self.happenLB.sd_layout
    .bottomSpaceToView(self.bgView, 40).rightSpaceToView(self.bgView, space_10).heightIs(40).leftSpaceToView(self.bgView, space_10);
    
    
}

-(void)setModel:(FNtendOrderDetailsDeModel *)model{
    _model=model;
    if(model){
        self.titleLB.text=@"我的自取餐号";
        self.stateLB.text=@"可使用";
        self.happenLB.text=model.code;//@"144202120";
    }
    
}
@end
