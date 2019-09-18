//
//  XQNewFeatureVC.m
//  XQNewFeatureVC
//
//  Created by 徐强 on 15/10/13.
//  Copyright © 2015年 xuqiang. All rights reserved.
//

#import "XQNewFeatureVC.h"
#import "XQNewFeatureBaseVc.h"


#define screenW  self.view.bounds.size.width
#define screenH  self.view.bounds.size.height

@interface XQNewFeatureVC () <UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, assign) NSInteger fromePage;

@end

@implementation XQNewFeatureVC

- (instancetype)initWithFeatureImagesNameArray:(NSArray *)imagesNameArray{
    
    if (self = [super init]) {
        self.imagesNameArray = imagesNameArray;
    }
    
    return self;
}

- (instancetype)initWithFeatureControllerArray:(NSArray *)controllersArray{
    
    if (self = [super init]) {
        self.controllersArray = controllersArray;
    }
    
    return self;
}
- (UIButton *)completeBtn{
    if (_completeBtn == nil) {
        _completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _completeBtn.backgroundColor     = self.completeBtnColor?self.completeBtnColor:[UIColor redColor];
        _completeBtn.layer.cornerRadius  = self.completeBtnCornerRadius?self.completeBtnCornerRadius:0;
        _completeBtn.layer.masksToBounds = YES;
        [_completeBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_completeBtn.layer setMasksToBounds:YES];
        [_completeBtn.layer setCornerRadius:8.0];//设置矩形四个圆角半径
        
        [_completeBtn setBackgroundColor:[UIColor clearColor]];
        
        
        [_completeBtn setTitle:self.completeBtnTitle?self.completeBtnTitle:@"" forState:UIControlStateNormal];
        [_completeBtn setBackgroundImage:self.completeBtnBackgroundImage?self.completeBtnBackgroundImage:nil forState:UIControlStateNormal];
        [_completeBtn setImage:self.completeBtnImage?self.completeBtnImage:nil forState:UIControlStateNormal];
        [_completeBtn sizeToFit];
    }
    return _completeBtn;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView                  = [[UIScrollView alloc] init];
    scrollView.backgroundColor                = [UIColor whiteColor];
    scrollView.frame                          = self.view.bounds;
    scrollView.delegate                       = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled                  = YES;
    scrollView.bounces                        = NO;
    
    [self.view addSubview:scrollView];
    
    if (self.imagesNameArray.count == 0 && self.controllersArray.count == 0) {
        UILabel *label      = [[UILabel alloc] init];
        label.frame         = CGRectMake(0, self.view.frame.size.height/2 - 30, self.view.frame.size.width, 60);
        label.text          = @"没有添加展示资源";
        [scrollView addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        return;
    }
    
    UIPageControl *pageControl           = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 30, self.view.bounds.size.width, 30)];
    pageControl.pageIndicatorTintColor   = self.pageIndicatorTintColor ? self.pageIndicatorTintColor : [UIColor grayColor];
    pageControl.numberOfPages            = self.imagesNameArray.count  ? self.imagesNameArray.count  : self.controllersArray.count;
    pageControl.hidesForSinglePage       = YES;
    pageControl.hidden                   = self.pageControlHidden;
    pageControl.defersCurrentPageDisplay = YES;
    
    [self.view addSubview:pageControl];
    self.pageControl                     = pageControl;
    
    NSUInteger count                     = self.imagesNameArray.count ? self.imagesNameArray.count : self.controllersArray.count;
    scrollView.contentSize               = CGSizeMake(screenW * count, screenH);
    
    if (self.imagesNameArray.count) {
        
        for (int i = 0; i<self.imagesNameArray.count; i++) {
            
            NSString *imageName    = self.imagesNameArray[i];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
            imageView.frame        = CGRectMake(screenW * i, 0, screenW, screenH);
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            [scrollView addSubview:imageView];
            
            if (i == self.imagesNameArray.count - 1) {
                imageView.userInteractionEnabled = YES;
                [imageView addSubview:self.completeBtn];
                
                
                CGSize size = self.completeBtn.bounds.size;
                if (JM_isHideSTBtn.boolValue) {
                    
                    self.completeBtn.frame = CGRectMake(0,0,screenW,screenH);
                    
                }else{
                    self.completeBtn.frame = CGRectMake(0,screenH-(size.height+30)-40 ,size.width+30,size.height+30);
                    self.completeBtn.centerX  = screenW*0.5;
                }
                
                
                
            }
            
        }
        
    }else if(self.controllersArray.count){
        
        for (int i = 0; i<self.controllersArray.count; i++) {
            
            UIViewController *vc = self.controllersArray[i];
            vc.view.frame        = CGRectMake(screenW * i, 0, screenW, screenH);
            [scrollView addSubview:vc.view];
        }
    }
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    self.fromePage = self.pageControl.currentPage;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    self.pageControl.currentPage = (scrollView.contentOffset.x + screenW/2) / screenW;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (self.imagesNameArray.count) {
        
    }else if (self.controllersArray.count){
        XQNewFeatureBaseVc *currentVc = self.controllersArray[self.pageControl.currentPage];
        [currentVc thisVcDidEnterForeground];
        
        XQNewFeatureBaseVc *fromeVc = self.controllersArray[self.fromePage];
        [fromeVc thisVcDidEnterBackground];
        
    }
}

- (void)completeBtnClick{
    
    if (self.completeBlock) {
        self.completeBlock();
    }
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}



@end

