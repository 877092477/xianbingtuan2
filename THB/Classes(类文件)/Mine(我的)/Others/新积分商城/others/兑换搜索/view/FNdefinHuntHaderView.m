//
//  FNdefinHuntHaderView.m
//  THB
//
//  Created by Jimmy on 2019/1/9.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdefinHuntHaderView.h"

@implementation FNdefinHuntHaderView
- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self headerUIViewS];
    }
    return self;
}

-(void)headerUIViewS{
    //UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, (self.frame.size.height - 18.0f / 2), 18, 18)];
    
    //[self addSubview:imageView];
    
    //self.imageView = imageView;
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(5, (self.frame.size.height - 18.0f / 2), 100.0f, 18)];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:12.0f];
    [self addSubview:label];
    
    self.textLabel = label;
    CGFloat delectBtnW=[self getWidthWithText:@"" height:30 font:12];
    UIButton *delectButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width -70 , (self.frame.size.height - 30.0f / 2), 70, 30)];
    [delectButton setTitleColor:RGB(200, 200, 200) forState:UIControlStateNormal];
    //[delectButton setContentEdgeInsets:UIEdgeInsetsMake(0, 35, 0, 0)];
    //[delectButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [delectButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [delectButton setTitle:@"清空" forState:UIControlStateNormal];
    [delectButton setImage:IMAGE(@"FJ_rightSC_img") forState:UIControlStateNormal];
    [delectButton addTarget:self action:@selector(delect) forControlEvents:UIControlEventTouchUpInside];
    [delectButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5.0f];
    [self addSubview:delectButton];
    
    _delectButton = delectButton;
}
- (void)delect
{
    if ([self.delectDelegate respondsToSelector:@selector(delectData)]) {
        [self.delectDelegate delectData];
    }
}
- (void) setText:(NSString*)text
{
    self.textLabel.text = text;
}

- (void) setImage:(NSString *)image;
{
    [self.imageView setImage:[UIImage imageNamed:image]];
}
//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}
@end
