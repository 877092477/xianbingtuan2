//
//  FNRushConsigneeNameNeCell.m
//  69橙子
//
//  Created by Jimmy on 2018/12/1.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNRushConsigneeNameNeCell.h"

@implementation FNRushConsigneeNameNeCell

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
    //self.rightLabel.backgroundColor=[UIColor lightGrayColor];
    self.leftLabel.font=kFONT12;
    self.leftLabel.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:self.leftLabel];
    
    /** Line **/
    self.LineLB=[UILabel new];
    self.LineLB.backgroundColor=FNColor(240,240,240);
    [self.contentView addSubview:self.LineLB];
    self.maleButton= [UIButton buttonWithType:UIButtonTypeCustom];
    self.maleButton.titleLabel.font=kFONT12;
    self.maleButton.cornerRadius=5;
    [self.maleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.maleButton addTarget:self action:@selector(maleButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.maleButton.borderWidth=0.5;
    self.maleButton.borderColor = FNGlobalTextGrayColor;
    [self.contentView addSubview:self.maleButton];
    
    self.ladyButton= [UIButton buttonWithType:UIButtonTypeCustom];
    self.ladyButton.cornerRadius=5;
    self.ladyButton.titleLabel.font=kFONT12;
    [self.ladyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.ladyButton addTarget:self action:@selector(ladyButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.ladyButton.borderWidth=0.5;
    self.ladyButton.borderColor = FNGlobalTextGrayColor;
    [self.contentView addSubview:self.ladyButton];
    
    
    [self initializedSubviews];
    self.leftLabel.text = @"联系人";
    self.NameText.placeholder = @"姓名";
    [self.maleButton setTitle:@"先生" forState:UIControlStateNormal];
    [self.ladyButton setTitle:@"女士" forState:UIControlStateNormal];
    
}
#pragma mark - initializedSubviews
- (void)initializedSubviews {
    
    CGFloat interval_10 = 10;
    CGFloat interval_7 = 7;
    CGFloat interval_20 = 20;
    //右边图片
    //self.directionImage.sd_layout
    //.rightSpaceToView(self.contentView, interval_10).widthIs(8).heightIs(15).centerYEqualToView(self.contentView);
   
    //左边标题
    self.leftLabel.sd_layout
    .topSpaceToView(self.contentView, interval_20).leftSpaceToView(self.contentView, interval_10).heightIs(20).widthIs(50);
    
    self.NameText.sd_layout
    .leftSpaceToView(self.leftLabel, interval_10).heightIs(40).rightSpaceToView(self.contentView, interval_10).centerYEqualToView(self.leftLabel);
    
    self.LineLB.sd_layout
    .leftSpaceToView(self.leftLabel, interval_10).rightSpaceToView(self.contentView, interval_10).heightIs(1).topSpaceToView(self.NameText, 0);
    
    self.maleButton.sd_layout
    .topSpaceToView(self.LineLB, interval_7).leftSpaceToView(self.leftLabel, interval_10).widthIs(60).heightIs(30);
    
    self.ladyButton.sd_layout
    .topSpaceToView(self.LineLB, interval_7).leftSpaceToView(self.maleButton, interval_10).widthIs(60).heightIs(30);
    
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(InConsigneeNameAction:withContent:)]) {
        [self.delegate InConsigneeNameAction:self.indexPath withContent:textField.text];
    }
}
-(void)maleButtonAction{
    self.maleButton.borderColor = RGB(1, 172, 243);
    self.ladyButton.borderColor = FNGlobalTextGrayColor;
    if ([self.delegate respondsToSelector:@selector(inConsigneechoicegender:)]) {
        [self.delegate inConsigneechoicegender:1];
    }
}
-(void)ladyButtonAction{
    self.maleButton.borderColor = FNGlobalTextGrayColor;
    self.ladyButton.borderColor = RGB(1, 172, 243);

    if ([self.delegate respondsToSelector:@selector(inConsigneechoicegender:)]) {
        [self.delegate inConsigneechoicegender:2];
    }
}
-(void)setModel:(FNrushSiteDaNeModel *)model{
    _model=model;
    if(model){
        if([model.name kr_isNotEmpty]){
            self.NameText.text= model.name;
        }
         
        if(model.sex==0){
            self.maleButton.borderColor = RGB(1, 172, 243);
            self.ladyButton.borderColor = FNGlobalTextGrayColor;
        }else{
            self.maleButton.borderColor = FNGlobalTextGrayColor;
            self.ladyButton.borderColor = RGB(1, 172, 243);
        }
    }
}
@end
