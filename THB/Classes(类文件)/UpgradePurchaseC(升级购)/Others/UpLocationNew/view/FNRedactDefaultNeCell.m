//
//  FNRedactDefaultNeCell.m
//  THB
//
//  Created by Jimmy on 2018/9/29.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNRedactDefaultNeCell.h"

@implementation FNRedactDefaultNeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=FNWhiteColor;
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
    
    //右边标题
    self.leftLabel=[UILabel new];
    self.leftLabel.text=@"设为默认地址";
    self.leftLabel.font=kFONT13;
    [self.contentView addSubview:self.leftLabel];
    
    self.defaultButton= [UIButton buttonWithType:UIButtonTypeCustom];
    [self.defaultButton sizeToFit];
    [self.defaultButton setImage:[UIImage imageNamed:@"btn_switch_nor"] forState:UIControlStateNormal];
    [self.defaultButton setImage:[UIImage imageNamed:@"btn_switch_pressed"] forState:UIControlStateSelected];
    [self.defaultButton addTarget:self action:@selector(defaultButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.defaultButton];
    
    [self initializedSubviews];

}
#pragma mark - initializedSubviews
- (void)initializedSubviews {
    
    CGFloat interval_10 = 10;
    //右边标题
    self.leftLabel.sd_layout
    .topSpaceToView(self.contentView, interval_10).leftSpaceToView(self.contentView, interval_10).bottomSpaceToView(self.contentView, interval_10);
    [self.leftLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.defaultButton.sd_layout
    .rightSpaceToView(self.contentView, interval_10/2).widthIs(44).heightIs(35).centerYEqualToView(self.contentView);
}
 
-(void)defaultButtonAction{
    self.defaultButton.selected=!self.defaultButton.selected;
    NSString *DefaultString=@"";
    if(self.defaultButton.selected==YES){
        DefaultString=@"1";
    }else{
        DefaultString=@"0";
    }
    if ([self.delegate respondsToSelector:@selector(InRedactDefaultAction:withDefault:)]) {
        [self.delegate InRedactDefaultAction:self.indexPath withDefault:DefaultString];
    } 
}
-(void)setModel:(FNUpAddressNeModel*)model{
    _model=model;
    if(model){
        NSInteger is_acquiesce=[model.is_acquiesce integerValue];
        if(is_acquiesce==1){
            self.defaultButton.selected=YES;
        }else{
            self.defaultButton.selected=NO;
        }
    }
    
}
@end
