//
//  FNGradeItemNView.m
//  THB
//
//  Created by 李显 on 2018/9/8.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNGradeItemNView.h"

@implementation FNGradeItemNView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self=[super initWithFrame:frame];
    if (self) {
        [self initUI];
        
    }
    return self;
}
-(void)initUI{
    
    CGFloat withZ=self.frame.size.width;
    CGFloat withLine=withZ/3;
    
    self.lineView=[UIImageView new];
    [self addSubview:self.lineView];
    
    self.gradeImage=[UIImageView new];
    [self addSubview:self.gradeImage];
    
    self.lineView.frame=CGRectMake(0, 12.5, withLine, 5);
    self.gradeImage.frame=CGRectMake(self.frame.size.width-20, 5, 20, 20);
    
}


@end
