//
//  FNAdvertisMentController.m
//  SuperMode
//
//  Created by Jimmy Ng on 2017/11/29.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNAdvertisMentController.h"
#import "JKCountDownButton.h"
#import "secondViewController.h"
//#import "FNWebNormalController.h"
#define iphone4x_3_5 ([UIScreen mainScreen].bounds.size.height==480.0f)

#define iphone5x_4_0 ([UIScreen mainScreen].bounds.size.height==568.0f)

#define iphone6_4_7 ([UIScreen mainScreen].bounds.size.height==667.0f)

#define iphone6Plus_5_5 ([UIScreen mainScreen].bounds.size.height==736.0f || [UIScreen mainScreen].bounds.size.height==414.0f)
#define DISPATCH_SOURCE_CANCEL_SAFE(time) if(time)\
{\
dispatch_source_cancel(time);\
time = nil;\
}
NSInteger _amd_time = 3;
@interface FNAdvertisMentController ()
@property (nonatomic, strong)UIImageView* imgview;
@property (strong, nonatomic)  UIButton *getBtn;
@property (assign, nonatomic) BOOL isClicked;
@property(nonatomic,copy)dispatch_source_t skipTimer;

@property (nonatomic, assign) BOOL isEnded;
@end

@implementation FNAdvertisMentController
- (UIImageView *)imgview{
    if (_imgview == nil) {
        _imgview = [UIImageView new];
        @weakify(self);
        [_imgview addJXTouch:^{
            @strongify(self);
//            [self goWebWithUrl:[[NSUserDefaults standardUserDefaults] valueForKey:@"adurl"]];
//            secondViewController *web = [secondViewController new];
//            web.url = [[NSUserDefaults standardUserDefaults] valueForKey:@"adurl"];
//            web.isLaunch = YES;
//            [self.navigationController pushViewController:web animated:YES];
            self.isClicked = YES;
          
            NSDictionary *data = [[NSUserDefaults standardUserDefaults] valueForKey:XYLaunchData];
            [self loadOtherVCWithModel:data andInfo:nil outBlock:nil];
        }];
    }
    return _imgview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (void)setImage:(UIImage *)image{
    _image = image;
    if (_image == nil) {
        _image = [self launchImage];
    }
    self.imgview.image = _image;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    if (_isEnded) {
        if (self.removWindow) {
            self.removWindow();
        }
    }
    self.isClicked = NO;
}
- (void)jm_setupViews{
    [self.view addSubview:self.imgview];
    [self.imgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
    self.imgview.contentMode = UIViewContentModeScaleAspectFill;
    self.imgview.clipsToBounds = YES;
    //将头像设成圆形
    _getBtn = [[UIButton alloc]initWithFrame:CGRectMake(FNDeviceWidth-40, 20, 35, 35)];
    _getBtn.layer.cornerRadius = self.getBtn.bounds.size.width/2;;
    _getBtn.layer.masksToBounds = YES;
    [_getBtn setTitleColor:FNWhiteColor forState:UIControlStateNormal];
    [_getBtn setTitle:[NSString stringWithFormat:@"跳过 %ld",_amd_time] forState:(UIControlStateNormal)];
    [_getBtn sizeToFit];
    _getBtn.size = CGSizeMake(_getBtn.width, 30);
    _getBtn.cornerRadius = 3;
    [_getBtn setBackgroundColor:[FNGrayColor colorWithAlphaComponent:0.5]];
    _getBtn.titleLabel.font = kFONT14;
    [_getBtn addTarget:self action:@selector(clickToSkipLaunchImgMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.imgview addSubview:_getBtn];
    [_getBtn autoSetDimensionsToSize:_getBtn.size];
    [_getBtn autoPinEdgeToSuperviewEdge:(ALEdgeTop) withInset:_jmsize_10*2];
    [_getBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:_jmsize_10*2];
    [self startSkipDispathTimer];
//    [self secondAction:_getBtn];
}
-(void)clickToSkipLaunchImgMethod:(UIButton *)sender{
    if (self.removWindow) {
        self.removWindow();
    }

}

////倒计时
//- (void)secondAction:(JKCountDownButton *)sender{
//    //    sender.enabled = NO;
//    //button type要 设置成custom 否则会闪动
//    [sender startWithSecond:_amd_time];
//    [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
//        NSString *title = [NSString stringWithFormat:@"跳过 %d",second];
//        return title;
//    }];
//    [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
//        if (self.removWindow && self.isClicked == NO) {
//            self.removWindow();
//
//        }
//        return @"跳过";
//    }];
//}
/**
 *  获取启动图片
 */
-(UIImage *)launchImage{
    
    NSString *imageName=@"LaunchImage-700";
    
    if(iphone5x_4_0) imageName=@"LaunchImage-700-568h";
    
    if(iphone6_4_7) imageName = @"LaunchImage-800-667h";
    
    if(iphone6Plus_5_5) imageName = @"LaunchImage-800-Portrait-736h";
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    //    NSAssert(image != nil, @"Charlin Feng提示您：请添加启动图片！");
    
    return image;
}

-(void)startSkipDispathTimer{


    __block NSInteger duration = _amd_time;//默认
    

    NSTimeInterval period = 1.0;
    _skipTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(_skipTimer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_skipTimer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *title = [NSString stringWithFormat:@"跳过 %ld",duration];
            [self.getBtn setTitle:title forState:(UIControlStateNormal)];

            if(duration<=0){
                DISPATCH_SOURCE_CANCEL_SAFE(_skipTimer);

                if (self.removWindow && self.isClicked == NO) {
                    self.removWindow();
                }
                self.isEnded = YES;
                return ;
            }
            duration--;
        });
    });
    dispatch_resume(_skipTimer);
    
    


}

@end
