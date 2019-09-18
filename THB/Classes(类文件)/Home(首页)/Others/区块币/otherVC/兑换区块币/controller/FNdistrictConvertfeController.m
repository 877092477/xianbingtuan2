//
//  FNdistrictConvertfeController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/5.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdistrictConvertfeController.h"
#import "FNCustomeNavigationBar.h"
#import "JXCategoryView.h"
#import "FNdistrictConvertTypefeModel.h"
#import "FNConvertheaderFeCell.h"
#import "FNConvertCompileItemCell.h"
#import "FNConvertHintfeCell.h"
#import "FNConvertVerifyfeCell.h"
#import "FNdistrictCoinStateView.h"
#import "DSHPopupContainer.h"
#import "FNconverResultHeadView.h"
@interface FNdistrictConvertfeController ()<UICollectionViewDelegate,UICollectionViewDataSource,JXCategoryViewDelegate,FNConvertCompileItemCellDelegate,UITextFieldDelegate>
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)JXCategoryTitleView *categoryView;
@property (nonatomic, strong)JXCategoryIndicatorLineView *lineView;
@property (nonatomic, strong)FNdistrictConvertTypefeModel *typeModel;
@property (nonatomic, strong)FNConvertfeModel *msgModel;
@property (nonatomic, strong)NSMutableArray *typeArr;
@property (nonatomic, strong)NSMutableArray *hintArr;
@property (nonatomic, strong)NSMutableArray *editArr;
//@property (nonatomic, strong)NSMutableArray *soleArr;
@property (nonatomic, strong)NSString *soleStr;
@property (nonatomic, strong)NSString *qkb_count;
@property (nonatomic, strong)DSHPopupContainer *container;
@end

@implementation FNdistrictConvertfeController
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
    self.navigationView.titleLabel.text=self.keyWord?self.keyWord:@"兑换区块币";
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
    //XYLog(@"选择%ld",(long)index);
    if(self.typeArr>0){
        self.soleStr=@"";
        [self.hintArr removeAllObjects];
        FNConvertTypeItemfeModel *model=self.typeArr[index];
        self.msgType=model.type;
        [self requestConvertMsg];
    }
}
//预先弹出状态框 暂未使用
-(void)remindBtnAction{
        FNdistrictCoinStateView *customView = [[FNdistrictCoinStateView alloc] init];
        [customView.rightBtn addTarget:self action:@selector(customViewDiss)];
        self.container = [[DSHPopupContainer alloc] initWithCustomPopupView:customView];
        self.container.autoDismissWhenClickedBackground=NO;
        self.container.maskColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
        //[self.container show];
}
-(void)customViewDiss{
    [self.container dismiss];
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
    //flowlayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
    
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+67, FNDeviceWidth, FNDeviceHeight-baseGap-SafeAreaTopHeight-67) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=RGB(250, 250, 250);
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.jm_collectionview registerClass:[FNConvertheaderFeCell class] forCellWithReuseIdentifier:@"FNConvertheaderFeCellID"];
    [self.jm_collectionview registerClass:[FNConvertCompileItemCell class] forCellWithReuseIdentifier:@"FNConvertCompileItemCellID"];
    [self.jm_collectionview registerClass:[FNConvertHintfeCell class] forCellWithReuseIdentifier:@"FNConvertHintfeCellID"];
    [self.jm_collectionview registerClass:[FNConvertVerifyfeCell class] forCellWithReuseIdentifier:@"FNConvertVerifyfeCellID"];
    
    [self.jm_collectionview registerClass:[FNconverResultHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNconverResultHeadView"];
    
    [self.jm_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView1"];
    
    [self setTopViews];
    [self cateTopView];
    if([UserAccessToken kr_isNotEmpty]){
       [self requestDuiHuan];
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
        return self.editArr.count;
    }
    else if(section==2){
       return self.hintArr.count;
    }
    else {
        return 1;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==0){
        FNConvertheaderFeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNConvertheaderFeCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.model=self.msgModel;
        return cell;
    }else if(indexPath.section==1){
        FNConvertCompileItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNConvertCompileItemCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        cell.compileField.delegate=self;
           FNConvertEditItemfeModel *model=self.editArr[indexPath.row];
            cell.model=model;
            cell.index=indexPath;
            cell.delegate=self;
            if([model.msgStr kr_isNotEmpty]){
               [cell.rightBtn addTarget:self action:@selector(checkAllClick)];
               [cell.rightBtn setTitleColor:[UIColor colorWithHexString:self.typeModel.color] forState:UIControlStateNormal];
            }
            cell.compileField.textColor=[UIColor colorWithHexString:self.typeModel.color];
        
        return cell;
    }
 
    else if(indexPath.section==2){
        FNConvertHintfeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNConvertHintfeCellID" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor whiteColor];
        //cell.model=self.msgModel;
        if(self.hintArr.count>0){
           cell.titleLB.text=self.hintArr[0];
        } 
        return cell;
    }
    else{
        FNConvertVerifyfeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNConvertVerifyfeCellID" forIndexPath:indexPath];
        //cell.backgroundColor=[UIColor whiteColor];
        //cell.model=self.msgModel;
        [cell.verifyBtn setTitle:self.msgModel.btn_font forState:UIControlStateNormal];
        if(self.hintArr.count>0){
            [cell.verifyBtn sd_setBackgroundImageWithURL:URL(self.msgModel.btn_check_bg) forState:UIControlStateNormal];
            [cell.verifyBtn setTitleColor:[UIColor colorWithHexString:self.msgModel.btn__check_bg_fcolor] forState:UIControlStateNormal];
            [cell.verifyBtn addTarget:self action:@selector(verifyBtnAction)];
        }else{
            [cell.verifyBtn sd_setBackgroundImageWithURL:URL(self.msgModel.btn_bg) forState:UIControlStateNormal];
            [cell.verifyBtn setTitleColor:[UIColor colorWithHexString:self.msgModel.btn_bg_fcolor] forState:UIControlStateNormal];
        }
        return cell;
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height=175;
    CGFloat with= FNDeviceWidth;
    if(indexPath.section==0){
        height=125;
    }else if(indexPath.section==1){
        height=80;
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
#pragma mark - Collection view Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==2){
        FNconverResultHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNconverResultHeadView" forIndexPath:indexPath];
                headerView.backgroundColor=[UIColor whiteColor];
                        headerView.titleLB.text=self.msgModel.last_title;
                        if(self.hintArr.count>0){
                            headerView.resultLB.text=self.soleStr;
                            headerView.resultLB.textColor=[UIColor colorWithHexString:self.typeModel.color];
                        }else{
                            headerView.resultLB.text=self.msgModel.top_tips;
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
        hight=80;
    }else{
        hight=0;
    }
    
    return CGSizeMake(with,hight);
}
#pragma mark - FNConvertCompileItemCellDelegate // 编辑
- (void)didCompileItemAction:(NSIndexPath*)index withContent:(NSString*)content{
    
    
    FNConvertEditItemfeModel *editoneModel=self.editArr[0];
    editoneModel.valueStr=content;
    self.qkb_count=content;
//    if([self.msgModel.max_count kr_isNotEmpty]){
//        CGFloat max_count=[self.msgModel.max_count floatValue];
//        CGFloat user_qkb=[content floatValue];
//        if(user_qkb>max_count){
//            editoneModel.valueStr=self.msgModel.max_count;
//            self.qkb_count=self.msgModel.max_count;
//            NSString *maxString=[NSString stringWithFormat:@"最多兑换%@",self.msgModel.max_count];
//            [FNTipsView showTips:maxString];
//        }
//    }
    NSString *serveStr=@"";
            CGFloat contentFloat=[content floatValue];
            CGFloat bili=[self.msgModel.bili floatValue];
            CGFloat sxf=[self.msgModel.sxf floatValue];
            CGFloat valueFloat=contentFloat*bili;
            CGFloat serveFloat=valueFloat*sxf;
            self.soleStr=[NSString stringWithFormat:@"%.2f",valueFloat];
            NSArray *array = [self.msgModel.sxf_tips componentsSeparatedByString:@"$"];
            if(array.count>1){
                serveStr=[NSString stringWithFormat:@"%@%.2f%@",array[0],serveFloat,array[1]];
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
   
}
#pragma mark - 全选
-(void)checkAllClick{
    if([self.msgModel.max_count kr_isNotEmpty]){
        CGFloat max_count=[self.msgModel.max_count floatValue];
        CGFloat user_qkb=[self.msgModel.top_qkb_count floatValue];
        self.qkb_count=self.msgModel.max_count;
        if(user_qkb>max_count){
            //self.qkb_count=self.msgModel.max_count;
            //NSString *maxString=[NSString stringWithFormat:@"最多兑换%@",self.msgModel.max_count];
            //[FNTipsView showTips:maxString];
            //return;
        }else{
            //self.qkb_count=self.msgModel.top_qkb_count;
        }
    }
        FNConvertEditItemfeModel *itemModel=self.editArr[0];
        itemModel.valueStr=self.msgModel.top_qkb_count;
        self.qkb_count=itemModel.valueStr;
        NSString *serveStr=@"";
        CGFloat contentFloat=[self.msgModel.top_qkb_count floatValue];
        CGFloat bili=[self.msgModel.bili floatValue];
        CGFloat sxf=[self.msgModel.sxf floatValue];
        CGFloat valueFloat=contentFloat*bili;
        CGFloat serveFloat=valueFloat*sxf;
        //editTwoModel.valueStr=[NSString stringWithFormat:@"%.2f",valueFloat];
        self.soleStr=[NSString stringWithFormat:@"%.2f",valueFloat];
        NSArray *array = [self.msgModel.sxf_tips componentsSeparatedByString:@"$"];
        if(array.count>1){
            serveStr=[NSString stringWithFormat:@"%@%.2f%@",array[0],serveFloat,array[1]];
        }
        [self.hintArr removeAllObjects];
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        [arrM addObject:serveStr];
        self.hintArr=arrM;
        [UIView performWithoutAnimation:^{
            [self.jm_collectionview reloadData];
        }];
}
//编辑
-(void)inDisCompileWithString:(NSString*)content{
    
}
#pragma mark - 确认兑换
-(void)verifyBtnAction{
//    if([self.msgModel.max_count kr_isNotEmpty]){
//        CGFloat max_count=[self.msgModel.max_count floatValue];
//        CGFloat qkb_count=[self.qkb_count floatValue];
//        if(qkb_count>max_count){
//            //NSString *maxString=[NSString stringWithFormat:@"最多兑换%@",self.msgModel.max_count];
//            //[FNTipsView showTips:maxString];
//            //return;
//        }
//    }
    CGFloat qkbcountFloat=[self.qkb_count floatValue];
    if(![self.qkb_count kr_isNotEmpty]){
       [FNTipsView showTips:@"请输入信息"];
        return;
    }else if(qkbcountFloat==0 || qkbcountFloat<0){
       [FNTipsView showTips:@"请输入信息"];
        return;
    }
    [self requestConversion];
 
}
#pragma mark - //  转出|兑换页面 方式
-(FNRequestTool*)requestDuiHuan{
    @WeakObj(self);
    //@weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.type kr_isNotEmpty]){
        params[@"type"]=self.type;
    }
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=qkb&ctrl=select_type" respondType:(ResponseTypeModel) modelType:@"FNdistrictConvertTypefeModel" success:^(id respondsObject) {
        //@strongify(self);
        selfWeak.typeModel=respondsObject;
        NSArray *cateArr=selfWeak.typeModel.list;
        selfWeak.navigationView.titleLabel.text=selfWeak.typeModel.title;
        if(cateArr.count>0){
            NSMutableArray *nameArray=[NSMutableArray arrayWithCapacity:0];
            NSMutableArray *tyArray=[NSMutableArray arrayWithCapacity:0];
            [cateArr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                FNConvertTypeItemfeModel *model=[FNConvertTypeItemfeModel mj_objectWithKeyValues:obj];
                [nameArray addObject:model.title];
                [tyArray addObject:model];
            }];
            selfWeak.typeArr=tyArray;
            selfWeak.categoryView.titleFont=kFONT16;
            selfWeak.categoryView.titleSelectedFont=kFONT16;
            selfWeak.categoryView.titleColor=RGB(153, 153, 153);
            selfWeak.categoryView.titleSelectedColor=[UIColor colorWithHexString:selfWeak.typeModel.color];
            selfWeak.lineView.indicatorColor=[UIColor colorWithHexString:selfWeak.typeModel.color];
            selfWeak.categoryView.titles =nameArray;
            [selfWeak.categoryView reloadData];
            if(selfWeak.typeArr>0){
               [selfWeak.categoryView selectItemAtIndex:selfWeak.seletedInt];
            }
            
        }
    } failure:^(NSString *error) {
        
    } isHideTips:YES isCache:NO];
}
#pragma mark - //  转出|兑换页面详细内容
-(FNRequestTool*)requestConvertMsg{
   
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.msgType kr_isNotEmpty]){
        params[@"type"]=self.msgType;
    }
    
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=qkb&ctrl=select_page_of_type" respondType:(ResponseTypeModel) modelType:@"FNConvertfeModel" success:^(id respondsObject) {
        @strongify(self);
        self.msgModel=respondsObject;
        FNConvertEditItemfeModel *editOneModel=[[FNConvertEditItemfeModel alloc]init];
        editOneModel.titleStr=self.msgModel.middel_title;
        editOneModel.hintStr=self.msgModel.middel_tips;
        editOneModel.msgStr=self.msgModel.middel_btn;
        editOneModel.valueStr=@"";
        editOneModel.moreShow=1;
        editOneModel.compute_type=self.msgModel.compute_type;
        
        NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
        [arrM addObject:editOneModel];
        self.editArr=arrM;
        [self.jm_collectionview reloadData];
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES isCache:NO];
}
#pragma mark - //   转出区块币接口 兑换区块币接口
-(FNRequestTool*)requestConversion{
    //@WeakObj(self);
    //@weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    if([self.msgType kr_isNotEmpty]){
        params[@"type"]=self.msgType;
    }
    if([self.qkb_count kr_isNotEmpty]){
        params[@"qkb_count"]=self.qkb_count;
    }
    NSString *urlString=@"";
    if([self.type isEqualToString:@"duihuan"]){
        urlString=@"mod=appapi&act=qkb_transaction&ctrl=exchange";
    }
    if([self.type isEqualToString:@"zhuanchu"]){
        urlString=@"mod=appapi&act=qkb_transaction&ctrl=zhuanchu";
    }
    return [FNRequestTool requestWithParams:params api:urlString respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        //NSDictionary* dict = respondsObject[DataKey];
        XYLog(@"兑换%@",respondsObject);
        NSInteger state=[respondsObject[SuccessKey] integerValue];
        if(state==1){
           [FNTipsView showTips:@"兑换成功"];
           [self.navigationController popViewControllerAnimated:YES];
        }else{
           [FNTipsView showTips:@"兑换失败"];
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
- (NSMutableArray *)editArr{
    if (!_editArr) {
        _editArr = [NSMutableArray array];
    }
    return _editArr;
}
//- (NSMutableArray *)soleArr{
//    if (!_soleArr) {
//        _soleArr = [NSMutableArray array];
//    }
//    return _soleArr;
//}

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
        if([self.msgModel.compute_type isEqualToString:@"int"]){
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
