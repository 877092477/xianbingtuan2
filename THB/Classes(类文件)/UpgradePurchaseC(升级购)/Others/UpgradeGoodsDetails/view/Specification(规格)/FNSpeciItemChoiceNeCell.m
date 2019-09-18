//
//  FNSpeciItemChoiceNeCell.m
//  THB
//
//  Created by Jimmy on 2018/9/27.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNSpeciItemChoiceNeCell.h"

@implementation FNSpeciItemChoiceNeCell
#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}


- (void)setUpUI
{
    _attLabel = [[UILabel alloc] init];
    _attLabel.textAlignment = NSTextAlignmentCenter;
    _attLabel.font = kFONT13;
    [self addSubview:_attLabel];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_attLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}


#pragma mark - Setter Getter Methods

- (void)setContent:(FNUpGoodsAttrItemNModel *)content
{
    _content = content;
    _attLabel.text = content.name;
    //NSLog(@"isSelect:%@",content.isSelect);
    if (content.isSelect) {
        _attLabel.textColor = [UIColor whiteColor];
        //_attLabel.backgroundColor=FNColor(255, 19, 30);
        _attLabel.backgroundColor=RED;
        [self dc_chageControlCircularWith:_attLabel AndSetCornerRadius:10 SetBorderWidth:1 SetBorderColor:RED canMasksToBounds:YES];
    }else{
        _attLabel.textColor = [UIColor blackColor];
        _attLabel.backgroundColor=FNColor(235, 235, 235);
        [self dc_chageControlCircularWith:_attLabel AndSetCornerRadius:10 SetBorderWidth:1 SetBorderColor:FNColor(235, 235, 235) canMasksToBounds:YES];
    }
}
-(id)dc_chageControlCircularWith:(id)anyControl AndSetCornerRadius:(NSInteger)radius SetBorderWidth:(NSInteger)width SetBorderColor:(UIColor *)borderColor canMasksToBounds:(BOOL)can
{
    CALayer *icon_layer=[anyControl layer];
    [icon_layer setCornerRadius:radius];
    [icon_layer setBorderWidth:width];
    [icon_layer setBorderColor:[borderColor CGColor]];
    [icon_layer setMasksToBounds:can];
    
    return anyControl;
}
@end
