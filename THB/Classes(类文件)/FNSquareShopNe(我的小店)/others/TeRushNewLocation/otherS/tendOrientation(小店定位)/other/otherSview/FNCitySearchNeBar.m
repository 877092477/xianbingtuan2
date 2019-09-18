//
//  FNCitySearchNeBar.m
//  69橙子
//
//  Created by 李显 on 2018/12/9.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNCitySearchNeBar.h"

@implementation FNCitySearchNeBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return self;
    }
    return self;
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    UITextField *searchField;
    NSArray *subviewArr = self.subviews;
    for(int i = 0; i < subviewArr.count ; i++) {
        UIView *viewSub = [subviewArr objectAtIndex:i];
        NSArray *arrSub = viewSub.subviews;
        for (int j = 0; j < arrSub.count ; j ++) {
            id tempId = [arrSub objectAtIndex:j];
            if([tempId isKindOfClass:[UITextField class]]) {
                searchField = (UITextField *)tempId;
            }
        }
    }
    
    //自定义UISearchBar
    if(searchField) {
        searchField.placeholder = @"搜索城市";
        [searchField setBorderStyle:UITextBorderStyleRoundedRect];
        [searchField setBackgroundColor:[UIColor whiteColor]];
        [searchField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [searchField setTextAlignment:NSTextAlignmentLeft];
        [searchField setTextColor:[UIColor blackColor]];
        
        SEL centerSelector = NSSelectorFromString([NSString stringWithFormat:@"%@%@", @"setCenter", @"Placeholder:"]);
        if ([self respondsToSelector:centerSelector])
        {
            NSMethodSignature *signature = [[UISearchBar class] instanceMethodSignatureForSelector:centerSelector];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setTarget:self];
            [invocation setSelector:centerSelector];
            //[invocation setArgument:&_hasCentredPlaceholder atIndex:2];
            [invocation invoke];
        }
        //        //自己的搜索图标
        //        NSString *path = [[NSBundle mainBundle] pathForResource:@"search1" ofType:@"png"];
        //        UIImage *image = [UIImage imageWithContentsOfFile:path];
        //        UIImageView *iView = [[UIImageView alloc] initWithImage:image];
        //        [iView setFrame:CGRectMake(0.0, 0.0, 16.0, 16.0)];
        //        searchField.leftView = iView;
    }
    
    //外部背景
    UIView *outView = [[UIView alloc] initWithFrame:self.bounds];
    [outView setBackgroundColor:[UIColor whiteColor]];
    [self insertSubview:outView atIndex:1];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
