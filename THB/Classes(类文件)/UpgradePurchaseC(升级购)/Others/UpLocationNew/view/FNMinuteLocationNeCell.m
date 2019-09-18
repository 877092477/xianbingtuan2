//
//  FNMinuteLocationNeCell.m
//  THB
//
//  Created by Jimmy on 2018/9/29.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNMinuteLocationNeCell.h"

@implementation FNMinuteLocationNeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=FNWhiteColor;
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
    
    CGFloat interval_10 = 10;
    
    //输入
    UITextView *siteView=[UITextView new];
    siteView.backgroundColor=[UIColor whiteColor];
    siteView.editable = YES;
    siteView.delegate = self;
    siteView.font = kFONT13;
    siteView.scrollEnabled = YES;
    [self.contentView addSubview:siteView];
    siteView.sd_layout
    .leftSpaceToView(self.contentView, interval_10).rightSpaceToView(self.contentView, interval_10).topSpaceToView(self.contentView, interval_10).heightIs(80);
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
    .leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(interval_10).bottomSpaceToView(self.contentView, 0);
    
    
    
}
//当textView的内容发生改变的时候调用
- (void)textViewDidChange:(UITextView *)textView {
    XYLog(@"textView:%@",textView.text);
    //NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //paragraphStyle.lineSpacing = 5;// 字体的行间距
    //NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSParagraphStyleAttributeName:paragraphStyle};
    //textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
    if([textView.text kr_isNotEmpty]){
        self.placeholderLabel.hidden = YES;
    }else{
        self.placeholderLabel.hidden = NO;
    }
    
    if ([self.delegate respondsToSelector:@selector(InDetaileRedactSiteAction:withSite:)]) {
        [self.delegate InDetaileRedactSiteAction:self.indexPath withSite:textView.text];
    } 
}

@end
