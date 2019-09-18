//
//  FNHomeFunctionBtn.m
//  THB
//
//  Created by jimmy on 2017/4/8.
//  Copyright © 2017年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */
#import "FNHomeFunctionBtn.h"
#define frameWidth frame.size.width
//#define imageWidth 38  // 图片宽度,高度等
#define imageTopH  6  // 图片距顶距离

@implementation FNHomeFunctionBtn
{
    NSString *_title;
    NSString *_imageURL;
}
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title andImageURL:(NSString *)url
{
    self = [super initWithFrame:frame];
    if (self) {
        _title = title;
        _imageURL = url;
        CGFloat width = frame.size.width - 2 * imageTopH;
        CGFloat height = frame.size.height - 24 - imageTopH;
        CGFloat imageWidth = width < height ? width : height;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((frameWidth-imageWidth)/2,imageTopH,imageWidth,imageWidth)];
        
        if ([_imageURL containsString:@"http"]) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:_imageURL] placeholderImage:[UIImage imageNamed:@"APP底图"]];
        }else{
            imageView.image = IMAGE(_imageURL);
        }
        
        [self addSubview:imageView];
        _imgView = imageView;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, imageTopH+imageWidth+5,frameWidth, imageWidth/2)];
        label.text = _title;
        label.font  = kFONT14;
        //    label.textColor = [UIColor whiteColor];
        [label sizeToFit];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        _titleLabel = label;
        //layout
//        CGFloat verticalMargin  = 0.1*self.height;
//        CGFloat imgH = 38;
//
        //    [imageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        //    [imageView autoSetDimensionsToSize:CGSizeMake(imgH, imgH)];
        //    [imageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:verticalMargin];
        
//        [label autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [label autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
//        [self initializedSubviews];
    }
    return self;
}
#pragma mark - initializedSubviews
- (void)initializedSubviews
{
    
}

@end
