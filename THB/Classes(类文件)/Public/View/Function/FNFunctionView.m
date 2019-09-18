//
//  FNFunctionView.m
//  SuperMode
//
//  Created by jimmy on 2017/11/3.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNFunctionView.h"
#import "FNFunctionScrollView.h"
const CGFloat pageH = 20;
const CGFloat menuH = 155-8;

@interface FNFunctionView()<UIGestureRecognizerDelegate,UIScrollViewDelegate>
@property (nonatomic, strong)NSMutableArray* views;

@property(nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic, strong) UIColor *pageColor;

@end
@implementation FNFunctionView
- (NSMutableArray *)views
{
    if (_views == nil) {
        _views = [NSMutableArray new];
    }
    return _views;
}
- (UIScrollView *)scrollview{
    if (_scrollview == nil) {
        _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,XYScreenWidth,menuH+pageH)];
        _scrollview.showsVerticalScrollIndicator= NO;
        _scrollview.delegate=self;

        _scrollview.showsHorizontalScrollIndicator = NO;
        
    }
    return _scrollview;
}
#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    self.column = 4;
    self.row = 2;
    self.singleH = 60;
//    self.singleH = 43;
    [self addSubview:self.scrollview];
    self.scrollview.showsHorizontalScrollIndicator=NO;

    [self.scrollview  autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
}
- (void)setBtnviews{
    
    if (_titles.count>=1&& _images.count>=1) {
        
        if (self.btns.count>=1) {
            [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self.btns removeAllObjects];
        }
        if (self.views.count>=1) {
            [self.views makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self.views removeAllObjects];
        }
        CGFloat height = self.singleH;
        CGFloat width  = self.frame.size.width/self.column;
        CGFloat margin = 0;
        NSInteger page = ceilf((float)self.titles.count/(self.column*self.row)/1.0f);
        CGFloat viewh = page>1 || self.titles.count>self.column ? height*2:height;
        if (page>1) {
            self.viewh = viewh+pageH;

        }else{
            self.viewh = viewh;

        }
        for (NSInteger i = 0; i < page; i++) {
            UIView* view = [[UIView alloc]initWithFrame:(CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, viewh))];
            for (NSInteger j = 0; j< self.row*self.column; j++) {
                if (i*self.row*self.column+j <= self.titles.count-1) {
                    FNHomeFunctionBtn* eleview = [[FNHomeFunctionBtn alloc]initWithFrame:(CGRectMake((1+j%self.column)*margin+j%self.column*width, labs(j/self.column+1)*margin+labs(j/self.column)*height, width, height)) title:@"" andImageURL:nil];
                    @weakify(self);
                    [eleview addJXTouchWithObject:^(FNHomeFunctionBtn* obj) {
                        NSInteger tag = obj.tag - 1000;
                        @strongify(self);
                        if (self.btnClickedBlock) {
                            self.btnClickedBlock(tag);
                        }
                    }];
                    [view addSubview:eleview];
                    [self.btns addObject:eleview];
                }
            }
            [self.scrollview addSubview:view];
            [self.views addObject:view];
        }
        
        [self.btns enumerateObjectsUsingBlock:^(FNHomeFunctionBtn * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            obj.tag = idx+1000;
            
            obj.titleLabel.text = self.titles[idx];
            obj.titleLabel.textColor = [NSString isEmpty:_font_Colors[idx]]?FNBlackColor:[UIColor colorWithHexString:_font_Colors[idx]];
            obj.titleLabel.adjustsFontSizeToFitWidth = YES;
            if(self.images.count==self.btns.count){
                if ([self.images[idx] isKindOfClass:[UIImage class]]) {
                    [obj.imgView setImage:self.images[idx]];
                }else{
                    [obj.imgView setUrlImg:self.images[idx]];
                }
            }
            if(self.imageW>0){
                obj.imgView.sd_layout.centerXEqualToView(obj).topSpaceToView(obj, 2).widthIs(self.imageW).heightIs(self.imageW);
                
            }
            
            if(self.singFont>0){
                obj.titleLabel.font=[UIFont systemFontOfSize:self.singFont];
            }
        }];
        
        
        _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(FNDeviceWidth/2,self.height-20,0,pageH)];
        _pageControl.currentPage=0;
        _pageControl.numberOfPages=page;
        if (_titles.count>self.column * self.row) {
            [_pageControl setCurrentPageIndicatorTintColor:_pageColor == nil ? FNMainGobalTextColor : _pageColor];
            if ([_font_Colors[0] isEqualToString:@"FFFFFF"]) {
                [_pageControl setPageIndicatorTintColor:[UIColor whiteColor]];

            }else{
                [_pageControl setPageIndicatorTintColor:[UIColor grayColor]];

            }
            
            [self addSubview:_pageControl];
            [self.views addObject:_pageControl];
            [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(@0);
                make.height.mas_equalTo(pageH);
            }];
        }
        

        self.scrollview.contentSize = CGSizeMake(self.frame.size.width*page, self.viewh);
    }
}

- (void)setPageColor: (UIColor*)color {
    _pageColor = color;
    [_pageControl setCurrentPageIndicatorTintColor:color];
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollViewW/2)/scrollViewW;
    _pageControl.currentPage = page;
    _pageControl.currentPage=page;
    
}
- (NSMutableArray<FNHomeFunctionBtn *> *)btns{
    if (_btns == nil) {
        _btns = [NSMutableArray new];
    }
    return _btns;
}

@end
