//
//  COFshareView.m
//  THB
//
//  Created by Jimmy on 2018/8/30.
//  Copyright © 2018年 方诺科技. All rights reserved.
//
//分享view
#import "COFshareView.h" 
#import "COFshareBtn.h"
static NSInteger const kColumnCount = 4;

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEI [UIScreen mainScreen].bounds.size.height
@interface COFshareView ()

#pragma mark - UI
@property (nonatomic, weak) UIWindow *keyWindow; ///< 当前窗口

@property (nonatomic, strong) UIView *bootView;
@property (nonatomic, strong) UIView *shadeView; ///< 遮罩层
@property (nonatomic, weak) UITapGestureRecognizer *tapGesture; ///< 点击背景阴影的 
@property (nonatomic, assign) CGFloat windowWidth; ///< 窗口宽度
@property (nonatomic, assign) CGFloat windowHeight; ///< 窗口高度

@end

@implementation COFshareView

#pragma mark - Lift Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame])) return nil;
    [self initialize];
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialize];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _bootView.frame=CGRectMake(0, self.bounds.size.height-110, CGRectGetWidth(self.bounds), 110);
    [self setupItem];
}

#pragma mark - Setter
- (void)setHideAfterTouchOutside:(BOOL)hideAfterTouchOutside {
    _hideAfterTouchOutside = hideAfterTouchOutside;
    _tapGesture.enabled = _hideAfterTouchOutside;
}

- (void)setShowShade:(BOOL)showShade {
    _showShade = showShade;
    _shadeView.backgroundColor =  _showShade ? [UIColor colorWithRed:68/255 green:68/255 blue:68/255 alpha:0.6] : [UIColor clearColor];
}



#pragma mark - Private
/*  初始化相关 */
- (void)initialize {
   
    self.backgroundColor = [UIColor colorWithRed:0.29 green:0.29 blue:0.29 alpha:1.00];
    // current view
    // keyWindow
    _keyWindow = [UIApplication sharedApplication].keyWindow;
    _windowWidth = CGRectGetWidth(_keyWindow.bounds);
    _windowHeight = CGRectGetHeight(_keyWindow.bounds);
    // shadeView
    _shadeView = [[UIView alloc] initWithFrame:_keyWindow.bounds];
    [self setShowShade:NO];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [_shadeView addGestureRecognizer:tapGesture];
    _tapGesture = tapGesture;
  
    _bootView=[[UIView alloc]init];
    _bootView.backgroundColor=[UIColor whiteColor];
    _bootView.sd_layout
    .widthIs(self.bounds.size.width).heightIs(self.bounds.size.height).leftEqualToView(self).topEqualToView(self);
    [self addSubview:_bootView];
}
#pragma mark - Public
+ (instancetype)popoverView {
    return [[self alloc] init];
}
/*  指向指定的View来显示弹窗 */
- (void)showWithActions{
    
    // 遮罩层
    _shadeView.alpha = 0.f;
    [_keyWindow addSubview:_shadeView];
   
    CGFloat currentH = 110;
    // 限制最高高度, 免得选项太多时超出屏幕
    if (currentH > _windowHeight) { // 如果弹窗高度大于最大高度的话则限制弹窗高度等于最大高度并允许tableView滑动.
        currentH = _windowHeight;
       
    }
    self.frame = CGRectMake(0, _windowHeight, _windowWidth, currentH);
    [_keyWindow addSubview:self];
    //弹出动画
    [UIView animateWithDuration:0.25f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = CGRectMake(0, _windowHeight - currentH, _windowWidth, currentH);
        _shadeView.alpha = 1.f;
    } completion:^(BOOL finished) {

    }];
}
/* 点击外部隐藏弹窗 */
- (void)hide {
    [UIView animateWithDuration:0.25f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0.f;
        _shadeView.alpha = 0.f;
        _bootView.alpha = 0.f;
        self.frame = CGRectMake(0, SCREEN_HEI, _windowWidth, 200);
    } completion:^(BOOL finished) {
        [_shadeView removeFromSuperview];
        [self removeFromSuperview];
    }];
}



- (void)setupItem{
   
    NSArray *imageArr=@[@"gs_sina",@"gs_cof",@"gs_wechat",@"gs_qq"];
    NSArray *nameArr=@[@"微博",@"朋友圈",@"微信好友",@"QQ"];
    CGFloat itemWidth = self.frame.size.width / kColumnCount;
    CGFloat itemHeight = 100;//(265 - 2 * vMargin - vSpacing) * 0.5;
    NSInteger row = 0;
    NSInteger loc = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    for (NSInteger i = 0; i < 4; i ++) {
        row = i / kColumnCount ; // % 2  为了翻页
        loc = i % kColumnCount ;
        x = itemWidth * loc ;
      
        COFshareBtn *button = [[COFshareBtn alloc] initWithFrame:CGRectMake(x, y, itemWidth, itemHeight)];
        button.backgroundColor=[UIColor whiteColor];
       
        button.tag = 1000 + i;
        [button setTitle:nameArr[i] forState:UIControlStateNormal];
        [button setTitleColor:FNColor(146, 146, 146) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        //[button.imageView setContentMode:UIViewContentModeCenter];
        //button.imageView .contentMode = UIViewContentModeScaleAspectFill;
        [button addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bootView addSubview:button];
        
       
    }
    
}
-(void)selectClick:(UIButton*)btn{
    if ([self.delegate respondsToSelector:@selector(COFshareBtnClick:)]) {
        [self.delegate COFshareBtnClick:btn.tag-1000];
        [self hide];
    }
}
@end
