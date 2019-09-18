//
//  QTBOnlyView.m
//  如意贝
//
//  Created by Fnuo-iOS on 2018/4/27.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "OnlyView.h"

@implementation OnlyView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        UIImageView *leftImage=[[UIImageView alloc]init];
        leftImage.contentMode=UIViewContentModeScaleAspectFit;
        [self addSubview:leftImage];
        [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(@10);
            make.height.equalTo(@15);
            make.width.equalTo(@25);
        }];
        self.leftImage=leftImage;
        
        UILabel *titleLabel=[[UILabel alloc]init];
        titleLabel.textColor=FNGlobalTextGrayColor;
        titleLabel.font=kFONT13;
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(leftImage.mas_right).offset(5);
        }];
        self.titleLabel=titleLabel;
        
        UISwitch *Switch=[[UISwitch alloc]init];
        Switch.onTintColor=FNMainGobalControlsColor;
        [self addSubview:Switch];
        [Switch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(@-3);
        }];
        Switch.transform = CGAffineTransformMakeScale( 0.7, 0.7);//缩放
        self.Switch=Switch;
    }
    return self;
}

@end
