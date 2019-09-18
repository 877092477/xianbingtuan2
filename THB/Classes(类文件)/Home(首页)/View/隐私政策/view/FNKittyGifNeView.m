//
//  FNKittyGifNeView.m
//  THB
//
//  Created by Jimmy on 2018/10/13.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNKittyGifNeView.h"
#import "UIImage+GIF.h"

FNKittyGifNeView * _GifNeView = nil;

@implementation FNKittyGifNeView
{
    UIView *view;
    UIImageView *kityimage;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self showloadkittyGif];
    }
    return self;
}
+ (instancetype)shareInstance{
    if (_GifNeView == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _GifNeView = [[FNKittyGifNeView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
        });
    }
    return _GifNeView;
}
-(void)showloadkittyGif{
    
    view = [[UIView alloc] initWithFrame:self.bounds];
    
    view.backgroundColor = FNBlackColorWithAlpha(0.4);
    
    [self addSubview:view];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    NSData *imagedata = [defaults objectForKey:@"kittyGif"];
    
    kityimage=[[UIImageView alloc]init];
    
    [view addSubview:kityimage];
    
    kityimage.image=[UIImage sd_animatedGIFWithData:imagedata];
    
    kityimage.sd_layout
    .centerYEqualToView(view).centerXEqualToView(view).widthIs(60).heightIs(60); 
    
}
+(void)showView:(UIView *)view{
    
    _GifNeView = [FNKittyGifNeView shareInstance];
    
    [view addSubview:_GifNeView];
    
}
#pragma mark - 消失
+(void)hideView{
     
    [UIView animateWithDuration:0.25f animations:^{
        
    } completion:^(BOOL finished) {
        
        [_GifNeView removeFromSuperview];
        
    }];
    
} 
@end
