//
//  FNMarqueeViewCell.m
//  THB
//
//  Created by zhongxueyu on 2018/8/20.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNMarqueeViewCell.h"

@implementation FNMarqueeViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.index_paomadeng_01List = [NSMutableArray new];
        [self initializedSubviews];
        
    }
    
    return self;
}

- (void)initializedSubviews
{
    //跑马灯模块
    FNScrollmonkeyView *ScrollmonkeyView = [[FNScrollmonkeyView alloc] initWithFrame:CGRectMake(0, 0, JMScreenWidth, 45)];
    ScrollmonkeyView.backgroundColor=FNWhiteColor;
    ScrollmonkeyView.ScrollTextView.textColor = RGBA(102, 102, 102, 102);
    ScrollmonkeyView.Image.image=IMAGE(@"hhorn");
    [self addSubview:ScrollmonkeyView];
    self.FNMarqueeView=ScrollmonkeyView;
}


-(void)setIndex_paomadeng_01List:(NSMutableArray *)index_paomadeng_01List{
    _index_paomadeng_01List = index_paomadeng_01List;
    if (index_paomadeng_01List.count>0) {
        //设置跑马灯
        [self.FNMarqueeView setSuper_msglist:self.index_paomadeng_01List];

    }

}
@end
