//
//  COFAddInformationController.m
//  THB
//
//  Created by 李显 on 2018/8/28.
//  Copyright © 2018年 方诺科技. All rights reserved.
//
//圈子 发布信息
#import "COFAddInformationController.h"

//选择照片
#import "HXPhotoViewController.h"

//选择照片后布局界面
#import "HXPhotoView.h"

//弹出view
#import "COFSelectivityView.h"

#import "CircleOfFriendsModel.h"

static const CGFloat kPhotoViewMargin = 12.0;

@interface COFAddInformationController ()<UITextViewDelegate,HXPhotoViewDelegate,COFSelectivityViewDelegate>
{
    UITextView *contentView;
}
@property (strong, nonatomic) UIScrollView *AddscrollView;
//商城名字
@property (strong, nonatomic) UILabel *storeNmaeLb;
//输出的内容
@property (strong, nonatomic) UITextView *contentView;
//请输入要发布的内容
@property (strong, nonatomic) UILabel *placeholderLabel;
//contentBGView
@property (strong, nonatomic)UIView *contentBGView;
//photoBg
@property (strong, nonatomic) UIView *photoBg;
//
@property (strong, nonatomic) HXPhotoManager *manager;
//图片view
@property (strong, nonatomic) HXPhotoView *photoView;
//选择的图片
@property (strong, nonatomic) NSArray *PhotoArr;
//商城分类数组
@property (strong, nonatomic) NSMutableArray *StoreArr;
@property (strong, nonatomic) NSMutableArray *StoreTextArr;
//选择的商城类型
//@property (assign, nonatomic) NSInteger  selectType;

@end

@implementation COFAddInformationController
{
    NSInteger  selectType;
}
/**
 HXPhotoManager 照片管理类的属性介绍
 
 是否把相机功能放在外面 默认 NO   使用 HXPhotoView 时有用
 outerCamera;
 
 
 是否打开相机功能
 openCamera;
 
 
 是否开启查看GIF图片功能 - 默认开启
 lookGifPhoto;
 
 
 是否开启查看LivePhoto功能呢 - 默认开启
 lookLivePhoto;
 
 
 是否一开始就进入相机界面
 goCamera;
 
 
 最大选择数 默认10 - 必填
 maxNum;
 
 
 图片最大选择数 默认9 - 必填
 photoMaxNum;
 
 
 视频最大选择数  默认1 - 必填
 videoMaxNum;
 
 
 图片和视频是否能够同时选择 默认支持
 selectTogether;
 
 
 相册列表每行多少个照片 默认4个
 rowCount;
 
 */
-(NSMutableArray *)StoreArr{
    if (!_StoreArr) {
        _StoreArr = [NSMutableArray array];
    }
    return _StoreArr;
}
-(NSMutableArray *)StoreTextArr{
    if (!_StoreTextArr) {
        _StoreTextArr = [NSMutableArray array];
    }
    return _StoreTextArr;
}

- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        _manager.openCamera = YES;
        _manager.cacheAlbum = YES;
        _manager.lookLivePhoto = YES;
        _manager.outerCamera = YES;
        _manager.cameraType = HXPhotoManagerCameraTypeFullScreen;
        _manager.photoMaxNum = 9;
        _manager.videoMaxNum = 0;
        _manager.maxNum = 9;
        _manager.videoMaxDuration = 500.f;
        _manager.saveSystemAblum = NO;
                         
        _manager.style = HXPhotoAlbumStylesSystem;
        //        _manager.reverseDate = YES;
        _manager.showDateHeaderSection = NO;
        _manager.selectTogether = NO;
        _manager.rowCount = 4;
        
        _manager.UIManager.navBar = ^(UINavigationBar *navBar) {
            //            [navBar setBackgroundImage:[UIImage imageNamed:@"APPCityPlayer_bannerGame"] forBarMetrics:UIBarMetricsDefault];
        };
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    selectType=-1;
    self.title=@"发布";
    self.view.backgroundColor=FNColor(246, 246, 246);
    [self apiRequestStoreList];
    [self AddsrcView];
    
    
}

#pragma mark - scrollView
-(void)AddsrcView{
    //ScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    //scrollView.backgroundColor=FNColor(246, 246, 246);
    //scrollView.backgroundColor=[UIColor whiteColor];
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    self.AddscrollView = scrollView;
    
    //距离边缘
    CGFloat distanceMargin=10;
    //titleView高度
    CGFloat titleViewH=50;
    
    //请选择商城view
    UIView *titleview=[UIView new];
    titleview.backgroundColor=[UIColor whiteColor];
    titleview.userInteractionEnabled = YES;
    UITapGestureRecognizer *titletap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titletapClick:)];
    [titleview addGestureRecognizer:titletap];
    [self.AddscrollView addSubview:titleview];
    titleview.sd_layout
    .widthIs(self.AddscrollView.width).heightIs(titleViewH);
    
    //请选择商城title
    UILabel *titleLb=[UILabel new] ;
    titleLb.text=@"请选择商城";
    titleLb.font=[UIFont fontWithDevice:12];
    [titleview addSubview:titleLb];
    titleLb.sd_layout
    .heightIs(titleViewH).leftSpaceToView(titleview, distanceMargin);
    [titleLb setSingleLineAutoResizeWithMaxWidth:120];
    
    //指向图片>
    UIImageView *rightImage=[UIImageView new];
    //rightImage.backgroundColor=FNColor(246, 246, 246);
    rightImage.image=IMAGE(@"issue_right");
    [titleview addSubview:rightImage];
    rightImage.sd_layout
    .rightSpaceToView(titleview, distanceMargin).widthIs(7.5).heightIs(12.5).centerYEqualToView(titleview);
    
    //请选择
    UILabel *storeNmaeLb=[UILabel new] ;
    storeNmaeLb.textColor=FNColor(153, 153, 153);
    storeNmaeLb.text=@"请选择";
    storeNmaeLb.font=[UIFont fontWithDevice:12];
    storeNmaeLb.textAlignment=NSTextAlignmentRight;
    [titleview addSubview:storeNmaeLb];
    storeNmaeLb.sd_layout.rightSpaceToView(rightImage, 5).heightIs(titleViewH);
    [storeNmaeLb setSingleLineAutoResizeWithMaxWidth:150];
    self.storeNmaeLb = storeNmaeLb;
    
    //contentBGView
    UIView *contentBGView=[UIView new];
    contentBGView.backgroundColor=[UIColor whiteColor];
    [self.AddscrollView addSubview:contentBGView];
    self.contentBGView=contentBGView;
    contentBGView.sd_layout
    .widthIs(self.AddscrollView.width).heightIs(205).leftSpaceToView(self.AddscrollView, 0).topSpaceToView(titleview, distanceMargin);
    
    //输入
    contentView=[UITextView new];
    contentView.backgroundColor=[UIColor whiteColor];
    contentView.editable = YES;
    contentView.delegate = self;
    contentView.font = [UIFont fontWithDevice:12];
    //设置是否可以滚动
    contentView.scrollEnabled = YES;
    [contentBGView addSubview:contentView];
    contentView.sd_layout
    .leftSpaceToView(contentBGView, 10).rightSpaceToView(contentBGView, 5).topSpaceToView(contentBGView, 5).heightIs(150);
    self.contentView=contentView;
    //placeholder
    UILabel *placeholderLabel=[UILabel new] ;
    placeholderLabel.textColor=[UIColor lightGrayColor];
    placeholderLabel.text=@"请输入要发布的内容";
    placeholderLabel.font=[UIFont fontWithDevice:12];
    placeholderLabel.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:placeholderLabel];
    placeholderLabel.sd_layout.leftSpaceToView(self.contentView, 5).heightIs(35).topSpaceToView(self.contentView, 0);
    [placeholderLabel setSingleLineAutoResizeWithMaxWidth:150];
    self.placeholderLabel = placeholderLabel;
    //line
    UILabel *lineLabel=[UILabel new] ;
    lineLabel.backgroundColor=FNColor(246, 246, 246);
    [contentBGView addSubview:lineLabel];
    lineLabel.sd_layout.leftSpaceToView(contentBGView, 10).heightIs(1).rightSpaceToView(contentBGView, 10).topSpaceToView(self.contentView, 0);
    
    //添加图片
    UILabel *addLabel=[UILabel new] ;
    addLabel.text=@"添加图片";
    addLabel.font= [UIFont fontWithDevice:12];
    addLabel.textAlignment=NSTextAlignmentLeft;
    [contentBGView addSubview:addLabel];
    addLabel.sd_layout.leftSpaceToView(contentBGView, 10).heightIs(50).topSpaceToView(lineLabel, 0);
    [addLabel setSingleLineAutoResizeWithMaxWidth:80];
    //最多9张
    UILabel *addNumberLabel=[UILabel new] ;
    addNumberLabel.textColor=[UIColor lightGrayColor];
    addNumberLabel.text=@"(最多9张)";
    addNumberLabel.font=[UIFont fontWithDevice:10];
    addNumberLabel.textAlignment=NSTextAlignmentLeft;
    [contentBGView addSubview:addNumberLabel];
    addNumberLabel.sd_layout.leftSpaceToView(addLabel, 0).heightIs(50).topSpaceToView(lineLabel, 0);
    [addNumberLabel setSingleLineAutoResizeWithMaxWidth:80];
    
    
    
    //图片展示BGview
    UIView *photoBg=[UIView new];
    photoBg.backgroundColor=[UIColor whiteColor];
    [self.AddscrollView addSubview:photoBg];
    self.photoBg=photoBg;
    self.photoBg.sd_layout
    .widthIs(self.AddscrollView.width).heightIs(100).topSpaceToView(self.contentBGView, 0).leftSpaceToView(self.AddscrollView, 0);
    //图片展示view
    CGFloat width = self.AddscrollView.frame.size.width;
    HXPhotoView *photoView = [HXPhotoView photoManager:self.manager];
    photoView.frame = CGRectMake(kPhotoViewMargin, CGRectGetMaxY(contentBGView.frame), width - kPhotoViewMargin * 2, 0);
    photoView.delegate = self;
    photoView.lineCount = 4;
    photoView.backgroundColor = [UIColor whiteColor];
    [self.photoBg addSubview:photoView];
    photoView.sd_layout
    .leftSpaceToView(self.photoBg, 10).topSpaceToView(self.photoBg, 0).rightSpaceToView(self.photoBg, 10);
    self.photoView = photoView;
    
    //发布
    UIButton *publish=[UIButton new];
    [publish setTitle:@"发布" forState:UIControlStateNormal];
    publish.backgroundColor=FNColor(249, 67, 124);
    publish.titleLabel.font=[UIFont fontWithDevice:12];
    publish.cornerRadius=5;
    [publish addTarget:self action:@selector(publishCkick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:publish];
    [self.view bringSubviewToFront:publish];// 将子视图在前面
    publish.sd_layout
    .heightIs(50).bottomSpaceToView(self.view, 10).leftSpaceToView(self.view, 10).rightSpaceToView(self.view, 10);
}
#pragma mark - 图片代理方法
- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    NSSLog(@"所有:%ld - 照片:%ld - 视频:%ld",allList.count,photos.count,videos.count);
    NSSLog(@"所有:%@ - 照片:%@ - 视频:%@",allList,photos,videos);
     @WeakObj(self);
    [HXPhotoTools getImageForSelectedPhoto:photos type:HXPhotoToolsFetchOriginalImageTpe completion:^(NSArray<UIImage *> *images) {
        NSLog(@"images:%@",images);
        selfWeak.PhotoArr=images;
    }];
    
    
}
- (void)photoView:(HXPhotoView *)photoView deleteNetworkPhoto:(NSString *)networkPhotoUrl {
    NSSLog(@"networkPhotoUrl:%@",networkPhotoUrl);
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
    NSSLog(@"%@",NSStringFromCGRect(frame));
    self.AddscrollView.contentSize = CGSizeMake(self.AddscrollView.frame.size.width, CGRectGetMaxY(frame) + kPhotoViewMargin+80);
    self.photoBg.sd_layout
    .widthIs(self.AddscrollView.width).heightIs(CGRectGetMaxY(self.photoView.frame)+10).topSpaceToView(self.contentBGView, 0).leftSpaceToView(self.AddscrollView, 0);
}

//当textView的内容发生改变的时候调用
- (void)textViewDidChange:(UITextView *)textView {
    XYLog(@"textView:%@",textView.text);
    //NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //paragraphStyle.lineSpacing = 5;// 字体的行间距
    //NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSParagraphStyleAttributeName:paragraphStyle};
    //textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
    if([textView.text kr_isNotEmpty]){
         _placeholderLabel.hidden = YES;
    }else{
         _placeholderLabel.hidden = NO;
    }
   
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (![text isEqualToString:@""]){
    //_placeholderLabel.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1){
        
        //_placeholderLabel.hidden = NO;
    }
    return YES;
    
}
#pragma mark - title点击事件
-(void)titletapClick:(UITapGestureRecognizer *)sender{
    
    COFSelectivityView *ldySAV = [[COFSelectivityView alloc]initWithTitle:@"选择商城" datas: self.StoreTextArr ifSupportMultiple:NO];
    ldySAV.delegate = self;
    [ldySAV show];
}
#pragma mark - 发布
-(void)publishCkick{
    XYLog(@"发布");
//    XYLog(@"商城名字:%@",self.storeNmaeLb.text);
//    StoreModel *typeModel=self.StoreArr[self.selectType];
//    NSString *type=typeModel.type;
//    XYLog(@"类型:%@",type);
//    XYLog(@"内容:%@",self.contentView.text);
//    XYLog(@"图片:%@",self.PhotoArr);
    [self apiRequestpublish];
    //
  
   
}
#pragma mark - 弹出view
-(void)singleChoiceBlockData:(NSString *)data withRow:(NSInteger)row{
    XYLog(@"xuanze%@",data);
    self.storeNmaeLb.text=data;
    selectType=row;
}
-(void)multipleChoiceBlockDatas:(NSArray *)datas{
   NSString*jointString = [datas componentsJoinedByString:@","];
   XYLog(@"datas%@",datas);
}
#pragma mark - Request
//获取商城分类集合
- (FNRequestTool *)apiRequestStoreList{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=circleOfFriends&ctrl=shopType" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"商城集合:%@",respondsObject);
        NSArray *commitsList =  respondsObject [DataKey];
        NSMutableArray *arrM = [NSMutableArray array];
        NSMutableArray *nameArr = [NSMutableArray array];
        if(commitsList.count>0){
            for (NSDictionary *dictDict in commitsList) {
                [nameArr addObject:dictDict[@"name"]];
                [arrM addObject:[StoreModel mj_objectWithKeyValues:dictDict]];
            }
            selfWeak.StoreTextArr=nameArr;
            selfWeak.StoreArr=arrM;
        }
       
       
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
-(void)apiRequestpublish{
   
    XYLog(@"内容:%@",self.contentView.text);
    XYLog(@"图片:%@",self.PhotoArr);
    if(selectType==-1){
        [FNTipsView showTips:@"请选择商城!"];
    }else if (![self.contentView.text kr_isNotEmpty]){
         [FNTipsView showTips:@"请填写发布内容!"];
    }else if (self.PhotoArr.count==0){
         [FNTipsView showTips:@"请上传相应图片!"];
    }else{
        StoreModel *typeModel=self.StoreArr[selectType];
        NSString *shoptype=typeModel.type;
        XYLog(@"类型:%@",shoptype);
        NSString *token = UserAccessToken;
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":token,@"content":self.contentView.text,@"shop_type":shoptype}];
         [SVProgressHUD show]; 
         [FNRequestTool uploadImageWithParams:params api:@"mod=appapi&act=circleOfFriends&ctrl=issueFriendCircle" imageS:self.PhotoArr success:^(id respondsObject) {
            XYLog(@"dict is %@",respondsObject);
            NSDictionary*dictry=respondsObject;
            NSInteger success=[dictry[@"success"] integerValue];
            XYLog(@"dict is %@",dictry[@"msg"]);
            NSString *mesString=dictry[@"msg"];
            [UIView animateWithDuration:0.2 animations:^{
                [SVProgressHUD dismiss];
            }];
            if(success==1){
                [FNTipsView showTips:@"发布完成"];
                [self.navigationController popViewControllerAnimated:YES];
            }else if(success==0){ 
                [FNTipsView showTips:mesString];
            }
            
        } failure:^(NSString *error) {
            [SVProgressHUD dismiss];
            [XYNetworkAPI cancelAllRequest];
        }];
    }
    // COFSingleDetailsController
    
}

@end
