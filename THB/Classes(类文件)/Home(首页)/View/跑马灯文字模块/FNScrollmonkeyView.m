//
//  FNScrollmonkeyView.m
//  超级模式
//
//  Created by Fnuo-iOS on 2018/3/16.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNScrollmonkeyView.h"

@implementation FNScrollmonkeyView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        UIImageView *Image=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, frame.size.height-30, frame.size.height-30)];
        Image.contentMode=UIViewContentModeScaleAspectFit;
        [self addSubview:Image];
        self.Image=Image;
        
        FNScrollTextView* ScrollTextView = [[FNScrollTextView alloc] initWithFrame:CGRectMake(CGRectGetWidth(Image.frame)+20, 0, frame.size.width-(CGRectGetWidth(Image.frame)+25), frame.size.height-2)];
        ScrollTextView.delegate = self;
        ScrollTextView.backgroundColor = [UIColor clearColor];
        ScrollTextView.textFont = kFONT14;
        ScrollTextView.textAlignment = NSTextAlignmentLeft;
        ScrollTextView.touchEnable = YES;
        [self addSubview:ScrollTextView];
        self.ScrollTextView=ScrollTextView;
        
    }
    return self;
}

-(void)setSuper_msglist:(NSMutableArray *)super_msglist{
    XYLog(@"super_msglist is %@",super_msglist);
    _super_msglist=super_msglist;
    if (_super_msglist.count>0) {
        NSMutableArray *TitleArr=[[NSMutableArray alloc]init];
        for (Index_paomadeng_01Model *model in super_msglist) {
            [TitleArr addObject:model.detail];
        }
        self.ScrollTextView.textDataArr = TitleArr;
        [self.ScrollTextView startScrollBottomToTopWithNoSpace];//从下到上不留间隔
    }
}

#pragma mark - FNScrollTextViewDelegate
- (void)scrollTextView:(FNScrollTextView *)scrollTextView currentTextIndex:(NSInteger)index{
    //当前显示信息
    Index_paomadeng_01Model *model=self.super_msglist[index];
    [[NSUserDefaults standardUserDefaults] setObject:model.id forKey:@"NewSuper_msgID"];
}
- (void)scrollTextView:(FNScrollTextView *)scrollTextView clickIndex:(NSInteger)index content:(NSString *)content{
    //点击当前信息
    Index_paomadeng_01Model *model=self.super_msglist[index];
}

@end
