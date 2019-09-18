//
//  FNCashFootFloorNeView.m
//  THB
//
//  Created by Jimmy on 2018/10/26.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNCashFootFloorNeView.h"

@implementation FNCashFootFloorNeView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor= [UIColor whiteColor];
        [self initUI];
    }
    return self;
}
-(void)initUI{
    self.bgImageView=[UIImageView new];
    [self.contentView addSubview:self.bgImageView];
    
    self.floortitle=[UILabel new]; 
    self.floortitle.font=kFONT12;
    self.floortitle.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:self.floortitle];
    
    self.leftView=[UILabel new];
    //self.leftView.backgroundColor=FNBlackColor;
    [self.contentView addSubview:self.leftView];
    
    self.rightView=[UILabel new];
    //self.rightView.backgroundColor=FNBlackColor;
    [self.contentView addSubview:self.rightView];
    
    [self initdistribute]; 
    
}
-(void)initdistribute{
    self.bgImageView.sd_layout
    .leftSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 10).heightIs(35);
    
    self.floortitle.sd_layout
    .heightIs(30).centerXEqualToView(self.contentView).widthIs(100).bottomSpaceToView(self.contentView, 0);

    self.leftView.sd_layout
    .leftSpaceToView(self.contentView, 10).centerYEqualToView(self.floortitle).rightSpaceToView(self.floortitle, 10).heightIs(1);

    self.rightView.sd_layout
    .leftSpaceToView(self.floortitle, 10).centerYEqualToView(self.floortitle).rightSpaceToView(self.contentView, 10).heightIs(1);
    
    self.floortitle.text=@"我已经到底啦";
}
-(void)setItemDic:(NSDictionary *)itemDic{
    _itemDic=itemDic;
    if(itemDic){
        //FNCashActivityNeModel *model=[FNCashActivityNeModel mj_objectWithKeyValues:itemDic];
        
    }
}

@end
