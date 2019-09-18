//
//  FNRushPaylDaNeCell.m
//  69橙子
//
//  Created by Jimmy on 2018/11/29.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNRushPaylDaNeCell.h"

@implementation FNRushPaylDaNeCell

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
    
    self.iconView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.iconView];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.font=kFONT15;
    [self.contentView addSubview:self.nameLab];
    
    self.lineLb = [[UILabel alloc]init];
    //self.lineLb.backgroundColor=RGB(237, 237, 237);
    [self.contentView addSubview:self.lineLb];
    
    self.statusImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.statusImageView];
    
    [self compositionFrame];
    
}
-(void)compositionFrame{
    CGFloat space_10=10;
    CGFloat space_20=20;
    
    self.iconView.sd_layout
    .centerYEqualToView(self.contentView).widthIs(20).heightIs(20).leftSpaceToView(self.contentView, space_20);
    
    self.nameLab.sd_layout.centerYEqualToView(self.contentView).leftSpaceToView(self.iconView, space_10).heightIs(25);
    [self.nameLab setSingleLineAutoResizeWithMaxWidth:100];
    
    self.lineLb.sd_layout.bottomSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, space_20).rightSpaceToView(self.contentView, space_20).heightIs(1);
    
    self.statusImageView.sd_layout
    .rightSpaceToView(self.contentView, space_20).centerYEqualToView(self.contentView).widthIs(20).heightIs(20);
    
}
-(void)setModel:(FNTePayDaNeModel *)model{
    _model=model;
    if(model){
        //self.iconView.image=IMAGE(model.image);
        [self.iconView setUrlImg:model.img];
        self.nameLab.text=model.str;
        if (model.state==0) {
            self.statusImageView.image=IMAGE(@"storepayNoseleted");
        }else{
            self.statusImageView.image=IMAGE(@"pay_icon_right");
        }
    }
}

@end
