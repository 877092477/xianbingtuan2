//
//  FNRushStoreSiteNeCell.m
//  69橙子
//
//  Created by Jimmy on 2018/11/29.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNRushStoreSiteNeCell.h"

@implementation FNRushStoreSiteNeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllView];
    }
    return self;
}
-(void)setUpAllView{
    self.iconView = [[UIImageView alloc]init];
    self.iconView.cornerRadius=4;
    //self.iconView.backgroundColor=RGB(237, 237, 237);
    [self.contentView addSubview:self.iconView];
    
    self.nameLab = [[UILabel alloc]init];
    self.nameLab.font=kFONT15;
    [self.contentView addSubview:self.nameLab];
    
    self.lineLb = [[UILabel alloc]init];
    self.lineLb.backgroundColor=RGB(237, 237, 237);
    [self.contentView addSubview:self.lineLb];
    
    [self compositionFrame];
    
}
-(void)compositionFrame{
    CGFloat space_10=10;
    CGFloat space_20=20;
    CGFloat space_5=5;
    self.iconView.sd_layout
    .centerYEqualToView(self.contentView).widthIs(20).heightIs(20).leftSpaceToView(self.contentView, space_20);
    
    self.nameLab.sd_layout.centerYEqualToView(self.contentView).leftSpaceToView(self.iconView, space_10).heightIs(25).rightSpaceToView(self.contentView, space_20);
    
    self.lineLb.sd_layout.bottomSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, space_20).rightSpaceToView(self.contentView, space_20).heightIs(1);
     
    
}
 
-(void)setModel:(NSDictionary *)model{
    _model=model;
    if(model){
        FNrushPurchaseNeModel *data=[FNrushPurchaseNeModel mj_objectWithKeyValues:model];
        FNrushBuyMsgModel *buyMsg=[FNrushBuyMsgModel mj_objectWithKeyValues:data.buy_msg];
        [self.iconView setUrlImg:buyMsg.logo];
        self.nameLab.text=buyMsg.address;//@"珠海市南屏镇十二村正街三巷107铺";
        
    }
}
@end
