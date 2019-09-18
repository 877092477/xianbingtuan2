//
//  FNmerDiscussReplyController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/30.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerDiscussReplyController.h"
#import "FNCustomeNavigationBar.h"
#import "FNmerchentReviewModel.h"
#import "FNmerDiscussDetailsUserCell.h"
#import "FNmerDiscussDeTallyCell.h"
#import "FNmerDiscussEvaluateTextCell.h"
#import "FNmerDiscussImgItemCell.h"
#import "FNmerDiscussHandleCell.h"
#import "FNmerDiscussRespondItCell.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "FNmerDiscussQueryView.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
@interface FNmerDiscussReplyController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FNmerDiscussQueryViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UITextField *compileField;
@property (nonatomic, strong)FNmerchentReviewModel *dataModel;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)FNmerDiscussQueryView *customView;
@property (nonatomic, strong)FNmerReviewQueryModel *queryModel;
@property (nonatomic, strong)UIView *baseView;
@end

@implementation FNmerDiscussReplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
     [IQKeyboardManager sharedManager].enable = YES;
}
#pragma mark - set up views
- (void)jm_setupViews{
    
    CGFloat topGap=SafeAreaTopHeight+1;
    CGFloat baseGap=0;
    if(isIphoneX){
        baseGap=32;
    } 
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, topGap, FNDeviceWidth, FNDeviceHeight-topGap-46-baseGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    self.jm_collectionview.emptyDataSetSource = nil;
    //self.jm_collectionview.alpha = 1;
    //self.jm_collectionview.backgroundColor = [UIColor clearColor];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.jm_collectionview];
    
    [self.jm_collectionview registerClass:[FNmerDiscussDetailsUserCell class] forCellWithReuseIdentifier:@"FNmerDiscussDetailsUserCellID"];
    [self.jm_collectionview registerClass:[FNmerDiscussDeTallyCell class] forCellWithReuseIdentifier:@"FNmerDiscussDeTallyCellID"];
    [self.jm_collectionview registerClass:[FNmerDiscussEvaluateTextCell class] forCellWithReuseIdentifier:@"FNmerDiscussEvaluateTextCellID"];
    [self.jm_collectionview registerClass:[FNmerDiscussImgItemCell class] forCellWithReuseIdentifier:@"FNmerDiscussImgItemCellID"];
    [self.jm_collectionview registerClass:[FNmerDiscussHandleCell class] forCellWithReuseIdentifier:@"FNmerDiscussHandleCellID"];
    [self.jm_collectionview registerClass:[FNmerDiscussRespondItCell class] forCellWithReuseIdentifier:@"FNmerDiscussRespondItCellID"];
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
 
    //[self.jm_collectionview registerClass:[FNmerReviewheadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNmerReviewheadViewID"];
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.size = CGSizeMake(50, 30);
    self.navigationView.leftButton = self.leftBtn;
    [self.view addSubview:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 10).centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    self.navigationView.titleLabel.text=@"";
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    
    self.view.backgroundColor=RGB(246, 245, 245);
    
    [self inAddBaseRespondViews];
    
    [self requestCommentMsg];
    
    //[self requestCommentrestListMsg];
    
    [self requestQueryMsg];
    
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 6;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if(section==0){
        return 1;
    }
    else if(section==1){
       return 0;
    }
    else if(section==2){ 
        return 1;
    }
    else if(section==3){
        return self.dataModel.imgs.count;
    }
    else if(section==4){
        return 1;
    }
    else{
        if([self.dataModel.sub_comment kr_isNotEmpty]){
           return 1;
        }else{
           return 0;
        }
        
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.section==0){
        FNmerDiscussDetailsUserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerDiscussDetailsUserCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.model=self.dataModel;
        return cell;
    }
    else if(indexPath.section==1){
        FNmerDiscussDeTallyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerDiscussDeTallyCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        //cell.titleLB.text=@"有图";
        return cell;
    }
    else if(indexPath.section==2){
        FNmerDiscussEvaluateTextCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerDiscussEvaluateTextCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.model=self.dataModel;
        return cell;
    }
    else if(indexPath.section==3){
        FNmerDiscussImgItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerDiscussImgItemCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        [cell.imgView setUrlImg:self.dataModel.imgs[indexPath.row]];
        return cell;
    }
    else if(indexPath.section==4){
        FNmerDiscussHandleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerDiscussHandleCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.model=self.dataModel;
        [cell.likeBtn addTarget:self action:@selector(likeBtnClick)];
        [cell.queryBtn addTarget:self action:@selector(queryBtnClick)];
        return cell;
    }
    else{
        FNmerDiscussRespondItCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmerDiscussRespondItCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.model=self.dataModel;
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemHeight=55;
    CGFloat itemWith=FNDeviceWidth;
    if(indexPath.section==0){
        itemHeight=55;
        itemWith=FNDeviceWidth;
    }
    else if(indexPath.section==1){
        itemHeight=17;
        itemWith=32;
    }
    else if(indexPath.section==2){
        CGFloat textheight=0;
        CGFloat textWidth=FNDeviceWidth-95;
        if([self.dataModel.content kr_isNotEmpty]){
            textheight=[self.dataModel.content kr_heightWithMaxWidth:textWidth attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        }
        itemHeight=textheight+50;
        itemWith=FNDeviceWidth;
    }
    else if(indexPath.section==3){
        itemHeight=96;
        itemWith=96;
    }
    else if(indexPath.section==4){
        itemHeight=45;
        itemWith=FNDeviceWidth;
    }
    else if(indexPath.section==5){
        //FNmerReviewItemModel *itemModel=[FNmerReviewItemModel mj_objectWithKeyValues:self.dataArr[indexPath.row]];
        CGFloat textheight=0;
        CGFloat textWidth=FNDeviceWidth-57;
        if([self.dataModel.sub_comment kr_isNotEmpty]){
           textheight=[self.dataModel.sub_comment kr_heightWithMaxWidth:textWidth attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
            itemHeight=textheight+40;
        }else{
           itemHeight=0;
        }
        itemWith=FNDeviceWidth;
    }
    CGSize  size = CGSizeMake(itemWith, itemHeight);
    return  size;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if(section==1){
       return 5;
    }
    else if(section==3){
        return 3;
    }
    return 0;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if(section==1){
        return 5;
    }
    else if(section==3){
        return 3;
    }else{
      return 1;
    }
    
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=0;
    CGFloat leftGap=0;
    CGFloat bottomGap=5;
    CGFloat rightGap=0;
    if(section==1){
       leftGap=64;
       rightGap=30;
    }
    else if(section==3){
        bottomGap=10;
        leftGap=64;
        rightGap=FNDeviceWidth-195-64;
    }
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==3){
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc]init];
        // 弹出相册时显示的第一张图片是点击的图片
        browser.currentPhotoIndex = indexPath.row;
        NSMutableArray *photos = [NSMutableArray array];
        NSArray *imgs = self.dataModel.imgs;
        [imgs enumerateObjectsUsingBlock:^(id  _Nonnull sobj, NSUInteger idx, BOOL * _Nonnull stop) {
            MJPhoto *mjPhoto = [[MJPhoto alloc] init];
            mjPhoto.url = [NSURL URLWithString:sobj]; 
            [photos addObject:mjPhoto];
        }];
        // 设置所有的图片。photos是一个包含所有图片的数组。
        browser.photos = photos;
        [browser show];
    }
}
#pragma mark - 底部View
-(void)inAddBaseRespondViews{
    CGFloat baseGap=0;
    if(isIphoneX){
        baseGap=32;
    }
    self.baseView=[[UIView alloc]init];
    self.baseView.frame=CGRectMake(0, FNDeviceHeight-45-baseGap, FNDeviceWidth, 45);
    [self.view addSubview:self.baseView];
    self.baseView.backgroundColor=[UIColor whiteColor];
//    self.baseView.sd_layout
//    .leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).heightIs(45).bottomSpaceToView(self.view, baseGap);
    UIButton *respondBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.baseView addSubview:respondBtn];
    [respondBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [respondBtn setBackgroundColor:RGB(255, 155, 48)];
    [respondBtn setTitle:@"发送" forState:UIControlStateNormal];
    respondBtn.titleLabel.font=kFONT14;
    respondBtn.cornerRadius=5;
    respondBtn.sd_layout
    .rightSpaceToView(self.baseView, 10).topSpaceToView(self.baseView, 10).widthIs(70).heightIs(29);
    
    UIView *grayView=[[UIView alloc]init];
    [self.baseView addSubview:grayView];
    grayView.backgroundColor=RGB(240, 240, 241);
    grayView.cornerRadius=5;
    grayView.sd_layout
    .leftSpaceToView(self.baseView, 10).rightSpaceToView(self.baseView, 95).heightIs(29).topSpaceToView(self.baseView, 10);
    self.compileField=[[UITextField alloc]initWithFrame:CGRectMake(15, 0, 200, 29)];
    self.compileField.font = kFONT12;
    self.compileField.delegate=self;
    //self.compileField.textColor=RGB(140, 140, 140);
    self.compileField.textAlignment=NSTextAlignmentLeft;
    [grayView addSubview:self.compileField];
    self.compileField.placeholder=@"请输入您的回应";
    [respondBtn addTarget:self action:@selector(respondBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加通知监听见键盘弹出/退出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillHideNotification object:nil];
    [self.compileField becomeFirstResponder];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.compileField becomeFirstResponder];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
   
    return YES;
}
// 点击非TextField区域取消第一响应者
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     [self.compileField resignFirstResponder];
}

// 点击键盘Return键取消第一响应者
 - (BOOL)textFieldShouldReturn:(UITextField *)textField{
     [self.compileField resignFirstResponder];
    return  YES;
 }
// 键盘监听事件
- (void)keyboardAction:(NSNotification*)sender{
       // 通过通知对象获取键盘frame: [value CGRectValue]
    NSDictionary *userInfo = [sender userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    CGFloat baseGap=0;
    if(isIphoneX){
        baseGap=32;
    }
      if([sender.name isEqualToString:UIKeyboardWillShowNotification]){
          XYLog(@"键盘高度==%f",height);
//          [self.baseView mas_updateConstraints:^(MASConstraintMaker *make) {
//              make.left.right.equalTo(self.view);
//              make.height.mas_equalTo(45);
//              make.bottom.equalTo(self.view).offset(-height);
//          }];
          
          self.baseView.frame=CGRectMake(0, FNDeviceHeight-height-45, FNDeviceWidth, 45);
        }else{
//            [self.baseView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.left.right.equalTo(self.view);
//                make.height.mas_equalTo(45);
//                make.bottom.equalTo(self.view).offset(-baseGap);
//            }];
            self.baseView.frame=CGRectMake(0, FNDeviceHeight-45-baseGap, FNDeviceWidth, 45);
    }
    
}

#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}
//发送
-(void)respondBtnClick{
    if(![self.compileField.text kr_isNotEmpty]){
        return;
    }
    [self.compileField resignFirstResponder];
    [self requestRespondMsg:self.compileField.text];
    XYLog(@"发送:%@",self.compileField.text);
}
//点赞
-(void)likeBtnClick{
    [self requestEndorseMsg:self.dataModel.id];
}
//疑问
-(void)queryBtnClick{
    if(self.queryModel.type.count>0){
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:1];
        self.customView = [[FNmerDiscussQueryView alloc] initWithFrame:CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight)];
        self.customView.delegate=self;
        self.customView.model=self.queryModel;
        self.customView.backIndex=index;
        [self.customView.rightBtn addTarget:self action:@selector(customViewDiss)];
        [self.view addSubview:self.customView];
        [self.customView showView];
    }else{
        [self requestQueryMsg];
        [FNTipsView showTips:@"请重试"];
    }
}
//取消疑问
-(void)customViewDiss{
    [self.customView dismissView];
}
#pragma mark - FNmerDiscussQueryViewDelegate 提交疑问
- (void)didMerAffirmQueryIndex:(NSIndexPath*)index withType:(NSString*)type withContent:(NSString*)content{
    XYLog(@"意见%@",content);
    XYLog(@"类型%@",type);
    if([content kr_isNotEmpty] && [type kr_isNotEmpty]){
        [self requestPresentQueryMsg:self.dataModel.id withType:type withContent:content];
        [self.customView dismissView];
    }
}
#pragma mark - // request
//添加评论页面
-(FNRequestTool*)requestCommentMsg{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.oidStr kr_isNotEmpty]){
        params[@"id"]=self.oidStr;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=comment_detail" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSDictionary *dictry=respondsObject[DataKey];
        self.dataModel=[FNmerchentReviewModel mj_objectWithKeyValues:dictry];
        [self.jm_collectionview reloadData];
    } failure:^(NSString *error) {
    } isHideTips:YES isCache:NO];
}
//商家中心-评论详情子评论
//-(FNRequestTool*)requestCommentrestListMsg{
//    @weakify(self);
//    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes],PageSize:@(_jm_pro_pagesize),PageNumber:@(self.jm_page)}];
//    if([self.oidStr kr_isNotEmpty]){
//        params[@"id"]=self.oidStr;
//    }
//    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=small_store&ctrl=sub_comment" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
//        @strongify(self);
//        NSDictionary *dictry=respondsObject[DataKey];
//        NSArray *array =dictry[@"list"];
//        if (self.jm_page == 1) {
//            if (array.count == 0) {
//                [self.dataArr removeAllObjects];
//                [self.jm_collectionview reloadData];
//                return ;
//            }
//            [self.dataArr removeAllObjects];
//            [self.dataArr addObjectsFromArray:array];
//            if (array.count >= _jm_pro_pagesize) {
//                self.jm_collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//                    self.jm_page ++;
//                    [self requestCommentrestListMsg];
//                }];
//            }else{
//            }
//        } else {
//            [self.dataArr addObjectsFromArray:array];
//            if (array.count >= _jm_pro_pagesize) {
//                [self.jm_collectionview.mj_footer endRefreshing];
//                
//            }else{
//                [self.jm_collectionview.mj_footer endRefreshingWithNoMoreData];
//            }
//        }
//        [self.jm_collectionview reloadData];
//        
//    } failure:^(NSString *error) {
//    } isHideTips:YES isCache:NO];
//}
//添加评论
-(void)requestRespondMsg:(NSString*)content{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.oidStr kr_isNotEmpty]){
        params[@"id"]=self.oidStr;
    }
    params[@"content"]=content;
     [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_comment&ctrl=add_sub_comment" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
         @strongify(self);
         NSInteger state=[respondsObject[SuccessKey] integerValue];
         NSString *msgStr=respondsObject[MsgKey];
         [FNTipsView showTips:msgStr];
         if(state==1){
             [self requestCommentMsg];
         }
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}

///疑问页面
-(void)requestQueryMsg{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_comment&ctrl=doubt_page" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSDictionary*dictry=respondsObject[DataKey];
        self.queryModel=[FNmerReviewQueryModel mj_objectWithKeyValues:dictry];
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}
///提交疑问
-(void)requestPresentQueryMsg:(NSString*)msgID withType:(NSString*)type withContent:(NSString*)content{
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    params[@"id"]=content;
    params[@"type"]=type;
    params[@"content"]=content;
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_comment&ctrl=add_doubt" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSDictionary*dictry=respondsObject;
        NSString *mesString=dictry[@"msg"];
        [FNTipsView showTips:mesString];
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}
///评论点赞
-(void)requestEndorseMsg:(NSString*)discussid{
    if([discussid kr_isNotEmpty]){
        @weakify(self);
        NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
        params[@"id"]=discussid;
        [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_comment&ctrl=vote" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
            @strongify(self);
            NSDictionary*dictry=respondsObject;
            NSInteger success=[dictry[@"success"] integerValue];
            NSString *mesString=dictry[@"msg"];
            [FNTipsView showTips:mesString];
            if(success==1){
                [self requestCommentMsg];
            }
        } failure:^(NSString *error) {
        } isHideTips:NO isCache:NO];
    }
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
