//
//  FNmerConsumeScanController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/7.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerConsumeScanController.h"
#import "QRCodeReaderView.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "FNmerConsumeSeekController.h"
@interface FNmerConsumeScanController ()<QRCodeReaderViewDelegate>
{
    BOOL isFirst;//第一次进入该页面
    BOOL isPush;//跳转到下一级页面
}
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)QRCodeReaderView * readview;
@end

@implementation FNmerConsumeScanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    if (isFirst || isPush) {
        if (self.readview) {
            [self reStartScan];
        }
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (self.readview) {
        [self.readview stop];
        self.readview.is_Anmotion = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated]; 
    if (isFirst) {
        isFirst = NO;
    }
    if (isPush) {
        isPush = NO;
    }
}
#pragma mark - set up views
- (void)jm_setupViews{
    isFirst = YES;
    isPush = YES;
    [self initAddScanViews];
    
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn setImage:IMAGE(@"FN_merSanFHicon") forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.leftBtn];
    self.leftBtn.sd_layout
    .leftSpaceToView(self.view, 18).topSpaceToView(self.view, 38).widthIs(40).heightIs(40);
}
#pragma mark 初始化扫描
- (void)initAddScanViews
{
    if (self.readview) {
        [self.readview removeFromSuperview];
        self.readview = nil;
    }
    self.readview = [[QRCodeReaderView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight)];
    self.readview.is_AnmotionFinished = YES;
    self.readview.backgroundColor = [UIColor clearColor];
    self.readview.delegate = self;
    self.readview.alpha = 0;
    [self.view addSubview:self.readview];
    //self.readview.readLineView.image=IMAGE(@"");
    //self.readview.scanZomeBack.image=IMAGE(@"");
    self.readview.labIntroudction.hidden=YES;
    self.readview.turnBtn.hidden=YES;
    
    UILabel *hintLB=[[UILabel alloc]init];
    [self.readview addSubview:hintLB];
    hintLB.cornerRadius=30/2;
    hintLB.textColor=[UIColor whiteColor];
    hintLB.backgroundColor=RGBA(77, 78, 79, 1);
    hintLB.text=@"将消费码放入取景框中即可自动扫描";
    hintLB.font=[UIFont systemFontOfSize:14];
    hintLB.textAlignment=NSTextAlignmentCenter;
    CGFloat hintWidh=[hintLB.text kr_getWidthWithTextHeight:30 font:14];
    if(hintWidh>FNDeviceWidth-40){
        hintWidh=FNDeviceWidth-40;
    }
    hintLB.sd_layout
    .centerXEqualToView(self.readview).topSpaceToView(self.readview.scanZomeBack, 20).heightIs(30).widthIs(hintWidh+40);
    
    UIView *lineView=[[UIView alloc]init];
    [self.readview addSubview:lineView];
    lineView.sd_layout
    .centerXEqualToView(self.readview).bottomEqualToView(self.readview).widthIs(1).heightIs(1);
    
    UIButton *redactBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [redactBtn setImage:IMAGE(@"FN_merSanJPIcon") forState:UIControlStateNormal];
    [redactBtn setTitle:@"输入消费码" forState:UIControlStateNormal];
    [redactBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [redactBtn addTarget:self action:@selector(redactBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    redactBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.readview addSubview:redactBtn];
    
    redactBtn.sd_layout
    .rightSpaceToView(lineView, 56).bottomSpaceToView(self.readview, 42).heightIs(90).widthIs(75);
    redactBtn.imageView.sd_layout
    .widthIs(59).heightIs(59).centerXEqualToView(redactBtn).topSpaceToView(redactBtn, 0);
    redactBtn.titleLabel.sd_layout
    .leftSpaceToView(redactBtn, 0).rightSpaceToView(redactBtn, 0).bottomSpaceToView(redactBtn, 0).heightIs(18);
    redactBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    
    UIButton *lampBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [lampBtn setImage:[UIImage imageNamed:@"FN_merSanKGIcon"] forState:UIControlStateNormal];
    [lampBtn setImage:[UIImage imageNamed:@"FN_merSanKQIcon"] forState:UIControlStateSelected];
    [lampBtn setTitle:@"打开手电筒" forState:UIControlStateNormal];
    [lampBtn setTitle:@"关闭手电筒" forState:UIControlStateSelected];
    [lampBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    lampBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [lampBtn addTarget:self action:@selector(lampBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.readview addSubview:lampBtn];
    
    lampBtn.sd_layout
    .leftSpaceToView(lineView, 56).bottomSpaceToView(self.readview, 42).heightIs(90).widthIs(75);
    lampBtn.imageView.sd_layout
    .widthIs(59).heightIs(59).centerXEqualToView(lampBtn).topSpaceToView(lampBtn, 0);
    lampBtn.titleLabel.sd_layout
    .leftSpaceToView(lampBtn, 0).rightSpaceToView(lampBtn, 0).bottomSpaceToView(lampBtn, 0).heightIs(18);
    lampBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [UIView animateWithDuration:0.5 animations:^{
        self.readview.alpha = 1;
    }completion:^(BOOL finished) {
        
    }];
    
}
#pragma mark -QRCodeReaderViewDelegate
- (void)readerScanResult:(NSString *)result
{
    self.readview.is_Anmotion = YES;
    [self.readview stop];
    
    //播放扫描二维码的声音
    SystemSoundID soundID;
    NSString *strSoundFile = [[NSBundle mainBundle] pathForResource:@"noticeMusic" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:strSoundFile],&soundID);
    AudioServicesPlaySystemSound(soundID);
    
    [self accordingQcode:result];
    
    [self performSelector:@selector(reStartScan) withObject:nil afterDelay:1.5];
}
#pragma mark - 扫描结果处理
- (void)accordingQcode:(NSString *)str
{
    //    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //    [alertView show];
    XYLog(@"str is %@",str);
    //    secondViewController *vc = [[secondViewController alloc]init];
    //    vc.url = str;
    //    vc.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:vc animated:YES];
    //    @weakify(self)
    //    [self dismissViewControllerAnimated:YES completion:^{
    //        @strongify(self)
//    [self.navigationController popViewControllerAnimated:NO];
//    if ([self.delegate respondsToSelector:@selector(didCodeScan:)]) {
//        [self.delegate didCodeScan: str];
//    }
    //    }];
    if([str kr_isNotEmpty]){
        FNmerConsumeSeekController *vc=[[FNmerConsumeSeekController alloc]init];
        vc.seekWord=str;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)reStartScan
{
    self.readview.is_Anmotion = NO;
    
    if (self.readview.is_AnmotionFinished) {
        [self.readview loopDrawLine];
    }
    
    [self.readview start];
}

#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//点击输入消费码按钮
-(void)redactBtnAction{
    FNmerConsumeSeekController *vc=[[FNmerConsumeSeekController alloc]init];
    vc.seekWord=@"";
    [self.navigationController pushViewController:vc animated:YES];
}
//点击打开手电筒按钮
-(void)lampBtnAction:(UIButton*)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self turnTorchOn:YES];
    }
    else{
        [self turnTorchOn:NO];
    }
}
- (void)turnTorchOn:(bool)on
{
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }
    }
}
@end
