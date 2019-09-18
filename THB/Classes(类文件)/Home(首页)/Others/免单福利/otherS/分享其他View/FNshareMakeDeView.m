//
//  FNshareMakeDeView.m
//  THB
//
//  Created by Jimmy on 2018/12/19.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNshareMakeDeView.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEI [UIScreen mainScreen].bounds.size.height
@interface FNshareMakeDeView ()
@property (nonatomic, weak) UIWindow *keyWindow; ///< 当前窗口

@property (nonatomic, strong) UIView *bootView;
@property (nonatomic, strong) UIView *shadeView; ///< 遮罩层
@property (nonatomic, weak) UITapGestureRecognizer *tapGesture; ///< 点击背景阴影的
@property (nonatomic, assign) CGFloat windowWidth; ///< 窗口宽度
@property (nonatomic, assign) CGFloat windowHeight; ///< 窗口高度

@end
@implementation FNshareMakeDeView

#pragma mark - Lift Cycle
- (instancetype)initWithFrame:(CGRect)frame{
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
    CGFloat currentH =185;//self.currentH;// 185;
    _bootView.frame=CGRectMake(0, self.bounds.size.height-currentH, CGRectGetWidth(self.bounds), currentH);
    [self setupItem];
    
}
#pragma mark - Private
/*  初始化相关 */
- (void)initialize {
    
    self.backgroundColor = [UIColor colorWithRed:0.29 green:0.29 blue:0.29 alpha:1.00];
   
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
    _bootView.cornerRadius=5;
    _bootView.sd_layout
    .widthIs(self.bounds.size.width).heightIs(self.bounds.size.height).leftEqualToView(self).topEqualToView(self);
    [self addSubview:_bootView];
}
- (void)setShowShade:(BOOL)showShade {
    _showShade = showShade;
    _shadeView.backgroundColor =  _showShade ? [UIColor colorWithRed:68/255 green:68/255 blue:68/255 alpha:0.6] : [UIColor clearColor];
}

- (void)setupItem{
    
   
    NSArray *imageArr=@[@"MA_wximg",@"MA_PYimg",@"MA_QQimg",@"MA_WBimg",@"MA_KJimg"];
    NSArray *nameArr=@[@"微信",@"微信朋友圈",@"QQ",@"微博",@"QQ空间"];
    CGFloat itemWidth = 80;// self.itemWidth;
    CGFloat itemHeight = itemWidth +25;//(265 - 2 * vMargin - vSpacing) * 0.5;
    NSInteger row = 0;
    NSInteger loc = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat interval=(SCREEN_WIDTH-(itemWidth*imageArr.count)) / (imageArr.count+1);
    NSInteger kColumnCount=imageArr.count;
    if(imageArr.count>0){
        for (NSInteger i = 0; i < imageArr.count; i ++) {
            row = i / kColumnCount ; // % 2  为了翻页
            loc = i % kColumnCount ;
            x = interval+(itemWidth+interval) * loc;
            y = 20;//itemHeight*row;
            COFshareBtn *button = [[COFshareBtn alloc] initWithFrame:CGRectMake(x, y, itemWidth, itemHeight)];
            button.backgroundColor=[UIColor whiteColor];
            button.tag = 1000 + i;
            [button setTitle:nameArr[i] forState:UIControlStateNormal];
            [button setTitleColor:FNColor(146, 146, 146) forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            [button setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.bootView addSubview:button];
        }
    }
    UIButton *basebtn=[UIButton buttonWithType:UIButtonTypeCustom];
    basebtn.backgroundColor=RGB(232, 232, 232);
    [basebtn setTitle:@"取消" forState:UIControlStateNormal];
    [basebtn setTitleColor:FNColor(146, 146, 146) forState:UIControlStateNormal];
    basebtn.frame=CGRectMake(0, 0, 30, 45);
    basebtn.titleLabel.font=kFONT14;
    [basebtn addTarget:self action:@selector(basebtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bootView addSubview:basebtn];
    basebtn.sd_layout
    .widthIs(self.bounds.size.width).heightIs(45).leftEqualToView(self.bootView).bottomEqualToView(self.bootView);
}
-(void)basebtnAction{
    [self hide];
}
-(void)selectClick:(UIButton*)btn{
    if ([self.delegate respondsToSelector:@selector(shareBtnClick:)]) {
        [self.delegate shareBtnClick:btn.tag-1000]; 
    }
     [self hide];
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
    
    CGFloat currentH = 185;// 185;self.currentH
    if (currentH > _windowHeight) {
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


@end
