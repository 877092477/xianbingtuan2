//
//  FNRushConsigneeDefaultNeCell.m
//  69橙子
//
//  Created by Jimmy on 2018/12/1.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNRushConsigneeDefaultNeCell.h"

@implementation FNRushConsigneeDefaultNeCell

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
    
    self.defaultSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(100, 100, 60, 30)];
    self.defaultSwitch.onTintColor =RGB(1, 172, 243); //[UIColor greenColor];//
    // 设置控件关闭状态填充色
    self.defaultSwitch.tintColor =RGB(240, 240, 240);// [UIColor redColor];
    // 设置控件开关按钮颜色
    self.defaultSwitch.thumbTintColor = RGB(1, 172, 243);// [UIColor orangeColor];
    [self.contentView addSubview:self.defaultSwitch];
    [self.defaultSwitch addTarget:self action:@selector(defaultSwitchAction:) forControlEvents:UIControlEventTouchUpInside];
    [self initializedSubviews];
    
}
-(void)defaultSwitchAction:(UISwitch*)swi{
    NSString *DefaultString=@"0";
    if(swi.isOn){
         XYLog(@"是");
         swi.thumbTintColor =[UIColor whiteColor];
         DefaultString=@"1";
    }else{
         XYLog(@"否");
        DefaultString=@"0";
        swi.thumbTintColor =RGB(1, 172, 243);
    }
    if ([self.delegate respondsToSelector:@selector(InConsigneeDefaultAction:withDefault:)]) {
        [self.delegate InConsigneeDefaultAction:self.indexPath withDefault:DefaultString];
    }
}

#pragma mark - initializedSubviews
- (void)initializedSubviews {
    
    CGFloat interval_10 = 10;
    //右边标题
    self.leftLabel.sd_layout
    .topSpaceToView(self.contentView, interval_10).leftSpaceToView(self.contentView, interval_10).bottomSpaceToView(self.contentView, interval_10);
    [self.leftLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.defaultSwitch.sd_layout
    .rightSpaceToView(self.contentView, interval_10).widthIs(60).heightIs(30).centerYEqualToView(self.contentView);
}


-(void)setModel:(NSDictionary*)model{
    _model=model;
    if(model){
       // NSInteger is_acquiesce=[model.is_acquiesce integerValue];
       // if(is_acquiesce==1){
            self.defaultButton.selected=YES;
        [self.defaultSwitch setOn:YES];
       // }else{
            self.defaultButton.selected=NO;
        [self.defaultSwitch setOn:NO];
       // }
    }
    
}

@end
