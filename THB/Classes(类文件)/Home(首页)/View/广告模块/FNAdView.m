//
//  FNAdView.m
//  THB
//
//  Created by zhongxueyu on 2018/8/20.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNAdView.h"

@interface FNAdView ()


@end

@implementation FNAdView

#pragma mark- 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=FNWhiteColor;

    }
    return self;
}

#pragma mark - 初始化视图
-(void)addContentView:(NSArray *)imgArr{
    
    //将之前的视图移除
    for (UIView *views in self.subviews) {
        [views removeFromSuperview];
    }
    
    if(imgArr.count>0){
        CGFloat padding = 0;
        
//        if (imgArr.count>1) {
//            padding = 5;
//        }
        
        CGFloat imgW = (JMScreenWidth-(padding*imgArr.count+padding))/imgArr.count;
        
        //        CGFloat imgH=image.size.height/image.size.width*imgW;
        
        for (int i = 0; i<imgArr.count; i++) {
            UIImageView *posterImgView = [[UIImageView alloc]initWithFrame:CGRectMake(padding+i*imgW+padding*i, padding, imgW, 0)];
            posterImgView.userInteractionEnabled = YES;
            posterImgView.tag = i;
            
            posterImgView.contentMode = UIViewContentModeScaleToFill;
//            self.posterImgView = posterImgView;
            [self addSubview:posterImgView];

            [posterImgView sd_setImageWithURL:[NSURL URLWithString:imgArr[i]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

                if(image){
                    posterImgView.height=image.size.height/image.size.width*imgW;
//                    [self layoutIfNeeded];
                }
            }];
            @WeakObj(self);
            int index = i;
            [posterImgView addJXTouch:^{
                //添加点击方法
                if (selfWeak.adViewClicked) {
                    selfWeak.adViewClicked(index);
                }
            }];
            
        }
//        [self layoutIfNeeded];
    }
}


-(void)setImgArr:(NSMutableArray *)imgArr{
    _imgArr = imgArr;
    [self addContentView:_imgArr];
}
@end
