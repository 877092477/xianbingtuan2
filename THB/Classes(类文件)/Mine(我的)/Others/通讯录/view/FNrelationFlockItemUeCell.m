//
//  FNrelationFlockItemUeCell.m
//  THB
//
//  Created by 李显 on 2019/1/21.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNrelationFlockItemUeCell.h"

@implementation FNrelationFlockItemUeCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    self.backgroundColor=[UIColor whiteColor];
    
    self.photoImage=[UIImageView new];
    self.photoImage.cornerRadius=20/2;
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
    
    self.representLB=[UILabel new];
    self.representLB.textColor=RGB(150, 150, 150);
    self.representLB.font=kFONT11;
    self.representLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.representLB];
    
    self.line=[[UIView alloc]init];
    self.line.backgroundColor=RGB(241, 241, 241);
    [self addSubview:self.line];
    
    self.photoImage.sd_layout
    .leftSpaceToView(self, 10).centerYEqualToView(self).widthIs(40).heightIs(40);
    
    self.stateLB.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self.photoImage, 5).widthIs(40).heightIs(15);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.photoImage, 10).centerYEqualToView(self).heightIs(15);
    [self.nameLB setSingleLineAutoResizeWithMaxWidth:250];
    
    self.representLB.sd_layout
    .leftSpaceToView(self.photoImage, 10).bottomSpaceToView(self, 8).heightIs(15);
    [self.representLB setSingleLineAutoResizeWithMaxWidth:250];
    
}

@end
