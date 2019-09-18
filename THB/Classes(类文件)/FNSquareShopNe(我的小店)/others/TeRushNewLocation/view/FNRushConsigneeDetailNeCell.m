//
//  FNRushConsigneeDetailNeCell.m
//  69橙子
//
//  Created by Jimmy on 2018/12/1.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//门牌号
#import "FNRushConsigneeDetailNeCell.h"

@implementation FNRushConsigneeDetailNeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=FNWhiteColor;
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
    
    CGFloat interval_10 = 10;
    //左边标题
    self.leftLabel=[UILabel new];
    self.leftLabel.text=@"门牌号";
    self.leftLabel.font=kFONT12;
    self.leftLabel.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:self.leftLabel];
    //左边标题
    self.leftLabel.sd_layout
    .leftSpaceToView(self.contentView, interval_10).heightIs(20).widthIs(50).centerYEqualToView(self.contentView);
    
    //输入
    UITextView *siteView=[UITextView new];
    siteView.backgroundColor=[UIColor whiteColor];
    siteView.editable = YES;
    siteView.delegate = self;
    siteView.font = kFONT13;
    siteView.scrollEnabled = YES;
    [self.contentView addSubview:siteView];
    siteView.sd_layout
    .leftSpaceToView(self.leftLabel, interval_10).rightSpaceToView(self.contentView, interval_10).topSpaceToView(self.contentView, 5).bottomSpaceToView(self.contentView, 5);
    self.siteView=siteView;
    
    //placeholder
    UILabel *placeholderLabel=[UILabel new] ;
    placeholderLabel.textColor=[UIColor lightGrayColor];
    placeholderLabel.numberOfLines=2;
    placeholderLabel.text=@"详细地址:如道路、门牌号、小区、单元室等";
    [placeholderLabel sizeToFit];
    placeholderLabel.font=kFONT13;
    placeholderLabel.textAlignment=NSTextAlignmentLeft;
    [self.siteView addSubview:placeholderLabel];
    placeholderLabel.sd_layout.leftSpaceToView(self.siteView, 5).rightSpaceToView(self.siteView, 5).heightIs(30).topSpaceToView(self.siteView, 0);
    //[placeholderLabel setSingleLineAutoResizeWithMaxWidth:150];
    self.placeholderLabel = placeholderLabel;
    
    /** Line **/
    self.LineLB=[UILabel new];
    self.LineLB.backgroundColor=FNColor(240,240,240);
    [self.contentView addSubview:self.LineLB];
    self.LineLB.sd_layout
    .leftSpaceToView(self.contentView, interval_10).rightSpaceToView(self.contentView, interval_10).heightIs(1).bottomSpaceToView(self.contentView, 0);
    
}
//当textView的内容发生改变的时候调用
- (void)textViewDidChange:(UITextView *)textView { 
    
    if([textView.text kr_isNotEmpty]){
        self.placeholderLabel.hidden = YES;
    }else{
        self.placeholderLabel.hidden = NO;
    }
    
    if ([self.delegate respondsToSelector:@selector(InConsigneeDetailAction:withSite:)]) {
        [self.delegate InConsigneeDetailAction:self.indexPath withSite:textView.text];
    }
}

@end
