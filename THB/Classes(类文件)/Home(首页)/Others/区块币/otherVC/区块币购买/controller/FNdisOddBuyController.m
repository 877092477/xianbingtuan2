//
//  FNdisOddBuyController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdisOddBuyController.h"
#import "FNCustomeNavigationBar.h"
#import "FNConvertHintfeCell.h"
#import "FNConvertVerifyfeCell.h"
#import "FNdisOddBuyheadMsgCell.h"
#import "FNdisOddBuyCompileCell.h"
#import "FNdisOddBuyResEditHView.h"

#import "FNdisOddBuyDetailModel.h"
@interface FNdisOddBuyController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)FNdisOddBuyDetailModel *dataModel; 
@property (nonatomic, strong)NSMutableArray *hintArr;
@property (nonatomic, strong)NSString *qkb_count;
@property (nonatomic, strong)NSString *soleStr;
@property (nonatomic, strong)NSString *price;
@property (nonatomic, strong)NSString *sxf;
@property (nonatomic, strong)NSString *has_min_sxf;
@end

@implementation FNdisOddBuyController
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
    self.has_min_sxf=@"0";
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
    self.navigationView.titleLabel.text=self.keyWord?self.keyWord:@"购买";
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.leftBtn.imageView.sd_layout
    .centerYEqualToView(self.leftBtn).widthIs(8).heightIs(16).leftSpaceToView(self.leftBtn, 10);
     
}
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - set up views
- (void)jm_setupViews{
    self.view.backgroundColor=RGB(250, 250, 250);
   
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+1, FNDeviceWidth, FNDeviceHeight-SafeAreaTopHeight-1) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=RGB(250, 250, 250);
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNdisOddBuyheadMsgCell class] forCellWithReuseIdentifier:@"FNdisOddBuyheadMsgCellID"];
    [self.jm_collectionview registerClass:[FNdisOddBuyCompileCell class] forCellWithReuseIdentifier:@"FNdisOddBuyCompileCellID"];
    [self.jm_collectionview registerClass:[FNConvertHintfeCell class] forCellWithReuseIdentifier:@"FNConvertHintfeCellID"];
    [self.jm_collectionview registerClass:[FNConvertVerifyfeCell class] forCellWithReuseIdentifier:@"FNConvertVerifyfeCellID"];
    [self.jm_collectionview registerClass:[FNdisOddBuyResEditHView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNdisOddBuyResEditHViewID"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView1"];
    [self setTopViews];
    self.jm_collectionview.hidden=YES;
    if([UserAccessToken kr_isNotEmpty]){
        if([self.oid kr_isNotEmpty]){
           [self requestOrderDetail];
        }
    }
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0){
        return 1;
    }else if(section==1){
        return 2;
    }
    else if(section==2){
        return self.hintArr.count;
    }else {
        return 1;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==0){
        FNdisOddBuyheadMsgCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNdisOddBuyheadMsgCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        [cell.headImg setUrlImg:self.dataModel.head_img];
        cell.nameLB.text=[NSString stringWithFormat:@"用户名: %@",self.dataModel.nickname];
        cell.phoneLB.text=[NSString stringWithFormat:@"手机: %@",self.dataModel.phone];
        return cell;
    }else if(indexPath.section==1){
        FNdisOddBuyCompileCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNdisOddBuyCompileCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        if(indexPath.row==0){
           cell.titleLB.text=self.dataModel.wroth_tips;
           cell.compileField.enabled=NO;
           cell.rightBtn.hidden=YES;
           cell.compileField.text=self.dataModel.wroth;
           cell.compileField.textColor=RGB(51, 51, 51);
        }
        if(indexPath.row==1){
           cell.titleLB.text=self.dataModel.qkb_counts;
           cell.compileField.enabled=YES;
           cell.compileField.delegate=self;
           cell.compileField.placeholder=self.dataModel.qkb_counts_tip;
           cell.rightBtn.hidden=NO;
           [cell.rightBtn setTitle:self.dataModel.qkb_counts_btn forState:UIControlStateNormal];
           [cell.rightBtn setTitleColor:[UIColor colorWithHexString:self.dataModel.color] forState:UIControlStateNormal];
           [cell.compileField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            if([self.dataModel.compute_type isEqualToString:@"int"]){
                cell.compileField.keyboardType = UIKeyboardTypePhonePad;
            }
            if([self.dataModel.compute_type isEqualToString:@"float2"]){
                cell.compileField.keyboardType = UIKeyboardTypeDecimalPad;
            }
            [cell.rightBtn addTarget:self action:@selector(allClick)];
            cell.compileField.textColor=[UIColor colorWithHexString:self.dataModel.color];
        }
        return cell;
    }else if(indexPath.section==2){
        FNConvertHintfeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNConvertHintfeCellID" forIndexPath:indexPath];
        
        if(self.hintArr.count>0){
            cell.titleLB.text=self.hintArr[0];
            if([self.hintArr[0] kr_isNotEmpty]){
               cell.backgroundColor=[UIColor whiteColor];
               cell.lineView.backgroundColor=RGB(240, 240, 240);
            }else{
                cell.backgroundColor=RGB(250, 250, 250);
                cell.lineView.backgroundColor=RGB(250, 250, 250);
            }
        }
        return cell;
    }else{
        FNConvertVerifyfeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNConvertVerifyfeCellID" forIndexPath:indexPath];
        [cell.verifyBtn setTitle:self.dataModel.btn_font forState:UIControlStateNormal];
        if(self.hintArr.count>0){
            [cell.verifyBtn sd_setBackgroundImageWithURL:URL(self.dataModel.qkb_jyqr_check_btn) forState:UIControlStateNormal];
            [cell.verifyBtn setTitleColor:[UIColor colorWithHexString:self.dataModel.qkb_qr_check_fcolor] forState:UIControlStateNormal];
            [cell.verifyBtn addTarget:self action:@selector(verifyBtnAction)]; 
            
        }else{
            [cell.verifyBtn sd_setBackgroundImageWithURL:URL(self.dataModel.qkb_jyqr_btn) forState:UIControlStateNormal];
            [cell.verifyBtn setTitleColor:[UIColor colorWithHexString:self.dataModel.qkb_qr_fcolor] forState:UIControlStateNormal];
        }
        return cell;
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height=0;
    CGFloat with= FNDeviceWidth;
    if(indexPath.section==0){
        height=95;
    }else if(indexPath.section==1){
        height=50;
    }
    else if(indexPath.section==2){
        height=40;
    }
    else{
        height=100;
    }
    CGSize  size= CGSizeMake(with, height);
    return  size;
    
}
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==2){
        FNdisOddBuyResEditHView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNdisOddBuyResEditHViewID" forIndexPath:indexPath];
        headerView.backgroundColor=[UIColor whiteColor];
        headerView.titleLB.text=self.dataModel.price_title;
        if(self.hintArr.count>0){
            headerView.resultLB.text=self.soleStr;
            headerView.resultLB.textColor=[UIColor colorWithHexString:self.dataModel.color];
        }else{
            headerView.resultLB.text=self.dataModel.price_tips;
            headerView.resultLB.textColor=RGB(201, 201, 201);
        }
        return headerView;
    }else{
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView1" forIndexPath:indexPath];
        
        return headerView;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=45;
    if(section==2){
        hight=50;
    }else{
        hight=0;
    }
    return CGSizeMake(with,hight);
}
#pragma mark - //编辑
- (void)textFieldDidChange:(id)sender{
    UITextField *field = (UITextField *)sender;
    //field.text
    NSString *content=field.text;
    self.qkb_count=content;
    [self inDisCompileWithString:content];
}
#pragma mark - //全选
-(void)allClick{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1  inSection:1];
    FNdisOddBuyCompileCell* cell = (FNdisOddBuyCompileCell *)[self.jm_collectionview cellForItemAtIndexPath:indexPath];
    cell.compileField.text=self.dataModel.max_count;
//    CGFloat max_count=[self.dataModel.max_count floatValue];
//    CGFloat user_qkb=[self.dataModel.user_qkb floatValue];
//    if(user_qkb>max_count){
//       NSString *maxString=[NSString stringWithFormat:@"最多兑换%@",self.dataModel.max_count];
//       [FNTipsView showTips:maxString];
//    }
//    else if(user_qkb==0){
//
//    }
//    else{
//        NSString *content=self.dataModel.user_qkb;
//        [self inDisCompileWithString:content];
//    }
    
    
        NSString *content=self.dataModel.max_count;
        [self inDisCompileWithString:content];
    
}
//编辑
-(void)inDisCompileWithString:(NSString*)content{
    self.qkb_count=content;
    NSString *serveStr=@"";
    CGFloat contentFloat=[content floatValue];
    CGFloat bili=[self.dataModel.bili floatValue];
    CGFloat sxfFloat=[self.dataModel.sxf floatValue];
    CGFloat valueFloat=contentFloat*bili;
    CGFloat serveFloat=valueFloat*sxfFloat;
    serveFloat=contentFloat/(1-sxfFloat)*sxfFloat;
    self.soleStr=[NSString stringWithFormat:@"%.2f",valueFloat];
    NSArray *array = [self.dataModel.sxf_detail componentsSeparatedByString:@"$"];
    if(array.count>1){
        if([self.keyWord isEqualToString:@"出售"]){
           serveStr=[NSString stringWithFormat:@"%@%.4f%@",array[0],serveFloat,array[1]];
        }
    }
    NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
    [arrM addObject:serveStr];
    self.hintArr=arrM;
    if(![content kr_isNotEmpty]){
        [self.hintArr removeAllObjects];
    }
    [UIView performWithoutAnimation:^{
        [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:2]];
        [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:3]];
    }];
    if(serveFloat<0.01){
       serveFloat=0.01;
       self.has_min_sxf=@"0.01";
    }
    
    self.sxf=[NSString stringWithFormat:@"%.4f",serveFloat];
    self.price=[NSString stringWithFormat:@"%.2f",valueFloat];
}
#pragma mark - //确认
-(void)verifyBtnAction{
    CGFloat qkbcountFloat=[self.qkb_count floatValue];
    if(qkbcountFloat==0 || qkbcountFloat<0){
        [FNTipsView showTips:@"请输入正确的信息"];
        return;
    }
    else if([self.dataModel.transaction_mode kr_isNotEmpty]){
         if([self.dataModel.transaction_mode isEqualToString:@"all"]){
             if(qkbcountFloat!=[self.dataModel.max_count floatValue]){
                [FNTipsView showTips:[NSString stringWithFormat:@"单次交易数量是%@",self.dataModel.max_count]];
                return;
             }
        }
    }
//    CGFloat max_count=[self.dataModel.max_count floatValue];
//    CGFloat qkbcount=[self.qkb_count floatValue];
//    if(qkbcount>max_count){
//        [FNTipsView showTips:@"超出最大数值"];
//        return;
//    }else{
        [self requestTransaction];
//    }
}
#pragma mark - //  交易详细页面
-(FNRequestTool*)requestOrderDetail{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.oid kr_isNotEmpty]){
        params[@"oid"]=self.oid;
    }
    
    if([self.keyWord isEqualToString:@"购买"]){
        params[@"deduct_qkb"]=@"0";
    }
    if([self.keyWord isEqualToString:@"出售"]){
        params[@"deduct_qkb"]=@"1";
    }
    
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=qkb&ctrl=order_detail" respondType:(ResponseTypeModel) modelType:@"FNdisOddBuyDetailModel" success:^(id respondsObject) {
        @strongify(self);
        self.dataModel=respondsObject;
        self.jm_collectionview.hidden=NO;
        [self.jm_collectionview reloadData];  
    } failure:^(NSString *error) { 
    } isHideTips:YES];
}
#pragma mark - //委托单交易接口
-(FNRequestTool*)requestTransaction{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    
    if([self.oid kr_isNotEmpty]){
        params[@"oid"]=self.oid;
    }
    if([self.type kr_isNotEmpty]){
        params[@"type"]=self.type;
    }
    if([self.qkb_count kr_isNotEmpty]){
        params[@"qkb_count"]=self.qkb_count;
    }
    if([self.price kr_isNotEmpty]){
        params[@"price"]=self.price;
    }
    if([self.sxf kr_isNotEmpty]){
        if([self.keyWord isEqualToString:@"购买"]){
            params[@"sxf"]=@"";
        }
        if([self.keyWord isEqualToString:@"出售"]){
            params[@"sxf"]=self.sxf;
        }
    }
    params[@"has_min_sxf"]=self.has_min_sxf;
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=qkb_transaction&ctrl=new_transaction" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        //NSDictionary* dict = respondsObject[DataKey];
        @strongify(self);
        NSInteger state=[respondsObject[SuccessKey] integerValue];
        NSString *msgStr=respondsObject[MsgKey];
        if(state==1){
           [FNTipsView showTips:msgStr];
           [FNNotificationCenter postNotificationName:@"FBupdateNOIsCache" object:nil];
           [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSString *error) {
        
    } isHideTips:NO];
}
- (NSMutableArray *)hintArr{
    if (!_hintArr) {
        _hintArr = [NSMutableArray array];
    }
    return _hintArr;
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
