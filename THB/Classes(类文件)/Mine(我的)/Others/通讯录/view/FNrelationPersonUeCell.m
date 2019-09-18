//
//  FNrelationPersonUeCell.m
//  THB
//
//  Created by 李显 on 2019/1/21.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNrelationPersonUeCell.h"

@implementation FNrelationPersonUeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews
{
    self.backgroundColor=[UIColor whiteColor];
    
    self.photoImage=[UIImageView new];
    self.photoImage.cornerRadius=40/2;
    self.photoImage.backgroundColor=[UIColor lightGrayColor];
    [self addSubview:self.photoImage];
    
    self.stateLB=[UILabel new];
    self.stateLB.textColor=RGB(114, 114, 114);
    self.stateLB.font=[UIFont systemFontOfSize:9];
    self.stateLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.stateLB];
    
    self.nameLB=[UILabel new];
    self.nameLB.font=kFONT13;
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.nameLB];
    
    self.gradeLB=[UILabel new];
    self.gradeLB.font=kFONT10;
    self.gradeLB.textColor=RGB(244, 62, 121);
    self.gradeLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.gradeLB];
    
    self.representLB=[UILabel new];
    self.representLB.textColor=RGB(150, 150, 150);
    self.representLB.font=kFONT11;
    self.representLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.representLB];
    
    self.representTwoLB=[UILabel new];
    self.representTwoLB.textColor=RGB(150, 150, 150);
    self.representTwoLB.font=kFONT11;
    self.representTwoLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.representTwoLB];
    
    self.line=[[UIView alloc]init];
    self.line.backgroundColor=RGB(241, 241, 241);
    [self addSubview:self.line];
    
    self.photoImage.sd_layout
    .leftSpaceToView(self, 10).centerYEqualToView(self).widthIs(40).heightIs(40);
    
    self.stateLB.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self.photoImage, 5).widthIs(40).heightIs(15);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.photoImage, 10).topSpaceToView(self, 15).widthIs(140).heightIs(15);
    
    
    self.gradeLB.sd_layout
    .leftSpaceToView(self.nameLB, 8).centerYEqualToView(self.nameLB).heightIs(15);
    [self.gradeLB setSingleLineAutoResizeWithMaxWidth:100];
    
    
    self.representLB.sd_layout
    .leftSpaceToView(self.photoImage, 10).topSpaceToView(self.nameLB, 8).heightIs(15);
    [self.representLB setSingleLineAutoResizeWithMaxWidth:250];
    
    self.representTwoLB.sd_layout
    .leftSpaceToView(self.photoImage, 10).bottomSpaceToView(self, 10).heightIs(15);
    [self.representTwoLB setSingleLineAutoResizeWithMaxWidth:250];
    
    self.line.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0).heightIs(4);
    
    self.nameLB.text=@"超级运营商  方诺科技";
    self.stateLB.text=@"";
    self.gradeLB.text=@"(二级用户)";
    self.representLB.text=@"本月佣金：60.00元  下线：159人";
    self.representTwoLB.text=@"手机号：13425666538";
    
}
@end
