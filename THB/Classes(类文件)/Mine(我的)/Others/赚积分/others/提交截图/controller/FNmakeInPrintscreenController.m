//
//  FNmakeInPrintscreenController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/14.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmakeInPrintscreenController.h"
#import "FNCustomeNavigationBar.h"
//选择照片
#import "HXPhotoViewController.h"
//选择照片后布局界面
#import "HXPhotoView.h"
#import "FNMakeTmodel.h"
static const CGFloat kPhotoViewMargin = 12.0;
@interface FNmakeInPrintscreenController ()<HXPhotoViewDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIScrollView *AddscrollView;
//photoBg
@property (strong, nonatomic)UIView *photoBg;
//图片 
@property (nonatomic, strong)HXPhotoManager *manager;
//图片view
@property (nonatomic, strong)HXPhotoView *photoView;
//选择的图片
@property (nonatomic, strong)NSArray *PhotoArr;
//编辑View
@property (nonatomic, strong)UIView *compileView;
@property (nonatomic, strong)UITextField *compileField;
@property (nonatomic, strong)UIButton *submitBtn;
@property (nonatomic, strong)FNMakeTaskShotModel *dataModel;
@property (nonatomic, strong)NSString *remarksStr;
@end

@implementation FNmakeInPrintscreenController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTopViews];
    if([self.Cid kr_isNotEmpty]){
       [self requestCustomMsg];
    } 
}
#pragma mark - set top views
- (void)setTopViews{
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.size = CGSizeMake(50, 30);
    self.navigationView.leftButton = self.leftBtn;
    [self.view addSubview:self.navigationView];
    [self.view bringSubviewToFront:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 18);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    self.navigationView.titleLabel.text=self.keyWord?self.keyWord:@"提交截图";
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.leftBtn.imageView.sd_layout
    .centerYEqualToView(self.leftBtn).widthIs(8).heightIs(16).leftSpaceToView(self.leftBtn, 10);
}
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - scrollView
-(void)AddsrcView{
    //ScrollView
    self.AddscrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, FNDeviceHeight-SafeAreaTopHeight)];
    self.AddscrollView.backgroundColor=[UIColor whiteColor];
    self.AddscrollView.alwaysBounceVertical = YES;
    [self.view addSubview:self.AddscrollView];
    self.AddscrollView.contentSize = CGSizeMake(FNDeviceWidth, FNDeviceHeight-SafeAreaTopHeight);
    //图片展示BGview
    self.photoBg=[[UIView alloc]init];
    self.photoBg.backgroundColor=[UIColor whiteColor];
    [self.AddscrollView addSubview:self.photoBg];
    self.photoBg.sd_layout
    .topSpaceToView(self.AddscrollView, 0).leftSpaceToView(self.AddscrollView, 0).widthIs(FNDeviceWidth).heightIs(100);
    //图片展示view
    CGFloat width = FNDeviceWidth;
    
    self.photoView = [HXPhotoView photoManager:self.manager];
    self.photoView.frame = CGRectMake(0, 0, width - kPhotoViewMargin * 2, 0);
    self.photoView.delegate = self;
    self.photoView.lineCount = 3;
    self.photoView.backgroundColor = [UIColor whiteColor];
    [self.photoBg addSubview:self.photoView];
    self.photoView.sd_layout
    .leftSpaceToView(self.photoBg, 10).topSpaceToView(self.photoBg, 5).rightSpaceToView(self.photoBg, 10).bottomSpaceToView(self.photoBg, 5);
    
    self.compileView=[[UIView alloc]init];
    [self.AddscrollView addSubview:self.compileView];
    self.compileView.sd_layout
    .leftSpaceToView(self.AddscrollView, 0).rightSpaceToView(self.AddscrollView, 0).heightIs(160).topSpaceToView(self.AddscrollView, 155);
    //添加图片
    UILabel *addLabel=[[UILabel alloc]init];
    addLabel.text=@"备注:";
    addLabel.font= kFONT13;
    addLabel.textColor=RGB(153,153,153);
    addLabel.textAlignment=NSTextAlignmentLeft;
    [self.compileView addSubview:addLabel];
    addLabel.sd_layout
    .leftSpaceToView(self.compileView, 20).heightIs(25).topSpaceToView(self.compileView, 35).widthIs(35); 
    
    self.compileField=[[UITextField alloc]initWithFrame:CGRectMake(60, 32.5, 240, 20)];
    self.compileField.font = kFONT14;
    [self.compileView addSubview:self.compileField];
    self.compileField.sd_layout
    .leftSpaceToView(self.compileView, 60).centerYEqualToView(addLabel).heightIs(20).rightSpaceToView(self.compileView, 20);
    [self.compileField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIView *lineView=[[UIView alloc]init];
    [self.compileView addSubview:lineView];
    lineView.backgroundColor=RGB(242,242,242);
    lineView.sd_layout
    .leftSpaceToView(self.compileView, 50).topSpaceToView(addLabel, 5).rightSpaceToView(self.compileView, 20).heightIs(1);
    
    //提交
    self.submitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //[self.submitBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    //self.submitBtn.backgroundColor=FNColor(204, 204, 204);
    //self.submitBtn.titleLabel.font=kFONT15;
    self.submitBtn.cornerRadius=5;
    [self.compileView addSubview:self.submitBtn];
    
    self.submitBtn.sd_layout
    .heightIs(50).bottomSpaceToView(self.compileView, 5).leftSpaceToView(self.compileView, 20).rightSpaceToView(self.compileView, 20);
    self.submitBtn.imageView.sd_layout
    .leftEqualToView(self.submitBtn).rightEqualToView(self.submitBtn).topEqualToView(self.submitBtn).bottomEqualToView(self.submitBtn);
    self.submitBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.submitBtn.imageView.clipsToBounds=YES;
    self.submitBtn.cornerRadius=5;
    [self.submitBtn sd_setImageWithURL:URL(self.dataModel.task_sub_btn) forState:UIControlStateNormal];
    
}
-(void)submitBtnCkick{
    if(self.PhotoArr.count==0){
        [FNTipsView showTips:@"请添加截图"];
        return;
    }
    else if(![self.remarksStr kr_isNotEmpty]){
       [FNTipsView showTips:@"请添加备注"];
        return;
    }
    [self requestSubmitShot];
    
}
- (void)textFieldDidChange:(id)sender{
    UITextField *field = (UITextField *)sender;
    self.remarksStr=field.text;
}
#pragma mark - 图片代理方法
- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    //NSSLog(@"所有:%ld - 照片:%ld - 视频:%ld",allList.count,photos.count,videos.count);
    //NSSLog(@"所有:%@ - 照片:%@ - 视频:%@",allList,photos,videos);
    @WeakObj(self);
    [HXPhotoTools getImageForSelectedPhoto:photos type:HXPhotoToolsFetchOriginalImageTpe completion:^(NSArray<UIImage *> *images) {
        NSLog(@"images:%@",images);
        selfWeak.PhotoArr=images;
        if(selfWeak.PhotoArr.count>0){
           [selfWeak.submitBtn sd_setImageWithURL:URL(selfWeak.dataModel.task_select_sub_btn) forState:UIControlStateNormal];
           [self.submitBtn addTarget:self action:@selector(submitBtnCkick) forControlEvents:UIControlEventTouchUpInside];
        }
    }];
}
- (void)photoView:(HXPhotoView *)photoView deleteNetworkPhoto:(NSString *)networkPhotoUrl {
    NSSLog(@"networkPhotoUrl:%@",networkPhotoUrl);
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
    //NSSLog(@"搞=%@",NSStringFromCGRect(frame));
    if(self.PhotoArr.count>0){
        self.AddscrollView.contentSize = CGSizeMake(FNDeviceWidth, CGRectGetMaxY(frame) + 200);
        self.photoBg.sd_layout
        .topSpaceToView(self.AddscrollView, 0).leftSpaceToView(self.AddscrollView, 0).widthIs(FNDeviceWidth).heightIs(CGRectGetMaxY(frame)+10);
        self.compileView.sd_layout
        .leftSpaceToView(self.AddscrollView, 0).rightSpaceToView(self.AddscrollView, 0).heightIs(160).topSpaceToView(self.AddscrollView, CGRectGetMaxY(frame)+10);
    }
    
}
- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.openCamera = NO;
        _manager.cacheAlbum = YES;
        _manager.lookLivePhoto = YES;
        _manager.outerCamera = NO;
        _manager.cameraType = HXPhotoManagerCameraTypeFullScreen;
        //_manager.photoMaxNum = 3;
        _manager.videoMaxNum = 0;
        _manager.maxNum = 3;
        _manager.videoMaxDuration = 500.f;
        _manager.saveSystemAblum = NO;
        _manager.style = HXPhotoAlbumStylesSystem;
        //        _manager.reverseDate = YES;
        _manager.showDateHeaderSection = NO;
        _manager.selectTogether = NO;
        _manager.rowCount = 4;
        _manager.UIManager.photoViewAddImageName=@"FN_JFtJJTimg";
        _manager.UIManager.navBar = ^(UINavigationBar *navBar) {
            //            [navBar setBackgroundImage:[UIImage imageNamed:@"APPCityPlayer_bannerGame"] forBarMetrics:UIBarMetricsDefault];
        };
    }
    return _manager;
}
-(FNRequestTool*)requestCustomMsg{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.Cid kr_isNotEmpty]){
        params[@"id"]=self.Cid;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=task&ctrl=custom_page" respondType:(ResponseTypeModel) modelType:@"FNMakeTaskShotModel" success:^(id respondsObject) {
        @strongify(self);
        self.dataModel=respondsObject;
        self.navigationView.titleLabel.text=self.dataModel.task_tijiao_title;
        if([self.dataModel.pic_count kr_isNotEmpty]){
            NSInteger photoCount=[self.dataModel.pic_count integerValue];
            self.manager.photoMaxNum=photoCount;
        }else{
            self.manager.photoMaxNum=3;
        }
        [self AddsrcView];
        
    } failure:^(NSString *error) {
        
    } isHideTips:NO];
}
-(void)requestSubmitShot{
    [SVProgressHUD show];
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.Cid kr_isNotEmpty]){
        params[@"task_id"]=self.Cid;
    }
    if([self.remarksStr kr_isNotEmpty]){
        params[@"remarks"]=self.remarksStr;
    }
    [[XYNetworkAPI sharedManager]upImageWithParameter:params imageArray:self.PhotoArr imageSize:0.3 url:@"mod=appapi&act=task&ctrl=suctom_sub" successBlock:^(id responseBody) {
        NSDictionary*dictry=responseBody;
        NSInteger success=[dictry[@"success"] integerValue];
        NSString *mesString=dictry[@"msg"];
        [UIView animateWithDuration:0.2 animations:^{
            [SVProgressHUD dismiss];
        }];
        if(success==1){
            [FNTipsView showTips:mesString];
            [self.navigationController popViewControllerAnimated:YES];
        }else if(success==0){
            [FNTipsView showTips:mesString];
        }
    } failureBlock:^(NSString *error) {
        
    }];
//    return [FNRequestTool uploadImageWithParams:params api:@"mod=appapi&act=task&ctrl=suctom_sub" imageS:self.PhotoArr success:^(id respondsObject) {
//        XYLog(@"dict is %@",respondsObject);
//        NSDictionary*dictry=respondsObject;
//        NSInteger success=[dictry[@"success"] integerValue];
//        NSString *mesString=dictry[@"msg"];
//        [UIView animateWithDuration:0.2 animations:^{
//            [SVProgressHUD dismiss];
//        }];
//        if(success==1){
//            [FNTipsView showTips:mesString];
//            [self.navigationController popViewControllerAnimated:YES];
//        }else if(success==0){
//            [FNTipsView showTips:mesString];
//        }
//
//    } failure:^(NSString *error) {
//
//    }];
//
    
    
}
@end
