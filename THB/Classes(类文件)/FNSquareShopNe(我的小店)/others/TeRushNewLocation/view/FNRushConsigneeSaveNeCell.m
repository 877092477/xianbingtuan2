//
//  FNRushConsigneeSaveNeCell.m
//  69橙子
//
//  Created by Jimmy on 2018/12/1.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNRushConsigneeSaveNeCell.h"

@implementation FNRushConsigneeSaveNeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //self.contentView.backgroundColor=FNWhiteColor;
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
    self.contentView.backgroundColor=RGB(240, 240, 240);
    self.saveButton= [UIButton buttonWithType:UIButtonTypeCustom];
    [self.saveButton setTitle:@"保存并使用" forState:UIControlStateNormal];
    [self.saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.saveButton addTarget:self action:@selector(defaultButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.saveButton];
    self.saveButton.backgroundColor=RGB(1, 172, 243);
    self.saveButton.cornerRadius=5;
    [self initializedSubviews];
    
}
#pragma mark - initializedSubviews
- (void)initializedSubviews {
    
    CGFloat interval_10 = 10;
    self.saveButton.sd_layout
    .rightSpaceToView(self.contentView, interval_10).centerYEqualToView(self.contentView).topSpaceToView(self.contentView, interval_10).bottomSpaceToView(self.contentView, interval_10).leftSpaceToView(self.contentView, interval_10);
}

-(void)defaultButtonAction{
    
    if ([self.delegate respondsToSelector:@selector(InConsigneeDefaultAction)]) {
        [self.delegate InConsigneeDefaultAction];
    }
}


@end
