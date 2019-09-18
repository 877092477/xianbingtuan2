//
//  XYTabBarButton.m
//  FnuoApp
//
//  Created by zhongxueyu on 16/2/22.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "XYTabBarButton.h"
#import "FNTabManager.h"
#define XYTabBarButtonImageRatio 0.42
@implementation XYTabBarButton

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //图片居中
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        //文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //字体居中
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        //文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[FNTabManager shareInstance].tabs.count>=1 ?[UIColor colorWithHexString:[FNTabManager shareInstance].tabs[0].color_val]: RED forState:UIControlStateSelected];
        
        //添加一个提醒数字按钮
        UIButton *badgeButton = [[UIButton alloc]init];
        [self addSubview:badgeButton];
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted{
    
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * XYTabBarButtonImageRatio;
    return CGRectMake(0, 5, imageW, imageH
);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGFloat  titleY = contentRect.size.height * XYTabBarButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height -titleY-5 ;
    return  CGRectMake(0, titleY+5, titleW, titleH);
}

-(void)setItem:(UITabBarItem *)item{
    _item = item;
    [self setTitle:item.title forState:UIControlStateNormal];
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
}

@end
