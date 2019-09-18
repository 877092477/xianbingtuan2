//
//  FNdistrictTurnController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/6.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdistrictTurnController.h"
#import "FNCustomeNavigationBar.h"
#import "FNdistrictPhoneCell.h"
#import "FNdistrictTurnCompileCell.h"
#import "FNdistrictPeopleMsgCell.h"
#import "FNConvertHintfeCell.h"
#import "FNConvertVerifyfeCell.h"
#import "FNdistrictTurnModel.h"
#import "FNrushPhoneListDeController.h"
@interface FNdistrictTurnController ()<UICollectionViewDelegate,UICollectionViewDataSource,FNdistrictTurnCompileCellDelegate,FNrushPhoneListDeControllerDelegate,UITextFieldDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIButton *rightBtn;

@property (nonatomic, strong)FNdistrictTurnModel *dataModel;
@property (nonatomic, strong)NSMutableArray *hintArr;
@property (nonatomic, strong)NSMutableArray *peopleArr;
@property (nonatomic, strong)NSString  *phoneStr;
@property (nonatomic, strong)NSString  *qkbCount;
@end

@implementation FNdistrictTurnController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([NSString isEmpty:UserAccessToken]) {
        [self warnToLogin];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.phoneStr=@"";
}
#pragma mark - set top views
- (void)setTopViews{
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.size = CGSizeMake(50, 30);
    self.navigationView.leftButton = self.leftBtn;
//    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [self.rightBtn setTitle:@"规则" forState:UIControlStateNormal];
//    self.rightBtn.titleLabel.font=[UIFont systemFontOfSize:15];
//    [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.rightBtn addTarget:self action:@selector(rightButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.rightBtn sizeToFit];
//    self.rightBtn.size = CGSizeMake(self.rightBtn.width+10, self.rightBtn.height+10);
//    self.navigationView.rightButton = self.rightBtn;
    [self.view addSubview:self.navigationView];
    [self.view bringSubviewToFront:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 18);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:18];
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    self.navigationView.titleLabel.text=self.keyWord?self.keyWord:@"转账";
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.leftBtn.imageView.sd_layout
    .centerYEqualToView(self.leftBtn).widthIs(8).heightIs(16).leftSpaceToView(self.leftBtn, 10);
    if(self.understand==YES){
        self.leftBtn.hidden=YES;
    }
}
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightButtonAction{
    //    NSString *urljoint=self.dataModel.explain_url;
    //    if([urljoint kr_isNotEmpty]){
    //        [self goWebWithUrl:urljoint];
    //    }
}
#pragma mark - set up views
- (void)jm_setupViews{
    self.view.backgroundColor=RGB(250, 250, 250);
    CGFloat baseGap=0;
    if(self.understand==YES){
        baseGap=XYTabBarHeight;
    }
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, FNDeviceHeight-baseGap-SafeAreaTopHeight) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=RGB(250, 250, 250);
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.jm_collectionview registerClass:[FNdistrictPhoneCell class] forCellWithReuseIdentifier:@"FNdistrictPhoneCellID"];
    [self.jm_collectionview registerClass:[FNdistrictTurnCompileCell class] forCellWithReuseIdentifier:@"FNdistrictTurnCompileCellID"];
    [self.jm_collectionview registerClass:[FNdistrictPeopleMsgCell class] forCellWithReuseIdentifier:@"FNdistrictPeopleMsgCellID"];
    [self.jm_collectionview registerClass:[FNConvertHintfeCell class] forCellWithReuseIdentifier:@"FNConvertHintfeCellID"];
    [self.jm_collectionview registerClass:[FNConvertVerifyfeCell class] forCellWithReuseIdentifier:@"FNConvertVerifyfeCellID"];
    [self setTopViews];
    
    if([UserAccessToken kr_isNotEmpty]){
        [self requestTurnMsg];
    }
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0){
        return 1;
    }else if(section==1){
        return self.peopleArr.count;
    }
    else if(section==2){
        return 1;
    }else if(section==3){
        return self.hintArr.count;
    }else {
        return 1;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==0){
        FNdistrictPhoneCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNdistrictPhoneCellID" forIndexPath:indexPath]; 
        if([self.dataModel.qkb_zz_phone_tips kr_isNotEmpty]){
           cell.leftField.placeholder=self.dataModel.qkb_zz_phone_tips;
        }
        [cell.rightBtn sd_setImageWithURL:URL(self.dataModel.qkb_phone_icon) forState:UIControlStateNormal];
        [cell.rightBtn addTarget:self action:@selector(selectContactClick)];
        [cell.leftField addTarget:self action:@selector(phoneFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        cell.leftField.text=self.phoneStr;
        cell.leftField.textColor=[UIColor colorWithHexString:self.dataModel.qkb_page_color];
        return cell;
    }
    else if(indexPath.section==1){
        FNdistrictPeopleMsgCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNdistrictPeopleMsgCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        FNdistrictTurnPeopleModel *model=self.peopleArr[indexPath.row];
        [cell.headImg setUrlImg:model.head_img];
        cell.nameLB.text=[NSString stringWithFormat:@"用户: %@",model.nickname];
        cell.phoneNumLB.text=[NSString stringWithFormat:@"手机: %@",model.phone];
        return cell;
    }
    else if(indexPath.section==2){
        FNdistrictTurnCompileCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNdistrictTurnCompileCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.titleLB.text=self.dataModel.qkb_cbsm;
        cell.numLB.text=self.dataModel.qkb_count;
        if([self.dataModel.qkb_cbsm kr_isNotEmpty]){
           cell.numTitleLB.text=@"转账数量";
        }
        cell.compileField.placeholder=self.dataModel.qkb_zzsl_tips;
        cell.compileField.textColor=[UIColor colorWithHexString:self.dataModel.qkb_page_color];
        cell.compileField.delegate=self;
        cell.index=indexPath;
        cell.delegate=self;
        if([self.dataModel.compute_type isEqualToString:@"int"]){
            cell.compileField.keyboardType = UIKeyboardTypePhonePad;
        }
        if([self.dataModel.compute_type isEqualToString:@"float2"]||[self.dataModel.compute_type isEqualToString:@"float3"]){
            cell.compileField.keyboardType = UIKeyboardTypeDecimalPad;
        }
        return cell;
    }
    else if(indexPath.section==3){
        FNConvertHintfeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNConvertHintfeCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        if(self.hintArr.count>0){
            cell.titleLB.text=self.hintArr[0];
        }
        return cell;
    }
    else{
        FNConvertVerifyfeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNConvertVerifyfeCellID" forIndexPath:indexPath];
        cell.backgroundColor=RGB(250, 250, 250);
        [cell.verifyBtn setTitle:self.dataModel.qkb_zzsl_btn forState:UIControlStateNormal];
        [cell.verifyBtn addTarget:self action:@selector(verifyBtnAction)];
        if(self.hintArr.count>0 && [self.phoneStr kr_isPhoneNumber]){
            [cell.verifyBtn sd_setBackgroundImageWithURL:URL(self.dataModel.qkb_qr_check_btn) forState:UIControlStateNormal];
            if([self.dataModel.qkb_qr_check_fcolor kr_isNotEmpty]){
               [cell.verifyBtn setTitleColor:[UIColor colorWithHexString:self.dataModel.qkb_qr_check_fcolor] forState:UIControlStateNormal];
            }else{
                [cell.verifyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }else{
            [cell.verifyBtn sd_setBackgroundImageWithURL:URL(self.dataModel.qkb_qr_btn) forState:UIControlStateNormal];
            if([self.dataModel.qkb_qr_fcolor kr_isNotEmpty]){
                 [cell.verifyBtn setTitleColor:[UIColor colorWithHexString:self.dataModel.qkb_qr_fcolor] forState:UIControlStateNormal];
            }else{
                [cell.verifyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height=175;
    CGFloat with= FNDeviceWidth;
    if(indexPath.section==0){
        height=73;
    }else if(indexPath.section==1){
        height=123;
    }
    else if(indexPath.section==2){
        height=183;
    }
    else if(indexPath.section==3){
        height=40;
    }
    else{
        height=100;
    }
    CGSize  size= CGSizeMake(with, height);
    return  size;
    
}
#pragma mark - 编辑电话号吗
- (void)phoneFieldDidChange:(id)sender{
    UITextField *field = (UITextField *)sender;
    self.phoneStr=field.text;
    if([field.text kr_isPhoneNumber]){
        [self requestUpTurnUser];
    }else{
        [self.peopleArr removeAllObjects];
        [UIView performWithoutAnimation:^{
            [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:1]];
            [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:4]];
        }];
    } 
}
-(void)selectContactClick{
    FNrushPhoneListDeController *vc=[[FNrushPhoneListDeController alloc]init];
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - FNrushPhoneListDeControllerDelegate //选择电话
-(void)inSelectPhoneAction:(NSString*)send{
    XYLog(@"send=%@",send);
    if([send kr_isNotEmpty]){
        self.phoneStr=send;
        [self requestUpTurnUser];
        [UIView performWithoutAnimation:^{
            [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:0]]; 
        }];
    }
}
#pragma mark - 确认
-(void)verifyBtnAction{
    //CGFloat max_count=[self.dataModel.max_count floatValue];
    //CGFloat qkb_count=[self.qkbCount floatValue];
    if(![self.phoneStr kr_isPhoneNumber]){
       [FNTipsView showTips:@"请输入正确的电话号码"];
    }else if(![self.qkbCount kr_isNotEmpty]){
        [FNTipsView showTips:@"请完善信息"];
    }else{
        CGFloat qkbcountFloat=[self.qkbCount floatValue];
        if(qkbcountFloat==0 || qkbcountFloat<0){
            [FNTipsView showTips:@"请输入正确的信息"];
            return;
        }
//        if([self.dataModel.max_count kr_isNotEmpty]){
//            if(qkb_count>max_count){
//                NSString *maxString=[NSString stringWithFormat:@"最多兑换%@",self.dataModel.max_count];
//                [FNTipsView showTips:@"超出最大数值"];
//                return;
//            }
        
//        }
        [self requestTurnRes];
    }
}
#pragma mark - FNdistrictTurnCompileCellDelegate // 编辑 
- (void)didTurnCompileAction:(NSIndexPath*)index withContent:(NSString*)content{
    NSString *serveStr=@"";
    CGFloat contentFloat=[content floatValue];
    CGFloat sxf=[self.dataModel.qkb_zzsxf floatValue];
    CGFloat serveFloat=contentFloat*sxf;
    NSArray *array = [self.dataModel.qkb_sxfsm_zz componentsSeparatedByString:@"$"];
    if(array.count>1){
       serveStr=[NSString stringWithFormat:@"%@%.2f%@",array[0],serveFloat,array[1]];
    }
    [self.hintArr removeAllObjects];
    NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
    [arrM addObject:serveStr];
    self.hintArr=arrM;
    if(![content kr_isNotEmpty]){
        [self.hintArr removeAllObjects];
    }
    [UIView performWithoutAnimation:^{
        [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:3]];
        [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:4]];
    }];
    
    self.qkbCount=content;
}
#pragma mark - //  转账页面
-(FNRequestTool*)requestTurnMsg{
    //@weakify(self);
    @WeakObj(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=qkb&ctrl=zhuanzhang" respondType:(ResponseTypeModel) modelType:@"FNdistrictTurnModel" success:^(id respondsObject) {
        //@strongify(self);//FNdistrictTurnModel
        XYLog(@"respondsObject:%@",respondsObject);
        selfWeak.dataModel=respondsObject;
        [selfWeak.jm_collectionview reloadData];
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
#pragma mark - //  根据手机号查找用户
-(void)requestUpTurnUser{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    //[self.hintArr removeAllObjects];
    if([self.phoneStr kr_isNotEmpty]){
        params[@"phone"]=self.phoneStr;
    }else{
        return ;
    }
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=qkb&ctrl=select_user" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        [self.peopleArr removeAllObjects];
        
        NSDictionary *dictry=respondsObject[DataKey];
        //NSString *msg=respondsObject[MsgKey];
        NSInteger successInt=[respondsObject[SuccessKey] integerValue];
        FNdistrictTurnPeopleModel *model=[FNdistrictTurnPeopleModel mj_objectWithKeyValues:dictry];
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        [arrM addObject:model];
        self.peopleArr=arrM;
        if(successInt==1){
            if(arrM.count>0){
                [UIView performWithoutAnimation:^{
                    [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:1]];
                }];
            }
        }else{
            //[FNTipsView showTips:msg];
        }
    } failure:^(NSString *error) {
        
    } isHideTips:NO];
}
#pragma mark - //  转账
-(void)requestTurnRes{
    @weakify(self);
   
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.phoneStr kr_isNotEmpty]){
        params[@"phone"]=self.phoneStr;
    }
    if([self.qkbCount kr_isNotEmpty]){
        params[@"qkb_count"]=self.qkbCount;
    }
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=qkb_transaction&ctrl=transfer" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        XYLog(@"转账结果:%@",respondsObject);
        NSInteger successInt=[respondsObject[SuccessKey] integerValue];
        if(successInt==1){
            [FNTipsView showTips:@"转账成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{ 
            [FNTipsView showTips:@"转账失败"];
        }
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES isCache:NO];
}

- (NSMutableArray *)hintArr{
    if (!_hintArr) {
        _hintArr = [NSMutableArray array];
    }
    return _hintArr;
}
- (NSMutableArray *)peopleArr{
    if (!_peopleArr) {
        _peopleArr = [NSMutableArray array];
    }
    return _peopleArr;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //限制只能输入数字
    BOOL isHaveDian = YES;
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        isHaveDian = NO;
    }
    if ([string length] > 0) {
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if([self.dataModel.compute_type isEqualToString:@"int"]){
            if (single == '.') {
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
        if ((single >= '0' && single <= '9') || single == '.') {
            //数据格式正确
            if([textField.text length] == 0){
                if(single == '.') {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            //输入的字符是否是小数点
            if (single == '.') {
                if(!isHaveDian) {
                    //text中还没有小数点
                    isHaveDian = YES;
                    return YES;
                }else{
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }else{
                //存在小数点
                if (isHaveDian) {
                    //判断小数点的位数
                    NSRange ran = [textField.text rangeOfString:@"."];
                    if (range.location - ran.location <= 2) {
                        return YES;
                    }else{
                        return NO;
                    }
                }else{
                    return YES;
                }
            }
        }else{
            //输入的数据格式不正确
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else
    {
        return YES;
    } 
    
    return YES;
}
@end
