//
//  COFPublishListController.m
//  THB
//
//  Created by 李显 on 2018/8/28.
//  Copyright © 2018年 方诺科技. All rights reserved.
//
//个人 TA的发布 TA的参与
#import "COFPublishListController.h"
#import "FNNewProDetailController.h"
#import "COFAddInformationController.h"
#import "COFsingleDetailsController.h"   //详情
#import "FNMembershipUpgradeViewController.h"

#import "CircleOfFriendsCell.h"
#import "CireleImageBtn.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "FDSlideBar.h"
#import "FNCustomeNavigationBar.h"
#import "COFshareView.h"

#import "CircleOfFriendsModel.h"
#import "CircleOfFriendsFrame.h"
#import "CoShareItem.h"

@interface COFPublishListController ()<UITableViewDelegate,UITableViewDataSource,CircleOfFriendsCellDelegate,COFshareViewDelegate,UIWebViewDelegate>

//**  导航 **//
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;

//**  分栏视图 **//
@property (nonatomic, strong)UIView* classifyView;

//** 分栏内容 **//
@property (nonatomic, strong)FDSlideBar *slideBar;

//** TableView **//
@property (nonatomic, strong)UITableView* PublishView;

//** 数据源 **//
@property(nonatomic ,strong) NSMutableArray* dataArray;

//** 分类model数组 **//
@property(nonatomic ,strong) NSMutableArray* sortArray;

//** 选择的分类 **//
@property(nonatomic ,strong) NSString* selectionSort;

//** 选中的信息条(单条产品) ID **//
@property(nonatomic ,strong) NSString* productID;

@property (nonatomic, strong)UIImageView* toTopImage;

//** 分享的数组 **//
@property(nonatomic ,strong) NSMutableArray *shareimageViewArr;

//** H5地址 **//
@property(nonatomic ,strong) NSString* js_urlString;

@property(nonatomic ,strong) UIWebView* webInteractionView;
@end

@implementation COFPublishListController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=FNColor(246, 246, 246);
     
    [FNRequestTool startWithRequests:@[[self apiRequestPublishSort]] withFinishedBlock:^(NSArray *erros) {
    }];
    [self PublishNavigationView];
    [self subfieldView];
    [self PublishTableView];
}
#pragma mark - 导航
- (void)PublishNavigationView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:self.publisherName];
    _navigationView.backgroundColor=FNWhiteColor;
    UIButton* AddBtn = [UIButton buttonWithTitle:@"" titleColor:FNWhiteColor font:kFONT12 target:self action:@selector(PublishAddBtnAction)];
    [AddBtn setImage:IMAGE(@"circle_add") forState:(UIControlStateNormal)];
    [AddBtn setTitle:@" " forState:(UIControlStateSelected)];
    [AddBtn sizeToFit];
    AddBtn.size = CGSizeMake(20, 20);
    AddBtn.borderColor = FNWhiteColor;
    _navigationView.rightButton = AddBtn;
   
    UIButton* leftBtn = [UIButton buttonWithTitle:@"" titleColor:FNWhiteColor font:kFONT12 target:self action:@selector(PublishbackbtnAction)];
    [leftBtn setImage:IMAGE(@"return") forState:(UIControlStateNormal)];
    [leftBtn setTitle:@" " forState:(UIControlStateSelected)];
    [leftBtn sizeToFit];
    leftBtn.size = CGSizeMake(20, 20);
     leftBtn.borderColor = FNWhiteColor;
    _navigationView.leftButton = leftBtn;
    
    _navigationView.titleLabel.textColor=[UIColor blackColor];
    [self.view addSubview:self.navigationView];
}
#pragma mark - 分类
-(void)subfieldView{
    @WeakObj(self);
    //NSArray* classify=@[@"TA的发布的",@"TA的参与"];
    //分栏模块
    _classifyView=[[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, 40)];
    _classifyView.backgroundColor=FNWhiteColor;
    [self.view addSubview:_classifyView];
    
    _slideBar = [[FDSlideBar alloc] initWithFrame:CGRectMake(0, 0, FNDeviceWidth, 40)];
    _slideBar.backgroundColor = FNWhiteColor;
    _slideBar.is_middle=YES; 
    [_classifyView addSubview:_slideBar];
  
    [_slideBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.left.right.bottom.equalTo(@0);
    }];
    
    [_slideBar slideBarItemSelectedCallback:^(NSUInteger index) {
        XYLog(@"类型:%lu",(unsigned long)index);
        CircleTypeModel *type=selfWeak.sortArray[index];
        NSString *name=type.name;
        XYLog(@"name:%@",name);
        selfWeak.jm_page = 1;
        selfWeak.selectionSort=type.SkipUIIdentifier;
        [self apiRequestPublisher];
    }];
    
    
    [_slideBar selectSlideBarItemAtIndex:0];
    
}
#pragma mark - 单元
-(void)PublishTableView{
    //self.automaticallyAdjustsScrollViewInsets = NO;
    self.jm_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+50, FNDeviceWidth, FNDeviceHeight-SafeAreaTopHeight-50) style:UITableViewStylePlain];
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    //[self.jm_tableview removeEmptyCellRows];
    [self.view addSubview:self.jm_tableview];
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.estimatedRowHeight = 0;
        self.jm_tableview.estimatedSectionFooterHeight = 0;
        self.jm_tableview.estimatedSectionHeaderHeight= 0; self.jm_tableview.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }
    @WeakObj(self);
    self.jm_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.jm_page = 1;
        [selfWeak apiRequestPublisher];
    }];
    
    self.jm_tableview.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        selfWeak.jm_page += 1;
        [self apiRequestPublisher];
    }];
    
   
    
   
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CircleOfFriendsCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Publishcell"];
    if (cell == nil) {
        cell = [[CircleOfFriendsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Publishcell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.ProductIndexpath=indexPath;
    CircleOfFriendsFrame *cFrame = self.dataArray[indexPath.row];
    cell.circleFrame = cFrame;
    [cell setChildBtnTag:indexPath.row];
    cell.delegate = self;
    return cell;
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //return 100;
    CircleOfFriendsFrame *cFrame = self.dataArray[indexPath.row];
    NSLog(@"dataArray:%@",self.dataArray[indexPath.row]);
    NSLog(@"dataArray:%@",cFrame);
    return cFrame.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    CircleOfFriendsFrame *cFrame = self.dataArray[indexPath.row];
//    CircleOfFriendsProductModel *commit = cFrame.productModel;
//    COFsingleDetailsController *detailsVC=[[COFsingleDetailsController alloc]init];
//    detailsVC.DetailsID=commit.id;
//    [self.navigationController pushViewController:detailsVC animated:YES];
}
#pragma mark - CircleOfFriendsCellDelegate
// 喜欢
- (void)likeBtnClickAction:(CireleImageBtn *)sender{
    if ([NSString isEmpty:UserAccessToken]) {
        [self warnToLogin];
        return;
    }
    XYLog(@"喜欢");
//    CircleOfFriendsFrame *cFrame = self.dataArray[sender.tag];
//    CircleOfFriendsProductModel *commit = cFrame.productModel;
//    self.productID=commit.id;
//    if([commit.is_thumb integerValue]==0){
//        [self apiRequestLike];
//    }else{
//        [self apiRequestDislike];
//    }
}
// 评轮
- (void)disLikeBtnClickAction:(CireleImageBtn *)sender{
    if ([NSString isEmpty:UserAccessToken]) {
        [self warnToLogin];
        return;
    }
    XYLog(@"评轮");
    
}
// 分享
-(void)shareBtnClickAction:(UIButton *)sender{
    if ([NSString isEmpty:UserAccessToken]) {
        [self warnToLogin];
        return;
    }
    if ([FNBaseSettingModel settingInstance].all_fx_onoff.boolValue) {
        CircleOfFriendsFrame *cFrame = self.dataArray[sender.tag];
        CircleOfFriendsProductModel *commit = cFrame.productModel;
        self.productID=commit.ID;
        //    NSString *contentString=commit.content;
        //    [[UIPasteboard generalPasteboard] setString:contentString?:@""];
        //    NSArray *imageArr=commit.img;
        //    _shareimageViewArr=imageArr;
        //    COFshareView *alertView = [COFshareView popoverView];
        //    alertView.delegate=self;
        //    alertView.backgroundColor=[UIColor clearColor];
        //    alertView.showShade = YES; // 显示阴影背景
        //    [alertView showWithActions];
        
        //[self apiRequestShareInformation];
        //[self apiRequestInteraction];
        /*NSInteger is_need_js=[commit.is_need_js integerValue];
        self.js_urlString=commit.jsurl;
        if(is_need_js==0){
            [self apiRequestShareInformation];
        }
        if(is_need_js==1){
            [self apiRequestHFURL];
        }*/
        [self apiRequestShareInformation];
    }else{
        [self loadMembershipUpgradeViewController];
    }
   
}
// 详情
-(void)detailsClickAction:(UIButton *)sender{
    if ([NSString isEmpty:UserAccessToken]) {
        [self warnToLogin];
        return;
    }
    XYLog(@"详情");
    CircleOfFriendsFrame *cFrame = self.dataArray[sender.tag];
    CircleOfFriendsProductModel *commit = cFrame.productModel;
    if([commit.url kr_isNotEmpty]){
        XYLog(@"广告");
    }else{
        
        //[self goProductVCWithModel:commit.imgData[sender]];
        FNNewProDetailController* detail = [FNNewProDetailController new];
        detail.fnuo_id = commit.fnuo_id;
        detail.getGoodsType = commit.goods_type;
        detail.goods_title = @"";
        detail.SkipUIIdentifier = commit.goods_type;
        [self.navigationController pushViewController:detail animated:YES];
    }
}
//选择图片
-(void)selectProductAction:(NSInteger)sender row:(NSInteger)row{
    XYLog(@"图:%ldrow:%ld",(long)sender,(long)row);
    CircleOfFriendsFrame *cFrame = self.dataArray[row];
    CircleOfFriendsProductModel *commit = cFrame.productModel;
    CircleOfFriendsImageModel *ImageModel=[CircleOfFriendsImageModel mj_objectWithKeyValues:commit.imgData[sender]];
    //跳转商品
    if([ImageModel.fnuo_id kr_isNotEmpty]){
        if ([NSString isEmpty:UserAccessToken]) {
            [self warnToLogin];
            return;
        }
        //[self goProductVCWithModel:commit.imgData[sender]];
        FNNewProDetailController* detail = [FNNewProDetailController new];
        detail.fnuo_id = ImageModel.fnuo_id;
        detail.getGoodsType = ImageModel.goods_type;
        detail.goods_title = @"";
        detail.SkipUIIdentifier = ImageModel.goods_type;
        [self.navigationController pushViewController:detail animated:YES];
    }else{
        //NSArray *imageArr=commit.img;
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc]init];
        // 弹出相册时显示的第一张图片是点击的图片
        browser.currentPhotoIndex = sender;
        NSMutableArray *photos = [NSMutableArray array];
        NSArray *imgs = commit.img;
        [imgs enumerateObjectsUsingBlock:^(id  _Nonnull sobj, NSUInteger idx, BOOL * _Nonnull stop) {
            MJPhoto *mjPhoto = [[MJPhoto alloc] init];
            
            mjPhoto.url = [NSURL URLWithString:sobj];
            
            //mjPhoto.srcImageView = imgview;
            
            [photos addObject:mjPhoto];
        }];
        
        // 设置所有的图片。photos是一个包含所有图片的数组。
        browser.photos = photos;
        [browser show];
    }
    
}
//选择头像
-(void)selectIconImageViewAction:(NSInteger)sender{
    XYLog(@"选择头像:%ld",(long)sender);
//    CircleOfFriendsFrame *cFrame = self.dataArray[sender];
//    CircleOfFriendsProductModel *commit = cFrame.productModel;
//    COFPublishListController *publishVc=[[COFPublishListController alloc]init];
//    publishVc.publisherID=commit.uid;
//    publishVc.publisherName=commit.nickname;
//    [self.navigationController pushViewController:publishVc animated:YES];
}
#pragma mark -   COFshare分享
-(void)COFshareBtnClick:(NSInteger )sender{
    NSLog(@"分享%ld",(long)sender);
    
    UIActivityViewController* vc = [[UIActivityViewController alloc]initWithActivityItems:_shareimageViewArr applicationActivities:nil];
    [self presentViewController:vc animated:YES completion:nil];
      
   
    
}
#pragma mark - Request
//获取搜排序文字
- (FNRequestTool *)apiRequestPublishSort{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=circleOfFriends&ctrl=TaCate" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"单个首页:%@",respondsObject);
        NSMutableArray *name=[[NSMutableArray alloc]init];
        NSMutableArray *type=[[NSMutableArray alloc]init];
        NSArray* array = respondsObject[DataKey];
        if (array.count>0) {
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [name addObject:[obj objectForKey:@"name"]];
                [type addObject:[obj objectForKey:@"SkipUIIdentifier"]];
                
            }];
        }
        XYLog(@"type:%@",type);
        NSMutableArray *typeArr=[[NSMutableArray alloc]init];
        for (NSDictionary *dictry in array) {
            [typeArr addObject:[CircleTypeModel mj_objectWithKeyValues:dictry]];
        }
        selfWeak.sortArray=typeArr;
        selfWeak.slideBar.itemsTitle =  name;//classify
        selfWeak.slideBar.itemColor = FNGlobalTextGrayColor;
        selfWeak.slideBar.itemSelectedColor = FNMainGobalTextColor;// //FNColor(246, 71, 111)
        selfWeak.slideBar.sliderColor = FNMainGobalTextColor;
        selfWeak.slideBar.fontSize=13;
        selfWeak.slideBar.SelectedfontSize=14;
        selfWeak.selectionSort=type[0];
        [self apiRequestPublisher];
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
//TA的页面信息
- (FNRequestTool *)apiRequestPublisher{
    [self.jm_tableview.mj_header endRefreshing];
    [self.jm_tableview.mj_footer endRefreshing];
    @WeakObj(self);
    [SVProgressHUD show]; 
    NSString *token = UserAccessToken;
    XYLog(@"selectionSort:%@",selfWeak.selectionSort);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"p":@(self.jm_page),@"SkipUIIdentifier":selfWeak.selectionSort,@"token":token,@"uid":self.publisherID}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=circleOfFriends&ctrl=friend_issue" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"TA的:%@",respondsObject);
        NSArray *commitsList =  respondsObject [DataKey];
        NSMutableArray *arrM = [NSMutableArray array];
        
        for (NSDictionary *dictDict in commitsList) {
            CircleOfFriendsFrame *cFrame = [[CircleOfFriendsFrame alloc]init];
            //cFrame.CircleOfFriends = [CircleOfFriendsModel commitWithDict:dictDict];
            cFrame.productModel=[CircleOfFriendsProductModel mj_objectWithKeyValues:dictDict];
            
            [arrM addObject:cFrame];
        }
        if (arrM.count == 0) { 
            [selfWeak.jm_tableview.mj_footer endRefreshingWithNoMoreData];
        }
        if (self.jm_page == 1) {
            if (arrM.count == 0) {
                [selfWeak.dataArray removeAllObjects];
                [selfWeak.jm_tableview reloadData];
                [FNTipsView showTips:@"很抱歉，没有找到该类产品~"];
               // return ;
            }
            [selfWeak.dataArray removeAllObjects];
            selfWeak.dataArray = arrM;
            
        } else {
           
            [selfWeak.dataArray addObjectsFromArray:arrM];
        }
        
        [UIView animateWithDuration:0.2 animations:^{
            [SVProgressHUD dismiss];
        }];
        [selfWeak.jm_tableview reloadData];
        
        
    } failure:^(NSString *error) {
        //
    } isHideTips:YES];
}
//点赞
- (FNRequestTool *)apiRequestLike{
    @WeakObj(self);
    XYLog(@"FuBarID:%@",selfWeak.productID);
    NSString *token = UserAccessToken;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":token,@"id":selfWeak.productID}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=circleOfFriends&ctrl=add_thumbs" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"点赞结果:%@",respondsObject);
        [self apiRequestPublisher];
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
//不喜欢 不赞
- (FNRequestTool *)apiRequestDislike{
    @WeakObj(self);
    XYLog(@"FuBarID:%@",selfWeak.productID);
    NSString *token = UserAccessToken;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"id":selfWeak.productID,@"token":token}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=circleOfFriends&ctrl=cancel_thumbs" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"不喜欢结果:%@",respondsObject);
        [self apiRequestPublisher];
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
//获取交互
- (FNRequestTool *)apiRequestInteraction{
    @WeakObj(self);
    [SVProgressHUD show];
    NSString *token = UserAccessToken;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":token,@"p":@(self.jm_page)}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=circleOfFriends&ctrl=jsCircle" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"朋友圈交互:%@",respondsObject);
        NSDictionary* dictry = respondsObject[DataKey];
        NSInteger is_need_js=[dictry[@"is_need_js"] integerValue];
        selfWeak.js_urlString=dictry[@"url"];
        if(is_need_js==0){
            [self apiRequestShareInformation];
        }else if (is_need_js==1){
            [self apiRequestHFURL];
        }
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
//获取交互
- (void)apiRequestHFURL{
    self.webInteractionView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.webInteractionView.delegate=self;
    [self.view addSubview:self.webInteractionView];
    NSURL *telURL =[NSURL URLWithString:_js_urlString];
    [self.webInteractionView loadRequest:[NSURLRequest requestWithURL:telURL]];
    
}
-(void)webViewDidFinishLoad:(UIWebView*)webView{
    [self apiRequestShareInformation];
}

//分享信息
- (FNRequestTool *)apiRequestShareInformation{
    [self.webInteractionView removeFromSuperview];
    @WeakObj(self);
    XYLog(@"FnID:%@",selfWeak.productID);
    [SVProgressHUD show];
    NSString *token = UserAccessToken;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"token":token,@"id":selfWeak.productID}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=circleOfFriends&ctrl=shareFriendCircle" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"分享信息:%@",respondsObject);
        NSArray *commitsList =  respondsObject [DataKey];
        NSMutableArray *arrM = [NSMutableArray array];
        NSDictionary *dictDict= commitsList[0];
        NSString *contentString=dictDict[@"content"];
        [[UIPasteboard generalPasteboard] setString:contentString];
        NSArray *imgArr=dictDict[@"img"];
        for (NSString *imageString in imgArr) {
            [arrM addObject:imageString];
        }
        selfWeak.shareimageViewArr=[self backPicture:arrM];//items
        if(selfWeak.shareimageViewArr.count>0){
            [SVProgressHUD dismiss];
            COFshareView *alertView = [COFshareView popoverView];
            alertView.delegate=self;
            alertView.backgroundColor=[UIColor clearColor];
            alertView.showShade = YES; // 显示阴影背景
            [alertView showWithActions];
        }
        //selfWeak.shareimageViewArr=arrM;
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
#pragma mark - //添加
-(void)PublishAddBtnAction{
    if ([NSString isEmpty:UserAccessToken]) {
        [self warnToLogin];
        return;
    }
    COFAddInformationController *addVC=[[COFAddInformationController alloc]init];
    [self.navigationController pushViewController:addVC animated:YES];
    
}

-(void)PublishbackbtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray *)shareimageViewArr{
    if (!_shareimageViewArr) {
        _shareimageViewArr = [NSMutableArray array];
    }
    return _shareimageViewArr;
}
//将网络图片地址缓存到本地
-(NSMutableArray*)backPicture:(NSArray*)imageArr{
    
    NSMutableArray *items = [NSMutableArray array];
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    for (int i = 0; i < imageArr.count; i++) {
        UIImage *imagerang = [UIImage imageWithData:[NSData dataWithContentsOfURL:URL(imageArr[i])]];
        //图片缓存的地址，自己进行替换
        NSString *imagePath = [docPath stringByAppendingString:[NSString stringWithFormat:@"ShareWX%d%@.jpg",i,[NSString GetNowTimes]]];
        //把图片写进缓存，一定要先写入本地，不然会分享出错
        [UIImageJPEGRepresentation(imagerang, 0.5) writeToFile:imagePath atomically:YES];
        //把缓存图片的地址转成NSUrl格式
        NSURL *shareobj = [NSURL fileURLWithPath:imagePath];
        //这个部分是自定义ActivitySource
        CoShareItem *item = [[CoShareItem alloc] initWithData: imagerang andFile:shareobj];
        //分享的数组
        [items addObject:item];
    }
    return items;
}

@end
