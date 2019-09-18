//
//  FNTePayModelDaNeCell.m
//  69橙子
//
//  Created by Jimmy on 2018/11/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNTePayModelDaNeCell.h"

@implementation FNTePayModelDaNeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllView];
    }
    return self;
}
-(void)setUpAllView{
    self.iconView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.iconView];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.font=kFONT15;
    [self.contentView addSubview:self.nameLab];
    
    self.lineLb = [[UILabel alloc]init];
    self.lineLb.backgroundColor=RGB(237, 237, 237);
    [self.contentView addSubview:self.lineLb];
    
    self.statusImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.statusImageView];
    
    [self compositionFrame];
    
}
-(void)compositionFrame{
    self.iconView.sd_layout
    .centerYEqualToView(self.contentView).widthIs(20).heightIs(20).leftSpaceToView(self.contentView, 0);
    
    self.nameLab.sd_layout.centerYEqualToView(self.contentView).leftSpaceToView(self.iconView, 15).heightIs(25);
    [self.nameLab setSingleLineAutoResizeWithMaxWidth:100];
    
    self.lineLb.sd_layout.bottomSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(1);
    
    self.statusImageView.sd_layout
    .rightSpaceToView(self.contentView, 0).centerYEqualToView(self.contentView).widthIs(20).heightIs(20);
    
}
-(void)setModel:(FNTePayDaNeModel *)model{
    _model=model;
    if(model){
        self.iconView.image=IMAGE(model.image);
        self.nameLab.text=model.name;
        if (model.state==0) {
            self.statusImageView.image=IMAGE(@"storepayNoseleted");
        }else{
            self.statusImageView.image=IMAGE(@"storepayRedSeleted");
        }
    }
}
@end
