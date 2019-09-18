//
//  FNLocationItemNameNeCell.m
//  THB
//
//  Created by Jimmy on 2018/9/29.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNLocationItemNameNeCell.h"

@implementation FNLocationItemNameNeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=FNWhiteColor;
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{ 

    //右边图片
    self.directionImage=[UIImageView new];
    self.directionImage.contentMode=UIViewContentModeScaleToFill;
    self.directionImage.image=IMAGE(@"btn__more_nor");
    [self.contentView addSubview:self.directionImage];
    
    //编辑
    self.NameText=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    self.NameText.placeholder = @"收货人";
    self.NameText.delegate=self;
    self.NameText.font = kFONT13;
    [self.contentView addSubview:self.NameText];
    
    //右边标题
    self.rightLabel=[UILabel new];
    self.rightLabel.numberOfLines=2;
    self.rightLabel.textColor=FNColor(200,200,200);
    self.rightLabel.font=kFONT12;
    [self.contentView addSubview:self.rightLabel];
    
    /** Line **/
    self.LineLB=[UILabel new];
    self.LineLB.backgroundColor=FNColor(240,240,240);
    [self.contentView addSubview:self.LineLB];
    
    
    [self initializedSubviews];
    
    
}
#pragma mark - initializedSubviews
- (void)initializedSubviews {
    
    CGFloat interval_10 = 10;
    //右边图片
    self.directionImage.sd_layout
    .rightSpaceToView(self.contentView, interval_10).widthIs(8).heightIs(15).centerYEqualToView(self.contentView);
    self.NameText.sd_layout
    .topSpaceToView(self.contentView, interval_10).leftSpaceToView(self.contentView, interval_10).bottomSpaceToView(self.contentView, interval_10).widthIs(200);
    //右边标题
    self.rightLabel.sd_layout
    .topSpaceToView(self.contentView, interval_10/2).rightSpaceToView(self.directionImage, interval_10).bottomSpaceToView(self.contentView, interval_10/2);
    [self.rightLabel setSingleLineAutoResizeWithMaxWidth:260];
    self.LineLB.sd_layout
    .leftSpaceToView(self.contentView, interval_10).rightSpaceToView(self.contentView, interval_10).heightIs(1).bottomSpaceToView(self.contentView, 0);
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(InHeadCopyreaderAction:withContent:)]) {
        [self.delegate InHeadCopyreaderAction:self.indexPath withContent:textField.text];
    } 
}
@end
