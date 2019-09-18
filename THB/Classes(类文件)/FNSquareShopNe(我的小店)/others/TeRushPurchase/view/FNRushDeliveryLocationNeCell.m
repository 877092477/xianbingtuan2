//
//  FNRushDeliveryLocationNeCell.m
//  69橙子
//
//  Created by Jimmy on 2018/11/29.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNRushDeliveryLocationNeCell.h"

@implementation FNRushDeliveryLocationNeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllView];
    }
    return self;
}
-(void)setUpAllView{
    self.directionView = [[UIImageView alloc]init];
    //self.directionView.backgroundColor=RGB(237, 237, 237);
    [self.contentView addSubview:self.directionView];
    
    self.locationLb = [[UILabel alloc]init];
    self.locationLb.font=kFONT17;
    [self.contentView addSubview:self.locationLb];
    
    self.namejoLb = [[UILabel alloc]init];
    self.namejoLb.font=kFONT14;
    [self.contentView addSubview:self.namejoLb];
    
    self.lineLb = [[UILabel alloc]init];
    self.lineLb.backgroundColor=RGB(237, 237, 237);
    [self.contentView addSubview:self.lineLb];
    
    [self compositionFrame];
    
}
-(void)compositionFrame{
    
    CGFloat space_20=20;
    CGFloat space_5=5;
    
    self.directionView.sd_layout
    .centerYEqualToView(self.contentView).widthIs(11).heightIs(20).rightSpaceToView(self.contentView, space_20);
    
    self.locationLb.sd_layout
    .leftSpaceToView(self.contentView,space_20).heightIs(25).rightSpaceToView(self.directionView, space_5).topSpaceToView(self.contentView, space_5);
    
    self.namejoLb.sd_layout
    .leftSpaceToView(self.contentView, space_20).heightIs(20).rightSpaceToView(self.directionView, space_5).topSpaceToView(self.locationLb, 0);
    
    self.lineLb.sd_layout.bottomSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, space_20).rightSpaceToView(self.contentView, space_20).heightIs(1);
    
    
}

-(void)setModel:(NSDictionary *)model{
    _model=model;
    if(model){
        FNrushBuyMsgModel *buyModel=[FNrushBuyMsgModel mj_objectWithKeyValues:model];
        self.locationLb.text=buyModel.address;//@"珠海市南屏镇十二村正街三巷107铺";
        self.namejoLb.text=[NSString stringWithFormat:@"%@  %@",buyModel.name,buyModel.phone];//@"邓先生 131177889941";
        self.directionView.image=IMAGE(@"pay_tanb_back"); 
    }
}
@end
