//
//  FNdisOddLaunchController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdisOddLaunchController.h"
#import "FNCustomeNavigationBar.h"
#import "JXCategoryView.h"
#import "FNdisOddLaunchModel.h"

#import "FNdisOddLaunchHeadView.h"
#import "FNdisOddBuyResEditHView.h"

#import "FNdisOddLaunchStyleHCell.h"
#import "FNdisOddBuyCompileCell.h"
#import "FNConvertHintfeCell.h"
#import "FNConvertVerifyfeCell.h"

@interface FNdisOddLaunchController ()<UICollectionViewDelegate,UICollectionViewDataSource,JXCategoryViewDelegate,FNdisOddLaunchStyleViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)JXCategoryTitleView *categoryView;
@property (nonatomic, strong)JXCategoryIndicatorLineView *lineView;
@property (nonatomic, strong)NSMutableArray *typeArr;
@property (nonatomic, strong)FNdisOddLaunchModel *dataModel;
@property (nonatomic, strong)NSString *price_tips;
@property (nonatomic, strong)NSMutableArray *hintArr;


@property (nonatomic, strong)NSString *styleType;
@property (nonatomic, strong)NSString *wroth;
@property (nonatomic, strong)NSString *average_price;
@property (nonatomic, strong)NSString *qkb_count;
@property (nonatomic, strong)NSString *price;
@property (nonatomic, strong)NSString *sxf;

@property (nonatomic, strong)NSString *biliStr;
@property (nonatomic, strong)NSString *sxfStr;
@property (nonatomic, strong)NSString *sxf_tips;
@property (nonatomic, strong)NSString *soleStr;
@property (nonatomic, assign)NSInteger editState;
@property (nonatomic, strong)NSString *deduct_qkb;
@end

@implementation FNdisOddLaunchController
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
    self.price_tips=@"";
    self.soleStr=@"0";
    self.deduct_qkb=@"0";
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
    self.navigationView.titleLabel.text=self.keyWord?self.keyWord:@"发布委托单";
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.leftBtn.imageView.sd_layout
    .centerYEqualToView(self.leftBtn).widthIs(8).heightIs(16).leftSpaceToView(self.leftBtn, 10);
}
-(void)leftBtnAction{
    if ([self.delegate respondsToSelector:@selector(didOddLaunchStateAction:)]) {
        [self.delegate didOddLaunchStateAction:self.index];
    }
    [FNNotificationCenter postNotificationName:@"FBupdateNOIsCache" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 兑换类型
-(void)cateTopView{
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+1, FNDeviceWidth, 44)];
    self.categoryView.delegate = self;
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.backgroundColor=[UIColor whiteColor];
    //lineView
    self.lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.lineView.indicatorWidth = 40;//JXCategoryViewAutomaticDimension;
    //line颜色
    self.lineView.indicatorColor=RGB(251, 155, 31);
    self.lineView.indicatorHeight=2;
    self.categoryView.indicators = @[self.lineView];
    [self.view addSubview:self.categoryView];
}
#pragma mark - 点击兑换类型
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    XYLog(@"选择%ld",(long)index);
    FNdisOddLaunchTypeItemModel *model=self.typeArr[index];
    //self.price_tips=model.price_tips;
    self.type=model.type;
    if([self.type kr_isNotEmpty]){
        [self requestOrder];
    }
}
#pragma mark - set up views
- (void)jm_setupViews{
    self.view.backgroundColor=RGB(250, 250, 250);
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0; 
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+45, FNDeviceWidth, FNDeviceHeight-SafeAreaTopHeight-45) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=RGB(250, 250, 250);
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[FNdisOddLaunchStyleHCell class] forCellWithReuseIdentifier:@"FNdisOddLaunchStyleHCellID"];
    [self.jm_collectionview registerClass:[FNdisOddBuyCompileCell class] forCellWithReuseIdentifier:@"FNdisOddBuyCompileCellID"];
    [self.jm_collectionview registerClass:[FNConvertHintfeCell class] forCellWithReuseIdentifier:@"FNConvertHintfeCellID"];
    [self.jm_collectionview registerClass:[FNConvertVerifyfeCell class] forCellWithReuseIdentifier:@"FNConvertVerifyfeCellID"];
    [self.jm_collectionview registerClass:[FNdisOddLaunchHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNdisOddLaunchHeadViewID"];
    [self.jm_collectionview registerClass:[FNdisOddBuyResEditHView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNdisOddBuyResEditHViewID"];
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView1"];
    
    [self setTopViews];
    [self cateTopView];
    if([UserAccessToken kr_isNotEmpty]){
        [self requestOrderType];
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
        return 2;
    }
    else if(section==2){
        return 1; 
    }
    else if(section==3){
        return self.hintArr.count;
    }
    else {
        return 1;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==0){
        FNdisOddLaunchStyleHCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNdisOddLaunchStyleHCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.titleLB.text=self.dataModel.mode_tips;
        cell.model=self.dataModel;
        cell.styleView.delegate=self;
        return cell;
    }
    else if(indexPath.section==1){
        FNdisOddBuyCompileCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNdisOddBuyCompileCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.titleLB.textColor=RGB(51, 51, 51);
        if(indexPath.row==0){
            cell.titleLB.text=self.dataModel.djfs_tips;
            cell.compileField.enabled=NO;
            cell.compileField.text=self.dataModel.djfs;
            cell.compileField.textColor=RGB(51, 51, 51);
            cell.rightBtn.hidden=YES;
            cell.line.hidden=NO;
        }
        else if(indexPath.row==1){
            cell.titleLB.text=self.dataModel.yjjg_tips;
            cell.compileField.text=@"";
            cell.compileField.enabled=YES;
            cell.compileField.placeholder=self.dataModel.yjjg;
            cell.compileField.textColor=[UIColor colorWithHexString:self.dataModel.page_color];
            cell.rightBtn.hidden=YES;
            cell.line.hidden=YES;
            [cell.compileField addTarget:self action:@selector(textFieldDidChangeOne:) forControlEvents:UIControlEventEditingChanged];
            cell.compileField.keyboardType = UIKeyboardTypeDecimalPad;
            cell.compileField.delegate=self;
        }
        return cell;
    }
    else if(indexPath.section==2){
        FNdisOddBuyCompileCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNdisOddBuyCompileCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.titleLB.textColor=RGB(51, 51, 51);
        cell.titleLB.text=self.dataModel.number_tips;
        cell.rightBtn.hidden=YES;
        cell.compileField.enabled=YES;
        cell.compileField.text=@"";
        cell.compileField.placeholder=self.dataModel.number;
        cell.compileField.textColor=[UIColor colorWithHexString:self.dataModel.page_color];
        cell.line.hidden=NO;
        [cell.compileField addTarget:self action:@selector(textFieldDidChangeTwo:) forControlEvents:UIControlEventEditingChanged];
        cell.compileField.keyboardType = UIKeyboardTypePhonePad;
        cell.compileField.delegate=self;
        return cell;
    }
    else if(indexPath.section==3){
        FNConvertHintfeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNConvertHintfeCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
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
    }
    else{
        FNConvertVerifyfeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNConvertVerifyfeCellID" forIndexPath:indexPath];
        [cell.verifyBtn setTitle:self.dataModel.btn_font forState:UIControlStateNormal];
        if(self.hintArr.count>0){
            [cell.verifyBtn sd_setBackgroundImageWithURL:URL(self.dataModel.qkb_jyqr_check_btn) forState:UIControlStateNormal];
            [cell.verifyBtn setTitleColor:[UIColor colorWithHexString:self.dataModel.qkb_qr_check_fcolor] forState:UIControlStateNormal];
            [cell.verifyBtn addTarget:self action:@selector(verifyBtnAction)];
        }else{
            [cell.verifyBtn sd_setBackgroundImageWithURL:URL(self.dataModel.qkb_jyqr_btn) forState:UIControlStateNormal];
            [cell.verifyBtn setTitleColor:[UIColor colorWithHexString:self.dataModel.qkb_qr_fcolor] forState:UIControlStateNormal];
            [cell.verifyBtn addTarget:self action:@selector(verifyBtnAction)];
        }
        
        return cell;
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{ 
    CGFloat height=0;
    CGFloat with= FNDeviceWidth;
    if(indexPath.section==0){
       height=50;
    }
    else if(indexPath.section==1){
       height=50;
    }
    else if(indexPath.section==2){
       height=50;
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
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView1" forIndexPath:indexPath];
        
        return headerView;
    }
    else if(indexPath.section==1 || indexPath.section==2){
        FNdisOddLaunchHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNdisOddLaunchHeadViewID" forIndexPath:indexPath];
        
        if(indexPath.section==1){
            headerView.titleLB.text=@"价格";
            headerView.resultLB.text=self.dataModel.qkb_worth_tips;
        }
        if(indexPath.section==2){
            headerView.titleLB.text=@"交易数额";
            headerView.resultLB.text=self.dataModel.my_qkb_tips;
        }
        return headerView;
    }
    else if(indexPath.section==3){
        FNdisOddBuyResEditHView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNdisOddBuyResEditHViewID" forIndexPath:indexPath];
        headerView.backgroundColor=[UIColor whiteColor];
        headerView.titleLB.textColor=RGB(51, 51, 51);
        headerView.resultLB.textColor=RGB(205, 205, 205);
        headerView.titleLB.text=self.price_tips;
        headerView.resultLB.text=self.soleStr;
        return headerView;
    }
    else{
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView1" forIndexPath:indexPath];
        
        return headerView;
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat with=FNDeviceWidth;
    CGFloat hight=0;
    if(section==0){
        hight=20;
    }
    else if(section==1 || section==2){
        hight=35;
    }
    else if(section==3){
        hight=50;
    }
    else{
        hight=0;
    }
    return CGSizeMake(with,hight);
}
#pragma mark - //编辑
//
- (void)textFieldDidChangeOne:(id)sender{
    UITextField *field = (UITextField *)sender;
    //field.text
    NSString *content=field.text;
    XYLog(@"单价:%@",content);
    self.wroth=content;
   
    [self inDisCompileWithString:self.wroth with:self.qkb_count];
    self.editState=2;
    
}
//
- (void)textFieldDidChangeTwo:(id)sender{
    UITextField *field = (UITextField *)sender;
    //field.text
    NSString *content=field.text;
    self.qkb_count=content;
    
    [self inDisCompileWithString:self.wroth with:self.qkb_count];
    self.editState=1;
    XYLog(@"数量:%@",content);
}
#pragma mark - FNdisOddLaunchStyleViewDelegate  选择积分或者余额
- (void)didLaunchStyleAction:(NSIndexPath*)index{
    NSArray *moArr=self.dataModel.mode;
    FNdisOddLaunchMoItemModel *model=[FNdisOddLaunchMoItemModel mj_objectWithKeyValues:moArr[index.row]];
    self.price_tips=model.price_tips;
    self.styleType=model.type;
    self.biliStr=model.bili;
    //self.sxfStr=model.sxf;
    //self.sxf_tips=model.sxf_tips;
    [UIView performWithoutAnimation:^{
        [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:1]];
        [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:2]];
        [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:3]];
    }];
}
//编辑
-(void)inDisCompileWithString:(NSString*)content with:(NSString*)count{
    NSString *serveStr=@"";
    CGFloat countFloat=[count floatValue];
    CGFloat contentFloat=[content floatValue];
    CGFloat bili=[self.biliStr floatValue];
    CGFloat sxfFloat=[self.sxfStr floatValue];
    CGFloat serveFloat=0;
    serveFloat=countFloat*sxfFloat;
    CGFloat valueFloat= (countFloat-serveFloat)*contentFloat*bili ;//contentFloat*countFloat*bili;
    CGFloat averageFloat=valueFloat/countFloat;
    self.soleStr=[NSString stringWithFormat:@"%.2f",valueFloat];
    NSArray *array = [self.sxf_tips componentsSeparatedByString:@"$"];
    if(array.count>1){
        if([self.type isEqualToString:@"sell"]){
           serveStr=[NSString stringWithFormat:@"%@%.2f%@",array[0],serveFloat,array[1]];
        }
    }
    NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
    [arrM addObject:serveStr];
    XYLog(@"serveStr备注= %@ 金额= %@",serveStr,self.soleStr);
    self.hintArr=arrM;
    if(![self.wroth kr_isNotEmpty] || ![self.qkb_count kr_isNotEmpty]){
       [self.hintArr removeAllObjects];
    }
    [UIView performWithoutAnimation:^{
        [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:3]];
        [self.jm_collectionview reloadSections:[NSIndexSet indexSetWithIndex:4]];
    }];
    if(serveFloat<0.01){
       serveFloat=0.01;
    }
    self.sxf=[NSString stringWithFormat:@"%.2f",serveFloat];
    
    self.price=[NSString stringWithFormat:@"%.2f",valueFloat];
    
   
    
    self.average_price=[NSString stringWithFormat:@"%.2f",averageFloat];
}
#pragma mark - 确认
-(void)verifyBtnAction{
    
    CGFloat maxcount=0;
    CGFloat countNu=0;
    
    CGFloat wrothFloat=[self.wroth floatValue];
    CGFloat qkb_countFloat=[self.qkb_count floatValue];
    
    countNu=[self.qkb_count floatValue];
    if([self.styleType isEqualToString:@"1"]||[self.styleType isEqualToString:@"3"]){
        //积分
        maxcount=[self.dataModel.user_integral floatValue];
    }else if([self.styleType isEqualToString:@"2"]||[self.styleType isEqualToString:@"4"]){
        //余额
        maxcount=[self.dataModel.user_money floatValue];
    }
    if(countNu>maxcount){
        [FNTipsView showTips:@"超出最大数值"];
        return;
    }else if(![self.wroth kr_isNotEmpty]){
        [FNTipsView showTips:@"请输入价格"];
        return;
    }else if(![self.qkb_count kr_isNotEmpty]){
        [FNTipsView showTips:@"请输入数量"];
        return;
    }
    else if([self.dataModel.sell_min kr_isNotEmpty]){
        if([self.qkb_count integerValue]<[self.dataModel.sell_min integerValue]){
           [FNTipsView showTips:[NSString stringWithFormat:@"最少交易数量%@",self.dataModel.sell_min]];
           return;
        }
    }
    else if([self.dataModel.sell_max kr_isNotEmpty]){
        if([self.qkb_count integerValue]>[self.dataModel.sell_max integerValue]){
           [FNTipsView showTips:[NSString stringWithFormat:@"最大交易数量%@",self.dataModel.sell_max]];
           return;
        }
    }
    
   
    else if(wrothFloat==0 || wrothFloat<0){
        [FNTipsView showTips:@"请输入正确的价格"];
        return;
    }else if(qkb_countFloat==0 || qkb_countFloat<0){
        [FNTipsView showTips:@"请输入正确的数量"];
        return;
    }
    if([self.dataModel.sell_max_price kr_isNotEmpty]){
        if(wrothFloat>[self.dataModel.sell_max_price floatValue]){
            [FNTipsView showTips:[NSString stringWithFormat:@"最大价格%@",self.dataModel.sell_max_price]];
            return;
        }
    }
    if([self.dataModel.sell_min_price kr_isNotEmpty]){
        if(wrothFloat<[self.dataModel.sell_min_price floatValue]){
            [FNTipsView showTips:[NSString stringWithFormat:@"最小价格%@",self.dataModel.sell_min_price]];
            return;
        }
    }
    [self requestReleaseOrder];
}
#pragma mark - // 发布委托单类型
-(FNRequestTool*)requestOrderType{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=qkb&ctrl=release_order_type" respondType:(ResponseTypeModel) modelType:@"FNdisOddLaunchTypeModel" success:^(id respondsObject) {
        @strongify(self);
        FNdisOddLaunchTypeModel *daModel=respondsObject;
        NSArray *cateArr=daModel.list;
        self.navigationView.titleLabel.text=daModel.title;
        if(cateArr.count>0){
            NSMutableArray *nameArray=[NSMutableArray arrayWithCapacity:0];
            NSMutableArray *tyArray=[NSMutableArray arrayWithCapacity:0];
            [cateArr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNdisOddLaunchTypeItemModel *model=[FNdisOddLaunchTypeItemModel mj_objectWithKeyValues:obj];
                [nameArray addObject:model.title];
                [tyArray addObject:model];
            }];
            self.typeArr=tyArray;
            self.categoryView.titleFont=kFONT16;
            self.categoryView.titleSelectedFont=kFONT16;
            self.categoryView.titleColor=RGB(153, 153, 153);
            self.categoryView.titleSelectedColor=RGB(255, 108, 65);//[UIColor colorWithHexString:daModel.color];
            self.lineView.indicatorColor=RGB(255, 108, 65);//[UIColor colorWithHexString:daModel.color];
            self.categoryView.titles =nameArray;
            [self.categoryView reloadData];
            if(self.typeArr>0){
                [self.categoryView selectItemAtIndex:0];//selfWeak.seletedInt];
            }
        }
    } failure:^(NSString *error) {
        
    } isHideTips:NO];
}
-(FNRequestTool*)requestOrder{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.type kr_isNotEmpty]){
        params[@"type"]=self.type;
        if([self.type isEqualToString:@"sell"]){
            params[@"deduct_qkb"]=@"1";
        }
        if([self.type isEqualToString:@"buy"]){
            params[@"deduct_qkb"]=@"0";
        }
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=qkb&ctrl=release_order_page" respondType:(ResponseTypeModel) modelType:@"FNdisOddLaunchModel" success:^(id respondsObject) {
        @strongify(self);
        self.dataModel=respondsObject;
        self.deduct_qkb=self.dataModel.deduct_qkb;
        NSArray *moArr=self.dataModel.mode;
        self.sxf_tips=self.dataModel.sxf_tips;
        if(moArr.count>0){
            FNdisOddLaunchMoItemModel *model=[FNdisOddLaunchMoItemModel mj_objectWithKeyValues:moArr[0]];
            self.price_tips=model.price_tips;
            self.styleType=model.type;
            self.biliStr=model.bili;
            self.sxfStr=model.sxf;
            self.sxf_tips=model.sxf_tips;
            XYLog(@"率=%@",self.sxfStr);
        }
        if([self.dataModel.sxf_tips kr_isNotEmpty]){
            self.sxf_tips=self.dataModel.sxf_tips;
        }
        if([self.dataModel.qkb_sxf kr_isNotEmpty]){
            self.sxfStr=self.dataModel.qkb_sxf;
        }
        
        XYLog(@"率=%@",self.sxfStr);
        [self.jm_collectionview reloadData];
    } failure:^(NSString *error) {
        
    } isHideTips:NO];
}
#pragma mark - //发布委托单
-(FNRequestTool*)requestReleaseOrder{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    
    if([self.styleType kr_isNotEmpty]){
        params[@"type"]=self.styleType;
        if([self.type isEqualToString:@"sell"]){
           params[@"deduct_qkb"]=@"1";
        }
        if([self.type isEqualToString:@"buy"]){
            params[@"deduct_qkb"]=@"1";
            self.sxf=@"";
        }
    }
    if([self.wroth kr_isNotEmpty]){
        params[@"wroth"]=self.wroth;
    }
    if([self.average_price kr_isNotEmpty]){
        params[@"average_price"]=self.average_price;
    }
    if([self.qkb_count kr_isNotEmpty]){
        params[@"qkb_count"]=self.qkb_count;
    }
    if([self.price kr_isNotEmpty]){
        params[@"price"]=self.price;
    }
    if([self.sxf kr_isNotEmpty]){
        params[@"sxf"]=self.sxf;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=qkb_transaction&ctrl=bulid_order" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        //NSDictionary* dict = respondsObject[DataKey];
        //XYLog(@"发布%@",respondsObject);
        @strongify(self);
        NSInteger state=[respondsObject[SuccessKey] integerValue];
        NSString *msgStr=respondsObject[MsgKey];
        if(state==1){
            if ([self.delegate respondsToSelector:@selector(didOddLaunchStateAction:)]) {
                [self.delegate didOddLaunchStateAction:self.index];
            }
            [FNNotificationCenter postNotificationName:@"FBupdateNOIsCache" object:nil];
            
            [FNTipsView showTips:msgStr];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSString *error) {
        
    } isHideTips:NO];
}


- (NSMutableArray *)typeArr{
    if (!_typeArr) {
        _typeArr = [NSMutableArray array];
    }
    return _typeArr;
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
        if(self.editState==1){
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
