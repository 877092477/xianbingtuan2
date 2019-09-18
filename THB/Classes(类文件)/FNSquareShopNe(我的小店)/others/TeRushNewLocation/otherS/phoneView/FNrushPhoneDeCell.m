//
//  FNrushPhoneDeCell.m
//  69橙子
//
//  Created by 李显 on 2018/12/9.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNrushPhoneDeCell.h"
#import "LJPerson.h"
@implementation FNrushPhoneDeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=FNWhiteColor;
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
    
    self.iconImageV=[[UIImageView alloc]init];
    self.iconImageV.layer.cornerRadius = 30;
    self.iconImageV.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageV];
   
    self.nameLabel=[UILabel new];
    self.nameLabel.font=kFONT15;
    self.nameLabel.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:self.nameLabel];
    
    
    self.phoneNumLabel=[UILabel new];
    self.phoneNumLabel.font=kFONT12;
    self.phoneNumLabel.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:self.phoneNumLabel];
    
    [self inPlaceViewFrame];
}
-(void)inPlaceViewFrame{
    self.iconImageV.sd_layout
    .centerYEqualToView(self.contentView).widthIs(60).heightIs(60).leftSpaceToView(self.contentView, 10);
    
    self.nameLabel.sd_layout
    .leftSpaceToView(self.iconImageV, 10).topEqualToView(self.iconImageV).rightSpaceToView(self.contentView, 10).heightIs(20);
    
    
    self.phoneNumLabel.sd_layout
    .leftSpaceToView(self.iconImageV, 10).rightSpaceToView(self.contentView, 10).heightIs(15).bottomEqualToView(self.iconImageV);
    
}

- (void)setModel:(LJPerson *)model
{
        self.iconImageV.image = model.image ? model.image : [UIImage imageNamed:@"handportrait"];
        self.nameLabel.text = model.fullName;
        LJPhone *phoneModel = model.phones.firstObject;
        self.phoneNumLabel.text = phoneModel.phone;
}
@end
