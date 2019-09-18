//
//  FNhairContactsDeController.m
//  THB
//
//  Created by Jimmy on 2019/2/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNhairContactsDeController.h"
#import "FNhairPacketSumDeCell.h"
#import "FNredCarryOutNaCell.h"
#import "FNredPackageNaFooter.h"
#import "FNRedPackageNaModel.h"
#import "FNCustomeNavigationBar.h"
#import "FNwrapPayCeView.h"
#import "FNChatManager.h"
//其他
#import <AlipaySDK/AlipaySDK.h>
#import "ModifyPaymentPasswordController.h"

@interface FNhairContactsDeController ()<UICollectionViewDelegate,UICollectionViewDataSource,FNhairPacketSumDeCellDelegate,FNredPackageNaFooterDelegate,FNwrapPayCeViewDelegate>
@property(nonatomic,strong)NSMutableArray *payArr;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIImageView *topImg;
@property(nonatomic,strong)FNCustomeNavigationBar *topNaivgationbar;
@property(nonatomic,strong)NSString *pay_type;
@property(nonatomic,strong)NSString *payPwd;
@property(nonatomic,strong)NSString *hb_idElse;
@property(nonatomic,strong)NSString *targetElse;
@property(nonatomic,strong)FNwrapPayCeView *calendarView;
@end

@implementation FNhairContactsDeController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    XYLog(@"room=:%@",self.room);
    [self requestPay];
    [self setTopNavBar];
    [self dataArrUpdate];
    [self RedPacketCollectionview];
}

#pragma mark - Networking

- (FNRequestTool*) requestPay {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection_index&ctrl=zf_type" respondType:(ResponseTypeArray) modelType:@"FNRedPackagePayModel" success:^(id respondsObject) {
        @strongify(self);
        
        [self.payArr removeAllObjects];
        NSArray<FNRedPackagePayModel*> *payment = respondsObject;
        int index = 1;
        for (FNRedPackagePayModel* pay in payment) {
            FNpackagePayNaModel *model = [[FNpackagePayNaModel alloc] init];
            model.title = pay.str;
            model.img = pay.img;
            model.sum = pay.str2;
            model.payType = pay.pay_type;
            model.payId = index++;
            [self.payArr addObject:model];
        }
        
    } failure:^(NSString *error) {
        //
    } isHideTips:YES isCache:NO];
}

#pragma mark - 导航栏view
-(void)setTopNavBar{
    
    UIView *topView=[[UIView alloc]init];
    topView.frame=CGRectMake(0, 0, FNDeviceWidth, SafeAreaTopHeight);
    //self.topImg=[[UIImageView alloc]init];
    //[topView addSubview:self.topImg];
    self.topNaivgationbar = [FNCustomeNavigationBar customeNavigationBarWithCustomeView:topView];
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,FNDeviceWidth,SafeAreaTopHeight);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:177/255.0 green:101/255.0 blue:251/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:255/255.0 green:59/255.0 blue:153/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0)];
    
    [self.topNaivgationbar.layer addSublayer:gl];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn setImage:[UIImage imageNamed:@"return-white"] forState:UIControlStateNormal];
    [self.leftBtn setTitle:@"发红包" forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font=kFONT17;
    [self.leftBtn sizeToFit];
    self.leftBtn.size = CGSizeMake(self.leftBtn.width+10, 30);
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.leftBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10.0f];
    
    self.topNaivgationbar.leftButton = self.leftBtn;
    
    [self.view addSubview:_topNaivgationbar];
    self.topNaivgationbar.backgroundColor =[UIColor whiteColor];
    
}
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 红包UI
-(void)RedPacketCollectionview{
    CGFloat tableHeight=FNDeviceHeight-SafeAreaTopHeight;
    CGFloat topInterval=SafeAreaTopHeight;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, topInterval, FNDeviceWidth, tableHeight) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    //self.jm_collectionview.hidden=YES;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNhairPacketSumDeCell class] forCellWithReuseIdentifier:@"FNhairPacketSumDeCellID"];
    [self.jm_collectionview registerClass:[FNredCarryOutNaCell class] forCellWithReuseIdentifier:@"FNredCarryOutNaCellID"];
    
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNreckDeHeaderViewID"];
    
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footNoViewID"];
    
    [self.jm_collectionview registerClass:[FNredPackageNaFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FNredPackageNaFooterID"];
    
    self.view.backgroundColor=RGB(246, 245, 245);
    self.jm_collectionview.backgroundColor=RGB(246, 245, 245);
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNRedPackageNaModel *itemModel=[FNRedPackageNaModel mj_objectWithKeyValues:self.dataArr[indexPath.section]];
    if(indexPath.section<self.dataArr.count-1){
        FNhairPacketSumDeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNhairPacketSumDeCellID" forIndexPath:indexPath];
        cell.model=itemModel;
        cell.delegate=self;
        cell.indexPath=indexPath;
        cell.backgroundColor =RGB(243, 243, 243);
        if(self.statePacket==1){
            if(indexPath.section<1){
                cell.compileText.keyboardType=UIKeyboardTypeDecimalPad;
            }else{
                cell.compileText.keyboardType=UIKeyboardTypeDefault;
            }
        }
        else{
            if(indexPath.section==0){
                cell.compileText.keyboardType=UIKeyboardTypeDecimalPad;
            }
            else if(indexPath.section==1){
                cell.compileText.keyboardType=UIKeyboardTypeNumberPad;
            }
            else{
                cell.compileText.keyboardType=UIKeyboardTypeDefault;
            }
        }
        return cell;
    }else{
        FNredCarryOutNaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNredCarryOutNaCellID" forIndexPath:indexPath];
        cell.model=itemModel;
        cell.backgroundColor =RGB(243, 243, 243);
        [cell.carryOutBtn addTarget:self action:@selector(carryOutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
   
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
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=FNDeviceWidth;
    CGFloat height=40;
    if(indexPath.section<self.dataArr.count-1){
        if(self.statePacket==1){
           height=55;
        }else{
           height=40;
        }
       
    }else{
        if(self.dataArr.count>3){
          height=FNDeviceHeight-SafeAreaTopHeight-35-240;
        }else{
          height=320;
        }
    }
    CGSize size = CGSizeMake(with, height);
    return size;
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    FNRedPackageNaModel *itemModel=[FNRedPackageNaModel mj_objectWithKeyValues:self.dataArr[indexPath.section]];
    if ( [kind isEqual: UICollectionElementKindSectionFooter] ) {
        if(indexPath.section<2){
            FNredPackageNaFooter *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FNredPackageNaFooterID" forIndexPath:indexPath];
            footView.stateInt=self.statePacket;
            footView.model=itemModel;
            footView.delegate=self;
            return footView;
        }
        UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footNoViewID" forIndexPath:indexPath];
        footView.backgroundColor=[UIColor whiteColor];
        return footView;
    }else{
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNreckDeHeaderViewID" forIndexPath:indexPath];
        headerView.backgroundColor=RGB(243, 243, 243);
        return headerView;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=0;
    if(section==0){
        hight=35;
    }else{
        hight=0;
    }
    return CGSizeMake(with,hight);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=0;
    if(section<2){
        if(self.statePacket==1){
            hight=0;
        }else{
            hight=40;
        }
    }else{
        hight=0;
    }
    return CGSizeMake(with,hight);
}
#pragma mark - FNhairPacketSumDeCellDelegate //编辑
- (void)inHairPacketCompileItemAction:(NSIndexPath*)indexPath withContent:(NSString*)content{
    //XYLog(@"content=:%@",content);
    FNhairPacketSumDeCell* cell = (FNhairPacketSumDeCell *)[self.jm_collectionview cellForItemAtIndexPath:indexPath];
    if(self.dataArr.count>0){
            FNRedPackageNaModel *itemModel=self.dataArr[indexPath.section];
            itemModel.sum=content;
            if(self.statePacket==1){
                if(indexPath.section==0){
                    FNRedPackageNaModel *lastModel=self.dataArr[2];
                    lastModel.sum=content;
                    [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:2]];
                }
            }
            if(self.statePacket==2){
                FNRedPackageNaModel *lastModel=self.dataArr[3];
                
                if(indexPath.section==0){
                    lastModel.sum=content;
                    [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:3]];
                }
                if(indexPath.section==1){
                    if([content kr_isNotEmpty]){
                       lastModel.num=content;
                    }
                   [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:3]];
                }
            }
    }
}
#pragma mark -FNredPackageNaFooterDelegate //发红包状态
- (void)inWithRedPacketState:(NSInteger)state{
    FNRedPackageNaModel *itemModel=self.dataArr[0];
    if(state==1){
       itemModel.amendState=@"1";
       itemModel.title=@"总金额";
    }else{
       itemModel.amendState=@"0";
       itemModel.title=@"单个金额";
    }
    [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:0]];
}
#pragma mark - //塞红包
-(void)carryOutBtnClick:(UIButton*)btn{
    XYLog(@"继续.");
    CGFloat sumFloat=0;
    if (self.payArr.count == 0) {
        [self requestPay];
        return;
    }
    if(self.statePacket==1){
        FNRedPackageNaModel *lastModel=self.dataArr[2];
        sumFloat= [lastModel.sum floatValue];
    }
    if(self.statePacket==2){
        FNRedPackageNaModel *lastModel=self.dataArr[3];
        sumFloat= [lastModel.sum floatValue];
        
        FNRedPackageNaModel *oneModel=self.dataArr[1];
        if (sumFloat < oneModel.sum.integerValue * 0.01) {
            [FNTipsView showTips:@"单个红包金额不得低于0.01元"];
            return;
        }
        if([oneModel.sum integerValue]==0){
            return;
        }
    }
    
    if(sumFloat>0){
        self.calendarView = [[FNwrapPayCeView alloc]init];
        self.calendarView.delegate=self;
        self.calendarView.sumLB.text=[NSString stringWithFormat:@"¥ %.2f",sumFloat];//@"¥ 28.00元";
        self.calendarView.headImg.image=IMAGE(Userhead_img);
        self.calendarView.dataArr=self.payArr;
        [[UIApplication sharedApplication].delegate.window addSubview:self.calendarView];
        [self.view endEditing:YES];
    }
}
#pragma mark - FNwrapPayCeViewDelegate
- (void)inBackPasswordString:(NSString*)content payModel:(NSString*)payString{
    //XYLog(@"content=:%@",content);
    //XYLog(@"payString=:%@",payString); 
    self.pay_type=payString;
    self.payPwd=[NSString md5:content];
    [self apiRequestEstablishRedPacket];
    //[self.payPasswordView didInputPasswordError];
}
//支付宝支付
//-(void)startBesidesPayment:(NSString*)codeString{
//    XYLog(@"BalanceoidString:%@",codeString);
//    [[AlipaySDK defaultService] payOrder:codeString fromScheme:AlisdkSchemes callback:^(NSDictionary *resultDic) {
//        XYLog(@"支付:%@",resultDic);
//        if ([NSString checkIsSuccess:resultDic[@"resultStatus"] andElement:@"9000"] ) {
//            [FNTipsView showTips:ResultStatusDict[@"9000"]];
//            //[FNChatManager.shareInstance sendMessage:self.hb_idElse toUid:self.uid withType:@"hongbao" andTarget:self.targetElse];
//            [FNChatManager.shareInstance sendMessage:self.hb_idElse toUid:self.uid withType:@"hongbao" andTarget:self.targetElse andMsgID:[NSString GetNowTimes]];
//            [self leftBtnAction];
//        }else{
//            [SVProgressHUD dismiss];
//            [FNTipsView showTips:ResultStatusDict[resultDic[@"resultStatus"] ] withDuration:2.0];
//        }
//    }];
//}
#pragma mark -刷新页面数据
-(void)dataArrUpdate{
    NSArray *arrOne=@[
                      @{@"title":@"单个金额",@"unit":@"元",@"remark":@"0.00",@"img":@"",@"sum":@"",@"carry":@"",@"btnImg":@"",@"hint":@"",@"amend":@"",@"alert":@"",@"num":@"0",@"statePacket":@"1"},
                      @{@"title":@"留言",@"unit":@"",@"remark":@"恭喜发财",@"img":@"",@"sum":@"",@"carry":@"",@"btnImg":@"",@"hint":@"",@"amend":@"",@"alert":@"",@"num":@"0",@"statePacket":@"1"},
                      @{@"title":@"",@"unit":@"",@"remark":@"",@"img":@"",@"sum":@"0.00",@"carry":@"塞钱进红包",@"btnImg":@"FN_fhBopaque_img",@"hint":@"",@"amend":@"",@"alert":@"",@"num":@"0",@"statePacket":@"1"}];
    NSArray *arrTwo=@[
                      @{@"title":@"单个金额",@"unit":@"元",@"remark":@"0.00",@"img":@"FN_hair_pinImg",@"sum":@"",@"carry":@"",@"btnImg":@"",@"hint":@"群里每个人收到固定金额,",@"amend":@"改为拼手气红包",@"amendState":@"0",@"num":@"0",@"statePacket":@"2"},
                      @{@"title":@"红包个数",@"unit":@"个",@"remark":@"填写个数",@"img":@"",@"sum":@"",@"carry":@"",@"btnImg":@"",@"hint":@"本群共695人",@"amend":@"",@"amendState":@"0",@"num":@"0",@"statePacket":@"2"},
                      @{@"title":@"留言",@"unit":@"",@"remark":@"恭喜发财,大吉大利",@"img":@"",@"sum":@"",@"carry":@"",@"btnImg":@"FN_fhBopaque_img",@"hint":@"本群共695人",@"amend":@"",@"alert":@"",@"amendState":@"0",@"num":@"0",@"statePacket":@"2"},
                      @{@"title":@"",@"unit":@"",@"remark":@"",@"img":@"",@"sum":@"0.00",@"carry":@"塞钱进红包",@"btnImg":@"FN_fhBopaque_img",@"hint":@"",@"amend":@"",@"alert":@"未领取的红包，将于24小时后发起退款",@"amendState":@"0",@"num":@"0",@"statePacket":@"2"}];
    [self.dataArr removeAllObjects];
    if(self.statePacket==1){
        for (NSDictionary *dictry in arrOne) {
            FNRedPackageNaModel *model=[FNRedPackageNaModel mj_objectWithKeyValues:dictry];
            [self.dataArr addObject:model];
        }
    }else{
        for (NSDictionary *dictry in arrTwo) {
            FNRedPackageNaModel *model=[FNRedPackageNaModel mj_objectWithKeyValues:dictry];
            [self.dataArr addObject:model];
        }
    }
    
}

#pragma mark - //创建红包
- (void)apiRequestEstablishRedPacket{
    FNRedPackageNaModel *oneModel=self.dataArr[0];
    FNRedPackageNaModel *twoModel=self.dataArr[1];
    FNRedPackageNaModel *threeModel=self.dataArr[2];
    //NSString *pay_type=@"";//支付类型 账号余额 money 支付宝 alipay
    //NSString *payPwd=@"";//如果支付类型是 money 需要输入支付密码
    NSString *money=oneModel.sum;//金额
    NSString *type=@"default";//红包类型 普通红包 default 手气红包 shouqi
    NSString *num=@"1";//发包数量
    NSString *room=self.room;//房间
    NSString *target=@"";//目标 人 ren 群 qun
    NSString *info=@"";//红包祝福语 如: 大吉大利
    if(self.statePacket==1){
        type=@"default";
        num=@"1";
        target=@"ren";
        info=twoModel.sum;
        if(![twoModel.sum kr_isNotEmpty]){
             info=twoModel.remark;
        }
    }
    if(self.statePacket==2){
        type=@"shouqi";
        if([oneModel.amendState integerValue]==1){
           type=@"shouqi";
        }else{
           type=@"default";
        }
        num=[NSString stringWithFormat:@"%@",twoModel.sum];
        target=@"qun";
        info=threeModel.sum;
        if(![threeModel.sum kr_isNotEmpty]){
            info=threeModel.remark;
        }
    }
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,@"pay_type":self.pay_type,@"payPwd":self.payPwd,@"money":money,@"type":type,@"num":num,@"room":room,@"target":target,@"info":info}];
    @weakify(self)
    [FNChatManager.shareInstance sendGiveRedEnvelopesDictry:params paymodel:self.pay_type toUid:self.uid withTarget:target redpackBlock:^(FNChatModel * _Nonnull chat, NSString * _Nonnull msg) {
        
        @strongify(self)
        if([msg isEqualToString:@"成功"]){
            [self.calendarView dismissAlert];
            [self leftBtnAction];
            if ([self.delegate respondsToSelector:@selector(didRedPackCreate:)]) {
                [self.delegate didRedPackCreate:chat];
            }
        }else{
            [self.calendarView.payPasswordView didInputPasswordError];
            [FNTipsView showTips:msg];
            
            if ([msg isEqualToString:@"支付密码未设置"]) {
                [self.calendarView dismissAlert];
                ModifyPaymentPasswordController *vc = [[ModifyPaymentPasswordController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }]; 
    
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(NSMutableArray *)payArr{
    if (!_payArr) {
        _payArr = [NSMutableArray array];
    }
    return _payArr;
}

@end
