//
//  COFsingleDetailsController.m
//  THB
//
//  Created by Jimmy on 2018/8/30.
//  Copyright © 2018年 方诺科技. All rights reserved.
//
//详情
#import "COFsingleDetailsController.h"
#import "FNNewProDetailController.h"
#import "COFPublishListController.h"
#import "FNMembershipUpgradeViewController.h"

#import "CircleOfFriendsCell.h"     //xiangqingcell
#import "COFDetailsEnjoyCell.h"     //点赞cell
#import "COFEvaluateCell.h"         //评价
#import "CireleImageBtn.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "COFshareView.h"

#import "CircleOfFriendsModel.h"    //详情
#import "CircleOfFriendsFrame.h"    //详情
#import "EvaluateModel.h"           //评价Model
#import "EvaluateFrame.h"           //评价cell高度
#import "CoShareItem.h"
#import "CircleOfFriendProductCell.h"
#import "HXPhotoTools.h"
#import "JhPageItemModel.h"
#import "JhScrollActionSheetView.h"
#import "FNReportListViewController.h"


@interface COFsingleDetailsController ()<UITableViewDelegate,UITableViewDataSource,CircleOfFriendsCellDelegate,UITextViewDelegate,COFDetailsEnjoyCellDelegate,COFEvaluateCellDelegate,COFshareViewDelegate,UIWebViewDelegate, CircleOfFriendProductCellDelegate,UIGestureRecognizerDelegate,UIPopoverPresentationControllerDelegate, FNReportListViewControllerDelegate>
//** TableView **//
@property (nonatomic, strong)UITableView *detailsTableView;
//评价数据
@property (nonatomic, strong)NSMutableArray *EvaluateArr;
//点赞数据
@property (nonatomic, strong)NSMutableArray *LoveArr;
//placeholder
@property (nonatomic, strong)UILabel *placeholderLabel;
//contentView
@property (nonatomic, strong)UITextView *contentView;
//回复人ID
@property (nonatomic, strong)NSString *as_uid;
//信息详情ID
@property (nonatomic, strong)NSString *productID;
//分享图片
@property (nonatomic, strong)NSMutableArray *shareimageViewArr;
//** H5地址 **//
@property(nonatomic ,strong) NSString* js_urlString;

@property(nonatomic ,strong) UIWebView* webInteractionView;

@property(atomic, assign) int count;
@property (nonatomic, strong) FNReportListViewController *reportVC;

@end

@implementation COFsingleDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"详情";
    
    [self pageWholeRequest];
    [self subDetailsTableView];
    [self commentSuper];
    [self configNav];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(onAuth) name:@"UserDidAuth" object:nil];
    
}
- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)onAuth {
    
}

- (void)configNav {
    
    if ([FNCurrentVersion isEqualToString:Setting_checkVersion]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:IMAGE(@"circle_nav_feedback") style:(UIBarButtonItemStylePlain) target:self action:@selector(showPop)];
    }
}

- (void)showPop {
    // 初始化需要弹出的视图控制器。
    _reportVC = [[FNReportListViewController alloc] initWithStyle:UITableViewStylePlain];
    // 使用 popover 样式显示视图控制器。
    _reportVC.modalPresentationStyle = UIModalPresentationPopover;
    _reportVC.delegate = self;
    
    // 获取 popover presentation controller 并且配置它。
    UIPopoverPresentationController *presentationController =
    [_reportVC popoverPresentationController];
    // 设置遵守委托协议
    presentationController.delegate = self;
    
    // 将当前锚点设置为 barButtonItem 所在的位置
    presentationController.barButtonItem = self.navigationItem.rightBarButtonItem;
    [self presentViewController:_reportVC animated:YES completion:nil];
}

#pragma mark - FNReportListViewControllerDelegate
- (void)onItemClick:(NSInteger)index {
    
    [self.reportVC dismissViewControllerAnimated:YES completion:nil];
    if (index == 0) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择举报内容" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        [alert addAction:[UIAlertAction actionWithTitle:@"色情低俗" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [FNTipsView showTips:@"已提交系统审核，将在24小时内做出处理"];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"政治敏感" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [FNTipsView showTips:@"已提交系统审核，将在24小时内做出处理"];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"广告" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [FNTipsView showTips:@"已提交系统审核，将在24小时内做出处理"];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"令人恶心" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [FNTipsView showTips:@"已提交系统审核，将在24小时内做出处理"];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"违纪违法" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [FNTipsView showTips:@"已提交系统审核，将在24小时内做出处理"];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"其它" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [FNTipsView showTips:@"已提交系统审核，将在24小时内做出处理"];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            [FNTipsView showTips:@"已提交系统审核，将在24小时内做出处理"];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        [FNTipsView showTips:@"屏蔽成功"];
    }
}


#pragma mark - UIPopoverPresentationControllerDelegate

// 即将要呈现 popover 时通知代理。
- (void)prepareForPopoverPresentation:(UIPopoverPresentationController *)popoverPresentationController {
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

// Called on the delegate when the popover controller will dismiss the popover. Return NO to prevent the dismissal of the view.
- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    return YES;
}

// Called on the delegate when the user has taken action to dismiss the popover. This is not called when the popover is dimissed programatically.
- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

// -popoverPresentationController:willRepositionPopoverToRect:inView: is called on your delegate when the
// popover may require a different view or rectangle.
// 告诉代理 UIKit 需要重新定位 popover 的位置。
- (void)popoverPresentationController:(UIPopoverPresentationController *)popoverPresentationController willRepositionPopoverToRect:(inout CGRect *)rect inView:(inout UIView  * __nonnull * __nonnull)view {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
}

/**
 *  在默认的情况下,UIPopoverPresentationController 会根据是否是 iphone 和 ipad 来选择弹出的样式,如果当前的设备是 iphone ,那么系统会选择 modal 样式,并弹出到全屏.如果我们需要改变这个默认的行为,则需要实现代理,在代理 - adaptivePresentationStyleForPresentationController: 这个方法中返回一个 UIModalPresentationNone 样式
 */
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

#pragma mark - 单元
-(void)subDetailsTableView{
    
    self.detailsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight-SafeAreaTopHeight-60 - (isIphoneX ? 20 : 0)) style:UITableViewStylePlain];
    self.detailsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.detailsTableView.dataSource = self;
    self.detailsTableView.delegate = self;
    self.detailsTableView.estimatedRowHeight = 800;
    [self.view addSubview:self.detailsTableView];
    self.detailsTableView.backgroundColor = RGB(245, 245, 245);
    //self.detailsTableView.hidden=YES;
    if (@available(iOS 11.0, *)) {
//        self.detailsTableView.estimatedRowHeight = 0;
        self.detailsTableView.estimatedSectionFooterHeight = 0;
        self.detailsTableView.estimatedSectionHeaderHeight= 0; self.detailsTableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }
    @weakify(self);
    self.detailsTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.jm_page = 1;
       
        [self apiRequestEvaluateList];
        
    }];
    
    self.detailsTableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        @strongify(self);
        self.jm_page += 1;
        
       [self apiRequestEvaluateList];
        
    }];
     
    
}
#pragma mark - 本页全部数据
-(void)pageWholeRequest{
    [self apiRequestDetails];
    [self apiRequestLoveList];
    [self apiRequestEvaluateList];
}
#pragma mark - 评论
-(void)commentSuper{
    UIView *commentBgView=[UIView new];
    commentBgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:commentBgView];
//    commentBgView.sd_layout
//    .leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.detailsTableView , 0).bottomSpaceToView(self.view, 0);

    [commentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailsTableView.mas_bottom);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@0).mas_offset(isIphoneX ? -20 : 0);
    }];
    
    UIButton *forwardBtn=[UIButton new];
    forwardBtn.backgroundColor=FNColor(249, 67, 124);
    [forwardBtn setTitle:@"发送" forState:UIControlStateNormal];
    forwardBtn.borderWidth=0.5;
    forwardBtn.borderColor = FNColor(249, 67, 124);
    forwardBtn.cornerRadius=5;
    [forwardBtn addTarget:self action:@selector(forwardClick) forControlEvents:UIControlEventTouchUpInside];
    forwardBtn.titleLabel.font=[UIFont fontWithDevice:12];
    [commentBgView addSubview:forwardBtn];
    forwardBtn.sd_layout
    .rightSpaceToView(commentBgView, 10).widthIs(80).topSpaceToView(commentBgView, 10).bottomSpaceToView(commentBgView, 10);
    //输入
    UITextView *contentView=[UITextView new];
    contentView.backgroundColor=[UIColor whiteColor];
    contentView.editable = YES;
    contentView.delegate = self;
    contentView.font = [UIFont fontWithDevice:12];
    //设置是否可以滚动
    contentView.scrollEnabled = YES;
    [commentBgView addSubview:contentView];
    contentView.sd_layout
    .leftSpaceToView(commentBgView, 10).rightSpaceToView(forwardBtn, 5).topSpaceToView(commentBgView, 10).bottomSpaceToView(commentBgView, 10);
    self.contentView=contentView;
    
    UILabel *lineLab = [[UILabel alloc]init];
    lineLab.backgroundColor=FNColor(249, 67, 124);
    [commentBgView addSubview:lineLab];
    lineLab.sd_layout
    .leftSpaceToView(commentBgView, 10).rightSpaceToView(forwardBtn, 5).topSpaceToView(contentView, 0).heightIs(1);
    
    //placeholder
    UILabel *placeholderLabel=[UILabel new] ;
    placeholderLabel.textColor=[UIColor lightGrayColor];
    placeholderLabel.text=@"请输入评论内容";
    placeholderLabel.font=[UIFont fontWithDevice:12];
    placeholderLabel.textAlignment=NSTextAlignmentLeft;
    [contentView addSubview:placeholderLabel];
    placeholderLabel.sd_layout.leftSpaceToView(contentView, 7.5).heightIs(35).topSpaceToView(contentView, 0);
    [placeholderLabel setSingleLineAutoResizeWithMaxWidth:150];
    self.placeholderLabel=placeholderLabel;
    
}
#pragma mark - 发送
-(void)forwardClick{
    XYLog(@"发送");
    if ([NSString isEmpty:UserAccessToken]) {
        [self gologin];
        return;
    }
    self.jm_page=1;
    [self apiRequestSendeValuate];
    [self.contentView resignFirstResponder];
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
      return 1;
    }
    else if(section==1){
        if(self.LoveArr.count>0){
            return 1;
        }else{
            return 0;
        } 
    }
    else{
        return self.EvaluateArr.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        CircleOfFriendProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CircleOfFriendProductCell"];
        if (cell == nil) {
            cell = [[CircleOfFriendProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detailscell"];
        }
        CircleOfFriendsProductModel *model = self.detailsDictry.productModel;
        [cell.btnHeader sd_setBackgroundImageWithURL:URL(model.head_img) forState:UIControlStateNormal completed:nil];
        cell.lblStore.text = model.nickname;
        [cell.imgStore sd_setImageWithURL:URL(model.shop_img)];
        [cell.btnSaveAlbum sd_setBackgroundImageWithURL:URL(model.btn1_img) forState:UIControlStateNormal completed:nil];
        [cell.btnShare sd_setBackgroundImageWithURL:URL(model.btn2_img) forState:UIControlStateNormal completed:nil];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:model.content];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:4];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [model.content length])];
        [cell.lblTitle setAttributedText:attributedString];
        //    cell.lblTitle.text = model.content;

        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress:)];
        lpgr.delegate = self;
        lpgr.delaysTouchesBegan = YES;
        [cell addGestureRecognizer:lpgr];
        
        cell.lblTime.text = [NSString getTimeStr:model.time withFormat:@"yyyy-MM-dd HH:mm:ss"];
        if(![model.commission_str kr_isNotEmpty]){
            cell.imgCommission.hidden = YES;
        }else{
            cell.imgCommission.hidden = NO;
            
        }
        cell.lblCommission.text = model.commission_str;
//        [cell.btnCommand setTitle:model.evaluate_num forState:UIControlStateNormal];
//        [cell.btnLike setTitle:model.thumbs_num forState:UIControlStateNormal];
        if (model.thumbs_num.integerValue >= 10000) {
            double thumbs = (model.thumbs_num.doubleValue / 10000);
            [cell.btnLike setTitle:[NSString stringWithFormat:@"%.1f万", thumbs] forState:UIControlStateNormal];
        } else {
            [cell.btnLike setTitle:model.thumbs_num forState:UIControlStateNormal];
        }
        if (model.evaluate_num.integerValue >= 10000) {
            double evaluate = (model.evaluate_num.doubleValue / 10000);
            [cell.btnCommand setTitle:[NSString stringWithFormat:@"%.1f万", evaluate] forState:UIControlStateNormal];
        } else {
            [cell.btnCommand setTitle:model.evaluate_num forState:UIControlStateNormal];
        }

//        [cell setImages:model.img];

        [cell setImages:model.imgData];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSMutableArray *colors = [[NSMutableArray alloc] init];
        NSMutableArray *urls = [[NSMutableArray alloc] init];
        for (CircleOfFriendsProductShareModel *content in model.share_content) {
            [array addObject:content.str];
            [colors addObject:[UIColor colorWithHexString:content.color]];
            [urls addObject:content.img];
        }
        [cell setCommands:array withColors:colors ButtonUrl:urls];
        cell.delegate = self;
        return cell;
//        CircleOfFriendsCell* detailscell = [tableView dequeueReusableCellWithIdentifier:@"detailscell"];
//        if (detailscell == nil) {
//            detailscell = [[CircleOfFriendsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detailscell"];
//        }
//        detailscell.selectionStyle = UITableViewCellSelectionStyleNone;
//        detailscell.ProductIndexpath=indexPath;
//        CircleOfFriendsFrame *cFrame = self.detailsDictry;
//        detailscell.circleFrame = cFrame;
//        [detailscell setChildBtnTag:indexPath.row];
//        detailscell.lineLab.hidden=YES;
//        [detailscell.likeBtn setTitle:@""];
//        [detailscell.disLikeBtn setTitle:@""];
//        detailscell.delegate = self;
//        return detailscell;
    }else if(indexPath.section==1){
        COFDetailsEnjoyCell* likecell = [tableView dequeueReusableCellWithIdentifier:@"likecell"];
        if (likecell == nil) {
            likecell = [[COFDetailsEnjoyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"likecell"];
        }
        likecell.selectionStyle = UITableViewCellSelectionStyleNone;
        likecell.headArr=self.LoveArr;
        likecell.delegate=self;
        likecell.backgroundColor=[UIColor whiteColor];
        return likecell;
    }else{
        COFEvaluateCell* cell = [tableView dequeueReusableCellWithIdentifier:@"discussCell"];
        if (cell == nil) {
            cell = [[COFEvaluateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"discussCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(indexPath.row==0){
            cell.evaluateView.image=IMAGE(@"circle_comment");
            cell.evaluateView.hidden=NO;
        }else{
            cell.evaluateView.hidden=YES;
        }
        cell.delegate=self;
        EvaluateFrame *frameModel=self.EvaluateArr[indexPath.row];
        EvaluateModel *model=frameModel.model;
        cell.evaluate=model;
        [cell setChildDetailsTag:indexPath.row];
        return cell;
    }
   
}
#pragma mark - Table view Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return UITableViewAutomaticDimension;
    }
    else if(indexPath.section==1){
        return 80;
    }
    else{
        EvaluateFrame *frameModel=self.EvaluateArr[indexPath.row];
        XYLog(@"cellHeight:%f",frameModel.cellHeight);
        return frameModel.cellHeight;
    }
}
-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }
    @weakify(self)
    [self authShare: ^(BOOL isAuthed) {
        @strongify(self)
        if (!isAuthed) {
            return;
        }
        CircleOfFriendsProductModel *model = self.detailsDictry.productModel;
        XYLog(@"content:%@",model.content);
        [FNTipsView showTips:@"复制成功"];
        [[UIPasteboard generalPasteboard] setString:model.content];
    }];
    
}

#pragma mark - CircleOfFriendsCellDelegate
// 喜欢
- (void)likeBtnClickAction:(CireleImageBtn *)sender{
    if ([NSString isEmpty:UserAccessToken]) {
        [self gologin];
        return;
    }
    XYLog(@"喜欢");
//    CircleOfFriendsFrame *cFrame = self.detailsDictry;
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
        [self gologin];
        return;
    }
    
}
//分享
-(void)shareBtnClickAction:(UIButton *)sender{
    if ([NSString isEmpty:UserAccessToken]) {
        [self gologin];
        return;
    }
//    if ([FNBaseSettingModel settingInstance].all_fx_onoff.boolValue) {
//        CircleOfFriendsFrame *cFrame =  self.detailsDictry;
//        CircleOfFriendsProductModel *commit = cFrame.productModel;
//        self.productID=commit.id;
//        //NSString *contentString=commit.content;
//        //[self apiRequestShareInformation];
//        //[self apiRequestInteraction];
//        NSInteger is_need_js=[commit.is_need_js integerValue];
//        self.js_urlString=commit.jsurl;
//        if(is_need_js==0){
//            [self apiRequestShareInformation];
//        }
//        if(is_need_js==1){
//            [self apiRequestHFURL];
//        }
//    }else{
//        [FNTipsView showTips:@"请升级更高等级享受分享赚"];
//        FNMembershipUpgradeViewController* VC = [FNMembershipUpgradeViewController new];
//        [self.navigationController pushViewController:VC animated:YES];
//    }
}

// 详情
-(void)detailsClickAction:(UIButton *)sender{
    if ([NSString isEmpty:UserAccessToken]) {
        [self gologin];
        return;
    }
    XYLog(@"详情");
    CircleOfFriendsFrame *cFrame =self.detailsDictry;
    CircleOfFriendsProductModel *commit = cFrame.productModel;
     
    NSString *typeString=commit.type;
    if([typeString isEqualToString:@"pub_one_goods"]){
        FNNewProDetailController* detail = [FNNewProDetailController new];
        detail.fnuo_id = commit.fnuo_id;
        detail.getGoodsType = commit.goods_type;
        detail.goods_title = @"";
        detail.SkipUIIdentifier = commit.goods_type;
        [self.navigationController pushViewController:detail animated:YES];
    }else if([typeString isEqualToString:@"pub_more_goods"]){
        
    }
    else if([typeString isEqualToString:@"pub_guanggao"]){
        NSLog(@"url:%@",commit.url);
        
        if([commit.url kr_isNotEmpty]){
            XYLog(@"广告");
            [self goWebDetailWithWebType:@"0" URL:commit.url];
        }else{
            [FNTipsView showTips:@"返回的无效链接!" withDuration:1.0];
        }
    }
}
//选择图片
-(void)selectProductAction:(NSInteger)sender row:(NSInteger)row{
    XYLog(@"图:%ldrow:%ld",(long)sender,(long)row);
    CircleOfFriendsFrame *cFrame = self.detailsDictry;
    CircleOfFriendsProductModel *commit = cFrame.productModel;
    CircleOfFriendsImageModel *ImageModel=[CircleOfFriendsImageModel mj_objectWithKeyValues:commit.imgData[sender]];
    //跳转商品
    if([ImageModel.fnuo_id kr_isNotEmpty]){
        if ([NSString isEmpty:UserAccessToken]) {
            [self gologin];
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
    CircleOfFriendsFrame *cFrame = self.detailsDictry;
    CircleOfFriendsProductModel *commit = cFrame.productModel;
    COFPublishListController *publishVc=[[COFPublishListController alloc]init];
    publishVc.publisherID=commit.uid;
    publishVc.publisherName=commit.nickname;
    [self.navigationController pushViewController:publishVc animated:YES];
}
#pragma mark -   COFshare分享
-(void)COFshareBtnClick:(NSInteger )sender{
    NSLog(@"分享%ld",(long)sender);
    UIActivityViewController* vc = [[UIActivityViewController alloc]initWithActivityItems:_shareimageViewArr applicationActivities:nil];
    [self presentViewController:vc animated:YES completion:nil];
    
}
#pragma mark - 其他点击事件
//点击选择头像
-(void)ClickToChooseThePicture:(UIButton *)sender{
    XYLog(@"选择头像:%ld",(long)sender.tag);
    //LikeHeadPortraitModel *Model=self.LoveArr[sender.tag];
    //self.as_uid=Model.uid;
    //self.placeholderLabel.text=[NSString stringWithFormat:@"@ %@",Model.nickname];
}
//点击选择头像(或本人名字)
-(void)ClickProfilePhoto:(NSInteger)sender{
    XYLog(@"选择昵称 :%ld",(long)sender);
    EvaluateFrame *frameModel=self.EvaluateArr[sender];
    EvaluateModel *model=frameModel.model;
    NSString *replierString=model.pj_nickname;
    self.as_uid=model.uid;
    self.placeholderLabel.text=[NSString stringWithFormat:@"@ %@",replierString];
}
//点击选择 @的人的昵称 as_nickname  ?否则 pj_nickname 评价人的昵称
-(void)ClickWithContent:(NSInteger)sender{
    XYLog(@"选择昵称 :%ld",(long)sender);
    EvaluateFrame *frameModel=self.EvaluateArr[sender];
    EvaluateModel *model=frameModel.model;
    NSString *replierString=@"";
    //if([model.as_nickname kr_isNotEmpty]){
    //    replierString=model.as_nickname;
    //}else{
    //    replierString=model.pj_nickname;
    //}
    replierString=model.pj_nickname;
    self.as_uid=model.uid;
    self.placeholderLabel.text=[NSString stringWithFormat:@"@ %@",replierString];
}
    
- (void)saveImages {
    @weakify(self)
    [self authShare: ^(BOOL isAuthed) {
        @strongify(self)
        if (!isAuthed) {
            return;
        }
        CircleOfFriendsProductModel *commit = self.detailsDictry.productModel;
        self.count = 0;
        [FNTipsView showTips:@"文案复制成功"];
        [[UIPasteboard generalPasteboard] setString:commit.content];
        [SVProgressHUD show];
        @weakify(self);
        for (NSString *imageUrl in commit.share_img) {
            [[SDWebImageManager sharedManager] downloadImageWithURL:URL(imageUrl) options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                if (finished) {
                    @strongify(self);
                    NSString *name = [NSString stringWithFormat:@"%lf", [NSDate dateWithTimeIntervalSinceNow:0].timeIntervalSince1970];
                    [HXPhotoTools savePhotoToCustomAlbumWithName:name photo: image];
                    self.count++;
                    if (self.count == commit.share_img.count) {
                        
                        [SVProgressHUD dismiss];
                        [FNTipsView showTips:@"保存成功～"];
                    }
                }
            }];
        }
    }];
}
#pragma mark - Request
//获取详情
- (FNRequestTool *)apiRequestDetails{
    self.as_uid=_detailsDictry.productModel.uid;
    [self.detailsTableView reloadData];
//    [self.detailsTableView.mj_header endRefreshing];
//    //self.detailsTableView.hidden=NO;
//    [SVProgressHUD show];
//    @WeakObj(self);
//    NSString *token = UserAccessToken;
//    XYLog(@"DetailsID:%@",selfWeak.DetailsID);
//    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"id":selfWeak.DetailsID,@"token":token}];
//    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=circleOfFriends&ctrl=friendCircleDetail" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
//        XYLog(@"详情:%@",respondsObject);
//        NSArray *commitsList =  respondsObject [DataKey];
//        CircleOfFriendsFrame *cFrame = [[CircleOfFriendsFrame alloc]init];
//        cFrame.productModel=[CircleOfFriendsProductModel mj_objectWithKeyValues:commitsList[0]];
//        selfWeak.detailsDictry=cFrame;
//        selfWeak.as_uid=cFrame.productModel.uid;
//        selfWeak.placeholderLabel.text=[NSString stringWithFormat:@"@%@",cFrame.productModel.nickname];
//        [UIView animateWithDuration:0.5 animations:^{
//            [SVProgressHUD dismiss];
//        }];
//        [selfWeak.detailsTableView reloadData];
//
//    } failure:^(NSString *error) {
//        //
//    } isHideTips:YES];
    return nil;
}
//获取点赞列表
- (FNRequestTool *)apiRequestLoveList{
    [SVProgressHUD show];
    @WeakObj(self);
    NSString *token = UserAccessToken;
    XYLog(@"DetailsID:%@",selfWeak.DetailsID);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"id":selfWeak.DetailsID,@"token":token}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=circleOfFriends&ctrl=thumbs_man" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"点赞:%@",respondsObject);
        NSArray *commitsList =  respondsObject [DataKey];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dictDict in commitsList) {
            [arrM addObject:[LikeHeadPortraitModel mj_objectWithKeyValues:dictDict]];
        }
        selfWeak.LoveArr = arrM;
        [selfWeak.detailsTableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
//获取评价列表
- (FNRequestTool *)apiRequestEvaluateList{
    [self.detailsTableView.mj_footer endRefreshing];
    [self.detailsTableView.mj_header endRefreshing];
    @WeakObj(self);
    NSString *token = UserAccessToken;
    XYLog(@"DetailsID:%@",selfWeak.DetailsID);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"id":selfWeak.DetailsID,@"token":token,@"p":@(self.jm_page)}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=circleOfFriends&ctrl=show_evaluate" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"评价:%@",respondsObject);
        NSArray *commitsList =  respondsObject [DataKey];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dictDict in commitsList) {
             //EvaluateModel *model=[EvaluateModel mj_objectWithKeyValues:dictDict];
            EvaluateFrame *frameModel=[[EvaluateFrame alloc]init];
            frameModel.model=[EvaluateModel mj_objectWithKeyValues:dictDict];
            [arrM addObject:frameModel];
        }
        if (arrM.count == 0) {
            [selfWeak.detailsTableView.mj_footer endRefreshingWithNoMoreData];
        }
        if (self.jm_page == 1) {
            if (arrM.count == 0) {
                [selfWeak.EvaluateArr removeAllObjects];
                [selfWeak.detailsTableView reloadData];
            }
            [selfWeak.EvaluateArr removeAllObjects];
            selfWeak.EvaluateArr = arrM;
        } else {
            [selfWeak.EvaluateArr addObjectsFromArray:arrM];
        }
        
        [selfWeak.detailsTableView reloadData];
        
    } failure:^(NSString *error) {
        //
    } isHideTips:YES];
}

//发布评价
- (void )apiRequestSendeValuate{
    
    NSString *token = UserAccessToken;
    [SVProgressHUD show];
    if (![self.contentView.text kr_isNotEmpty]){
        [FNTipsView showTips:@"请填写内容!"];
    }else{
        XYLog(@"DetailsID:%@",self.DetailsID);
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"id":self.DetailsID,@"token":token,@"as_uid":self.as_uid,@"content":self.contentView.text}];
        
        @weakify(self);
        [FNRequestTool requestWithParams:params api:@"mod=appapi&act=circleOfFriends&ctrl=add_evaluate" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
            XYLog(@"发布评价:%@",respondsObject);
            [FNTipsView showTips:@"评价成功"];
            @strongify(self);
            self.contentView.text=@"";
            self.placeholderLabel.hidden=NO;
            int num = [self.detailsDictry.productModel.evaluate_num intValue];
            self.detailsDictry.productModel.evaluate_num = [NSString stringWithFormat:@"%d", num + 1];
            [self apiRequestEvaluateList];
            
            [SVProgressHUD dismiss];
        } failure:^(NSString *error) {
            [SVProgressHUD dismiss];
        } isHideTips:NO];

    }
}

//点赞
- (FNRequestTool *)apiRequestLike: (NSString*)ID success: (RequestSuccess)success{
    @WeakObj(self);
    //XYLog(@"FuBarID:%@",selfWeak.productID);
    NSString *token = UserAccessToken;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":token,@"id":ID}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=circleOfFriends&ctrl=add_thumbs" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"点赞结果:%@",respondsObject);
        
        success(respondsObject);
        [selfWeak apiRequestDetails];
        [selfWeak apiRequestLoveList];
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
}
//不喜欢 不赞
- (FNRequestTool *)apiRequestDislike: (NSString*)ID success: (RequestSuccess)success{
    @WeakObj(self);
    XYLog(@"FuBarID:%@",selfWeak.productID);
    NSString *token = UserAccessToken;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"id":ID,@"token":token}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=circleOfFriends&ctrl=cancel_thumbs" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"不喜欢结果:%@",respondsObject);
        success(respondsObject);
        [selfWeak apiRequestDetails];
        [selfWeak apiRequestLoveList];
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
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
        NSLog(@"shareimageViewArr:%@",selfWeak.shareimageViewArr);
        //朋友圈分享
        [SVProgressHUD dismiss];
        
            
        UIActivityViewController* vc = [[UIActivityViewController alloc]initWithActivityItems:_shareimageViewArr applicationActivities:nil];
        [self presentViewController:vc animated:YES completion:nil];
        
        
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
//复制
- (FNRequestTool *)apiRequestCopy: (NSString*) ID andType: (NSString*)type{
    [SVProgressHUD show];
    NSString *token = UserAccessToken;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":token,@"id":ID, @"share_type": type}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=circleOfFriends02&ctrl=get_copy_wenan" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSDictionary *dictry = respondsObject[DataKey];
        NSString *content = [dictry objectForKey:@"str"];
        
        [FNTipsView showTips:@"评论复制成功"];
        [[UIPasteboard generalPasteboard] setString:content];
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
        [FNTipsView showTips:@"复制失败，请稍后重试"];
        [SVProgressHUD dismiss];
    } isHideTips:NO];
}

#pragma mark - 其他
-(void)webViewDidFinishLoad:(UIWebView*)webView{
    [self apiRequestShareInformation];
}

//当textView的内容发生改变的时候调用
- (void)textViewDidChange:(UITextView *)textView {
    XYLog(@"textView:%@",textView.text);
    //NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //paragraphStyle.lineSpacing = 2.5;// 字体的行间距
    //NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSParagraphStyleAttributeName:paragraphStyle};
    //textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
    if([textView.text kr_isNotEmpty]){
        _placeholderLabel.hidden = YES;
    }else{
        _placeholderLabel.hidden = NO;
    }
}
-(NSMutableArray *)EvaluateArr{
    if (!_EvaluateArr) {
        _EvaluateArr = [NSMutableArray array];
    }
    return _EvaluateArr;
}
-(NSMutableArray *)LoveArr{
    if (!_LoveArr) {
        _LoveArr = [NSMutableArray array];
    }
    return _LoveArr;
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

#pragma mark - CircleOfFriendProductCellDelegate

- (void)productCellDidLikeClick:(CircleOfFriendProductCell*)cell {
    if ([NSString isEmpty:UserAccessToken]) {
        [self gologin];
        return;
    }
    XYLog(@"喜欢");
    CircleOfFriendsProductModel *model = self.detailsDictry.productModel;
    if([model.is_thumb integerValue]==0){
        [self apiRequestLike:model.ID success:^(id respondsObject) {
            int num = model.thumbs_num.intValue;
            model.thumbs_num = [NSString stringWithFormat:@"%d", num + 1];
            model.is_thumb = @"1";
        }];
    }else{
        [self apiRequestDislike: model.ID success:^(id respondsObject) {
            int num = model.thumbs_num.intValue;
            model.thumbs_num = [NSString stringWithFormat:@"%d", num - 1];
            model.is_thumb = @"0";
        }];
    }
}

- (void)productCellDidCommentClick:(CircleOfFriendProductCell*)cell {

}

- (void)productCellDidShareClick:(CircleOfFriendProductCell*)cell {
    if ([NSString isEmpty:UserAccessToken]) {
        [self gologin];
        return;
    }
    @weakify(self)
    [self authShare: ^(BOOL isAuthed) {
        @strongify(self)
        if (!isAuthed) {
            return;
        }
        if ([FNBaseSettingModel settingInstance].all_fx_onoff.boolValue) {
            CircleOfFriendsProductModel *commit = self.detailsDictry.productModel;
            self.productID=commit.ID;
            self.js_urlString=commit.jsurl;
            NSArray *datas = @[@{@"text" : @"微信",@"img" : @"FJ_wximg"},@{@"text" : @"朋友圈",@"img" : @"FJ_pyimg"},@{@"text" : @"QQ",@"img" : @"FJ_qqimg"},@{@"text" : @"微博",@"img" : @"FJ_wbimg"},@{@"text" : @"保存图片",@"img" : @"FJ_bcimg"}];
            NSMutableArray *shareArray=[NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *data in datas) {
                JhPageItemModel *item = [[JhPageItemModel alloc] init];
                item.text = data[@"text"];
                item.img = data[@"img"];
                [shareArray addObject:item];
            }
            NSString *hintString=@"注：由于新版微信调整了分享策略，如遇到多图无法分享至朋友圈，请先保存图片再打开微信分享。";
            [JhScrollActionSheetView  showShareActionSheetWithTitle:@"分享方式" withdescribe:hintString shareDataArray:shareArray handler:^(JhScrollActionSheetView *actionSheet, NSInteger index) {
                if (index == 4) {
                    [self saveImages];
                    return ;
                }
                
                [self apiRequestShareInformation];
            }];
        }else{
            [self loadMembershipUpgradeViewController];
        }
    }];
}

- (void)productCellDidSaveClick:(CircleOfFriendProductCell*)cell {
    [self saveImages];
}

- (void)productCellDidHeaderClick:(CircleOfFriendProductCell*)cell {
    CircleOfFriendsProductModel *commit = self.detailsDictry.productModel;
    COFPublishListController *publishVc=[[COFPublishListController alloc]init];
    publishVc.publisherID=commit.uid;
    publishVc.publisherName=commit.nickname;
    [self.navigationController pushViewController:publishVc animated:YES];
}

- (void)productCell:(CircleOfFriendProductCell*)cell didCopyClickAtIndex: (NSInteger)index {
    @weakify(self)
    [self authShare: ^(BOOL isAuthed) {
        @strongify(self)
        if (!isAuthed) {
            return;
        }
        CircleOfFriendsProductModel *model = self.detailsDictry.productModel;
        CircleOfFriendsProductShareModel *content = model.share_content[index];
        
        //    [FNTipsView showTips:@"复制成功"];
        //    [[UIPasteboard generalPasteboard] setString:content.str];
        [self apiRequestCopy:model.ID andType:content.share_type];
    }];
}


@end
