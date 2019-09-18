//
//  FNclienteleDeController.m
//  THB
//
//  Created by Jimmy on 2018/12/20.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNclienteleDeController.h"
//view
#import "FNClienteleDeCell.h"
//model
#import "FNclienteleDeModel.h"
@interface FNclienteleDeController ()<UICollectionViewDataSource,UICollectionViewDelegate,FNClienteleDeCellDegate>
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) NSString *phoneString;
@end

@implementation FNclienteleDeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=[self.title kr_isNotEmpty]?self.title:@"客服中心";
    [self clienteleListView];
    [self apiRequestClienteleList];
}

#pragma mark - 主视图
-(void)clienteleListView{
    CGFloat tableHeight=FNDeviceHeight-SafeAreaTopHeight;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 10;
    flowlayout.minimumInteritemSpacing = 10;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, tableHeight) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.hidden=NO;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNClienteleDeCell class] forCellWithReuseIdentifier:@"ClienteleDeCellId"];
    self.jm_collectionview.backgroundColor=RGB(246, 245, 245);
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNClienteleDeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClienteleDeCellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.delegate=self;
    FNclienteleDeModel *model=[FNclienteleDeModel mj_objectWithKeyValues:_dataArray[indexPath.row]];
    cell.model=model;
    return cell;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=FNDeviceWidth;
    CGSize size = CGSizeMake(with, 70);
    return size;
}
#pragma mark -FNClienteleDeCellDegate 点击联系客户
- (void)relationClienteleClick:(FNclienteleDeModel*)model{
    NSString *typeString=model.type;
    
    if([typeString isEqualToString:@"weixin"]){
        UIPasteboard *pab = [UIPasteboard generalPasteboard];
        NSString *string = model.str;
        [pab setString:string];
        [FNTipsView showTips: @"已复制"];
    }
    if([typeString isEqualToString:@"qq"]){
        
        if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]])
        {
            //用来接收临时消息的客服QQ号码(注意此QQ号需开通QQ推广功能,否则陌生人向他发送消息会失败)
            NSString *QQ = model.str;
            //调用QQ客户端,发起QQ临时会话
            NSString *url = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",QQ];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }else{
            [FNTipsView showTips: @"未安装QQ"];
        }
    }
    if([typeString isEqualToString:@"phone"]){
        self.phoneString=model.str;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"客服电话"
                                                        message:[NSString stringWithFormat:@"%@\n工作时间内拨打(周一至周六 8:00-18:00)",model.str]
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"拨出",nil];
         
        [alert show];
    }
}
#pragma marks -- UIAlertViewDelegate --
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    XYLog(@"index is %ld",(long)buttonIndex);
    if (buttonIndex == 1) {
        NSString *str = [NSString stringWithFormat:@"tel:%@",self.phoneString];
        
        UIWebView *callWebView = [[UIWebView alloc]init];
        
        [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        
        [self.view addSubview:callWebView];//也可以不加到页面上
    }
    
}
#pragma mark -//客服
- (FNRequestTool *)apiRequestClienteleList{
    @WeakObj(self);
    [SVProgressHUD show];
    [selfWeak.jm_collectionview.mj_footer endRefreshing];
    [selfWeak.jm_collectionview.mj_header endRefreshing];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=dg_kftype&ctrl=index" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSArray* arr = respondsObject[DataKey];
        XYLog(@"客服:%@",arr);
        NSMutableArray *typeArr=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dictry in arr) {
            [typeArr addObject:dictry];
        }
        selfWeak.dataArray=typeArr;
        [SVProgressHUD dismiss];
        selfWeak.jm_collectionview.hidden=NO;
        [selfWeak.jm_collectionview reloadData];
    } failure:^(NSString *error) {

    } isHideTips:YES];
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
