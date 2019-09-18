//
//  CircPhotoView.m
//  THB
//
//  Created by 李显 on 2018/8/26.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "CircPhotoView.h"

@implementation CircPhotoView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllView];
    }
    return self;
}

-(void)setUpAllView{
    for (int i =0; i<9; i++) {
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.clipsToBounds = YES;
        imageV.userInteractionEnabled = YES;
        imageV.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgVClick:)];
        [imageV addGestureRecognizer:tap];
        [self addSubview:imageV];
    }
}
// 图片点击事件
-(void)imgVClick:(UITapGestureRecognizer *)sender{
    NSLog(@"点击了第%ld个图片",sender.view.tag + 1);
    if ([self.delegate respondsToSelector:@selector(pitchOnClickAction:)] ) {
        [self.delegate pitchOnClickAction:sender.view.tag];
    }
}
// 设置图片
-(void)setPic_urls:(NSArray *)pic_urls{
    _pic_urls = pic_urls;
    NSInteger count = self.subviews.count;
    for (int i = 0; i<count; i++) {
        UIImageView *imageV = self.subviews[i];
        if (i<pic_urls.count) {
            //[imageV yy_setImageWithURL:[NSURL URLWithString:pic_urls[i]] options:YYWebImageOptionShowNetworkActivity];
            [imageV setUrlImg:pic_urls[i]];
            imageV.hidden = NO;
        }else{
            imageV.hidden = YES;
        }
    }
}
// 计算尺寸
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = (self.frame.size.width - 6) / 3;
    CGFloat h = w;
    CGFloat margin  = 3;
    int col = 0 ;
    int rol = 0;
    
    NSInteger count = _pic_urls.count;
    
    //int cols = count == 4?2:3;
    int cols = 3;
    // 计算显示出来的imageView
    for (int i = 0; i < count; i++) {
        col = i % cols;
        rol = i / cols;
        UIImageView *imageV = self.subviews[i];
        x = col * (w + margin);
        y = rol * (h + margin);
        imageV.frame = CGRectMake(x, y, w, h);
        if(count==1){
            imageV.frame =  CGRectMake(x, y, self.frame.size.width, self.frame.size.height);;
        }
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
