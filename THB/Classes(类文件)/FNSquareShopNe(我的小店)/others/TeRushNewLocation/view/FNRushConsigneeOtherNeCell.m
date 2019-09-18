//
//  FNRushConsigneeOtherNeCell.m
//  69橙子
//
//  Created by Jimmy on 2018/12/1.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//电话或者地址
#import "FNRushConsigneeOtherNeCell.h"

@implementation FNRushConsigneeOtherNeCell

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
    self.NameText.delegate=self;
    self.NameText.font = kFONT13;
    [self.contentView addSubview:self.NameText];
    
    //左边标题
    self.leftLabel=[UILabel new];
    //self.leftLabel.backgroundColor=[UIColor lightGrayColor];
    self.leftLabel.font=kFONT12;
    self.leftLabel.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:self.leftLabel];
    
    self.rightButton= [UIButton buttonWithType:UIButtonTypeCustom]; 
    self.rightButton.titleLabel.font=kFONT12;
    [self.rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    // [self.rightButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10.0f];
    [self.contentView addSubview:self.rightButton];
    
    /** Line **/
    self.LineLB=[UILabel new];
    self.LineLB.backgroundColor=FNColor(240,240,240);
    [self.contentView addSubview:self.LineLB]; 
    
    [self initializedSubviews];
   
    
   
}
#pragma mark - initializedSubviews
- (void)initializedSubviews {
    
    CGFloat interval_10 = 10;
    CGFloat interval_2 = 2;
    self.rightButton.sd_layout
    .rightSpaceToView(self.contentView, interval_10).centerYEqualToView(self.contentView).heightIs(20).widthIs(65);
    self.rightButton.imageView.sd_layout
    .widthIs(5).heightIs(9).centerYEqualToView(self.rightButton).rightSpaceToView(self.rightButton, 0);
    self.rightButton.titleLabel.textAlignment=NSTextAlignmentRight;
    self.rightButton.titleLabel.sd_layout
    .centerYEqualToView(self.rightButton).heightIs(20).rightSpaceToView(self.rightButton.imageView, interval_10).leftSpaceToView(self.rightButton, 0);
    //[self.rightButton setupAutoSizeWithHorizontalPadding:2 buttonHeight:20];
    
    //左边标题
    self.leftLabel.sd_layout
    .leftSpaceToView(self.contentView, interval_10).heightIs(20).widthIs(50).centerYEqualToView(self.contentView);
    
    self.NameText.sd_layout
    .leftSpaceToView(self.leftLabel, interval_10).heightIs(30).rightSpaceToView(self.contentView, 90).centerYEqualToView(self.leftLabel);
    
    self.LineLB.sd_layout
    .leftSpaceToView(self.contentView, interval_10).rightSpaceToView(self.contentView, interval_10).heightIs(1).bottomSpaceToView(self.contentView, 0);
    
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(InOtherCopyreaderAction:withContent:)]) {
        [self.delegate InOtherCopyreaderAction:self.indexPath withContent:textField.text];
    }
}
-(void)rightButtonAction{
    if ([self.delegate respondsToSelector:@selector(InOtherRightButtonActionR:)]) {
        [self.delegate InOtherRightButtonActionR:self.indexPath];
    }
    
}
-(void)setRightState:(NSInteger)rightState{
    _rightState=rightState;
    if (rightState==1) {
        [self.rightButton setTitleColor:RGB(110, 150, 253) forState:UIControlStateNormal];
        [self.rightButton setTitle:@"通讯录" forState:UIControlStateNormal];
        [self.rightButton setImage:IMAGE(@"") forState:UIControlStateNormal];
        self.leftLabel.text = @"电话";
        self.NameText.placeholder = @"手机号码";
    }else if(rightState==2){
        [self.rightButton setTitle:@"请选择" forState:UIControlStateNormal];
        [self.rightButton setImage:IMAGE(@"pay_tanb_back") forState:UIControlStateNormal];
       
        [self.rightButton setTitleColor:RGB(174, 174, 174) forState:UIControlStateNormal];
        self.leftLabel.text = @"地址";
        self.NameText.placeholder = @"请选择收货地址";
    }
}
@end
