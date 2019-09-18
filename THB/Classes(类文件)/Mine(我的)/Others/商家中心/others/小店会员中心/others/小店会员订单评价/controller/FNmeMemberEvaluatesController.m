//
//  FNmeMemberEvaluatesController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmeMemberEvaluatesController.h"
#import "FNCustomeNavigationBar.h"
#import "FNmeMemberEvaluatesMsgCell.h"
#import "FNmeMeEvaluatesEditCell.h"
#import "FNmeMemberEvaluatesModel.h"
@interface FNmeMemberEvaluatesController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FNmeMeEvaluatesEditCellDelegate,FNmeMemberStarViewDelegate,FNmeMemberEvaluatesMsgCellDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, assign)CGFloat sectionHeight; 
@property (nonatomic, strong)NSString *consumeStr;
@property (nonatomic, strong)NSString *evaluateContent;
@property (nonatomic, strong)NSString *starLevel;
@property (nonatomic, strong)NSString *anonymity;
@property (nonatomic, strong)NSArray *evaluateImgs;
@property (nonatomic, strong)FNmeMemberEvaluatesModel *dataModel;
@end

@implementation FNmeMemberEvaluatesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
#pragma mark - set up views
- (void)jm_setupViews{
    self.anonymity=@"0";
    self.starLevel=@"0";
    self.sectionHeight=320+(FNDeviceWidth-60)/4;
    CGFloat topGap=SafeAreaTopHeight;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, topGap, FNDeviceWidth, FNDeviceHeight-topGap) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.emptyDataSetDelegate = nil;
    self.jm_collectionview.emptyDataSetSource = nil;
    
    self.jm_collectionview.backgroundColor=RGB(250, 250, 250);
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNmeMemberEvaluatesMsgCell class] forCellWithReuseIdentifier:@"FNmeMemberEvaluatesMsgCellID"];
    [self.jm_collectionview registerClass:[FNmeMeEvaluatesEditCell class] forCellWithReuseIdentifier:@"FNmeMeEvaluatesEditCellID"];
    
    
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
    self.navigationView.titleLabel.text=@"订单评价";
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor]; 
    self.view.backgroundColor=RGB(250, 250, 250);
    if([self.orderId kr_isNotEmpty]){
       [self requestCommentMsg];
    }
    if([self.isAmend isEqualToString:@"1"]){
        if([self.amendModel.username containsString:@"匿名"]){
            self.anonymity=@"1";
        }else{
            self.anonymity=@"0";
        }
        self.consumeStr=self.amendModel.average_price;
        self.evaluateContent=self.amendModel.content;
        self.starLevel=self.amendModel.star;
        NSArray *imgsArr=self.amendModel.imgs;
        @weakify(self)
        [XYNetworkAPI downloadImages:imgsArr withFinishedBlock:^(NSArray<UIImage *> *images) {
            @strongify(self)
            self.evaluateImgs=images;
        }];
        self.sectionHeight=320+(FNDeviceWidth-60)/4*2;
    }
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        FNmeMemberEvaluatesMsgCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmeMemberEvaluatesMsgCellID" forIndexPath:indexPath];
        cell.backgroundColor=RGB(250, 250, 250);
        cell.starView.delegate=self;
        cell.model=self.dataModel;
        if([self.isAmend isEqualToString:@"1"]){
            cell.alterModel=self.amendModel;
            NSInteger starInt=[self.amendModel.star integerValue];
            NSArray *hintArr=self.dataModel.star_level;
            if(hintArr.count==6){
               cell.starStrLB.text=hintArr[starInt];
            }
        }
        cell.delegate=self;
        return cell;
    }else{
        FNmeMeEvaluatesEditCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNmeMeEvaluatesEditCellID" forIndexPath:indexPath];
        cell.delegate=self;
        cell.backgroundColor=RGB(250, 250, 250);
        cell.model=self.dataModel;
        if([self.isAmend isEqualToString:@"1"]){
            cell.alterModel=self.amendModel;
        }
        [cell.submitBtn addTarget:self action:@selector(submitBtnClick)];
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemHeight=0;
    CGFloat itemWith=FNDeviceWidth-20;
    if(indexPath.section==0){
        itemHeight=335;
    }else{
        itemHeight=self.sectionHeight;
    }
    CGSize  size = CGSizeMake(itemWith, itemHeight);
    return  size;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat topGap=10;
    CGFloat leftGap=10;
    CGFloat bottomGap=10;
    CGFloat rightGap=10;
    return UIEdgeInsetsMake(topGap, leftGap, bottomGap, rightGap);
}
#pragma mark - FNmeMemberEvaluatesMsgCellDelegate
//人均消费
- (void)didmeMeConsumeEdit:(NSString*)consume{
    self.consumeStr=consume;
}
//是否匿名
- (void)didmeMeAnonymityAction:(NSString*)isAnonymity{
    self.anonymity=isAnonymity;
}
#pragma mark - FNmeMeEvaluatesEditCellDelegate
//评价文字
- (void)didmeMeEvaluatesEdit:(NSString*)content{
    self.evaluateContent=content;
}
//评价图片
- (void)didmeMeEvaluatesAction:(NSArray*)photoArr{
    self.evaluateImgs=photoArr;
}
#pragma mark - FNmeMemberStarViewDelegate
//星级
- (void)didMeMemberStarViewLevel:(NSInteger)level{
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
     FNmeMemberEvaluatesMsgCell *itemCell=(FNmeMemberEvaluatesMsgCell *)[self.jm_collectionview cellForItemAtIndexPath:index];
    NSArray *hintArr=self.dataModel.star_level;
    if(hintArr.count==6){
       itemCell.starStrLB.text=hintArr[level];
    }else{
        if(level==0){
            itemCell.starStrLB.text=@"差评";
        }
        if(level==1){
            itemCell.starStrLB.text=@"差评";
        }
        if(level>1&&level<4){
            itemCell.starStrLB.text=@"一般般";
        }
        if(level>3){
            itemCell.starStrLB.text=@"超赞";
        }
    } 
    self.starLevel=[NSString stringWithFormat:@"%ld",(long)level];
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)submitBtnClick{
    if(![self.consumeStr kr_isNotEmpty]){
        [FNTipsView showTips:@"请输入人均消费"];
        return;
    }
    else if(![self.evaluateContent kr_isNotEmpty]){
        [FNTipsView showTips:@"请输入评价内容"];
        return;
    }
    else if(self.evaluateImgs.count>4){
        [FNTipsView showTips:@"最多上传4张图片"];
        return;
    }
    [self requestRebateAlbum];
}
#pragma mark - request
//添加评论页面
-(FNRequestTool*)requestCommentMsg{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    params[@"oid"]=self.orderId;
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_comment&ctrl=add_comment_page" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        NSDictionary *dictry = respondsObject[DataKey];
        self.dataModel=[FNmeMemberEvaluatesModel mj_objectWithKeyValues:dictry];
        [self.jm_collectionview reloadData];
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
} 
//添加评论  修改评论
-(void)requestRebateAlbum{
    [SVProgressHUD show];
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    NSString *url=@"";
    if([self.isAmend isEqualToString:@"0"] || ![self.isAmend kr_isNotEmpty]){
        params[@"order_id"]=self.orderId;
        params[@"store_id"]=self.store_id;
        params[@"is_anonymous"]=self.anonymity;
        params[@"star"]=self.starLevel;
        params[@"content"]=self.evaluateContent;
        params[@"average_price"]=self.consumeStr;
        url=@"mod=appapi&act=rebate_comment&ctrl=add_comment";
    }
    if([self.isAmend isEqualToString:@"1"]){
        url=@"mod=appapi&act=rebate_comment&ctrl=edit";
        params[@"id"]=self.amendModel.id;
        params[@"average_price"]=self.consumeStr;
        params[@"content"]=self.evaluateContent;
        params[@"star"]=self.starLevel;
        params[@"is_anonymous"]=self.anonymity;
        
        if(self.evaluateImgs.count>0&&self.amendModel.imgs.count>0){
            NSInteger beforeCount=self.amendModel.imgs.count;
            NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
            for (NSInteger i=0; i<beforeCount; i++) {
                [arrM addObject:[NSString stringWithFormat:@"%ld",i+1]];
            }
            NSString *imgIdString=[arrM componentsJoinedByString:@","];
            params[@"img_ids"]=imgIdString;
        }
    }
    
    @weakify(self);
    [SVProgressHUD show];
    if(self.evaluateImgs.count>0){
        [[XYNetworkAPI sharedManager] upImageWithParameter:params imageArray:self.evaluateImgs imageSize:0.3 url:url successBlock:^(id responseBody) {
            @strongify(self);
            NSDictionary*dictry=responseBody;
            NSString *mesString=dictry[@"msg"];
            [UIView animateWithDuration:0.2 animations:^{
                [SVProgressHUD dismiss];
            }];
            [FNTipsView showTips:mesString];
            if (self.inMeMemberEvaluatesRefreshData) {
                self.inMeMemberEvaluatesRefreshData();
            }
            [self.navigationController popViewControllerAnimated:YES];
        } failureBlock:^(NSString *error) {
            [SVProgressHUD dismiss];
        }];
    }else{
        [FNRequestTool requestWithParams:params api:url respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
            @strongify(self);
            NSDictionary*dictry=respondsObject;
            NSString *mesString=dictry[@"msg"];
            [UIView animateWithDuration:0.2 animations:^{
                [SVProgressHUD dismiss];
            }];
            [FNTipsView showTips:mesString];
            if (self.inMeMemberEvaluatesRefreshData) {
                self.inMeMemberEvaluatesRefreshData();
            }
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSString *error) {
        } isHideTips:NO isCache:NO];
    }
}
@end
