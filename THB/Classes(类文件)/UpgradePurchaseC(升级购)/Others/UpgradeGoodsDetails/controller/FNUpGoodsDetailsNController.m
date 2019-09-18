//
//  FNUpGoodsDetailsNController.m
//  THB
//
//  Created by Jimmy on 2018/9/26.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNUpGoodsDetailsNController.h"
//view
#import "FNCustomeNavigationBar.h"
#import "FNUPdetailsHeadNCell.h"
#import "FNUpChoiceSpecificationCell.h"
#import "FNUpDetailsReferralNCell.h"
#import "FNUpDetailsLikeNCell.h"
#import "FNUpDetailsPictureNCell.h"
#import "FNFunctionBtnView.h"
#import "FNUpSpecificationsNSView.h"
#import "JMAlertView.h"

//model
#import "FNUpDetailsNModel.h"
#import "FNUpgradeNMode.h"

//Controller
#import "FNUpOrderMessageNeController.h"
#import "FNShareViewController.h"

@interface FNUpGoodsDetailsNController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,FNUpDetailsReferralNCellDelegate,FNUpDetailsLikeNCellDelegate>
@property (nonatomic,strong)FNCustomeNavigationBar *cuNaivgationbar;
@property (nonatomic,strong)NSDictionary *dataDic;
/** 图片0:商品介绍 1:其他 **/
@property (nonatomic,assign)NSInteger  printInt;
/** 图片数据 **/
@property(nonatomic,strong)NSMutableArray *printArray;
/** 商品属性 **/
@property(nonatomic,strong)NSMutableArray *propertyArray;
/** 商品数量 **/
@property(nonatomic,strong)NSString *amountString;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton* purchaseBtn;
@property (nonatomic, strong) UIButton* shareBtn;
@end

@implementation FNUpGoodsDetailsNController
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat conY = scrollView.contentOffset.y;
    if (conY>=self.cuNaivgationbar.height && conY<= 2*self.cuNaivgationbar.height) {
        CGFloat alpha = (conY-self.cuNaivgationbar.height)/self.cuNaivgationbar.height;
        self.cuNaivgationbar.backgroundColor = [FNWhiteColor colorWithAlphaComponent:alpha];
        //self.titleview.alpha = alpha;
    }else if (conY >= self.cuNaivgationbar.height*2){
        self.cuNaivgationbar.backgroundColor = [FNWhiteColor colorWithAlphaComponent:1];
         _cuNaivgationbar.titleLabel.textColor=[UIColor blackColor];
    }else{
        self.cuNaivgationbar.backgroundColor = [FNWhiteColor colorWithAlphaComponent:0];
         _cuNaivgationbar.titleLabel.textColor=[UIColor clearColor];
    }
    
    
}

#pragma mark - 消失
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
    self.amountString=@"1";
    self.printInt=0;
    [self apiRequestDetails];
    [self GoodsDetailsTableView];
    [self setUpCustomizedNaviBar];
}
#pragma mark - NavBar 导航栏
- (void)setUpCustomizedNaviBar{
    
    _cuNaivgationbar = [FNCustomeNavigationBar customeNavigationBarWithTitle:@"商品"];
    _cuNaivgationbar.titleLabel.textColor=[UIColor blackColor];
    _cuNaivgationbar.backgroundColor = [UIColor clearColor];
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [backBtn setImage:[UIImage imageNamed:@"detail_return"] forState:UIControlStateNormal];
    [backBtn sizeToFit];
    backBtn.size = CGSizeMake(backBtn.width+10, backBtn.height+10);
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    _cuNaivgationbar.leftButton = backBtn;
    [self.view addSubview:_cuNaivgationbar];
    
}
-(void)backBtnAction{ 
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 单元
-(void)GoodsDetailsTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    //CGFloat tableHeight=FNDeviceHeight-SafeAreaTopHeight;
    self.jm_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight-50) style:UITableViewStylePlain];
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.sectionFooterHeight=0;
    self.jm_tableview.sectionHeaderHeight=0;
    self.jm_tableview.hidden=YES;
    [self.view addSubview:self.jm_tableview];
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.bottom.bottom.equalTo(isIphoneX ? @-84 : @-50);
    }];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(isIphoneX ? @-34 : @0);
    }];
    
}

#pragma mark - UITableViewDataSource delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==4){
        return self.printArray.count;
    }else{
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        FNUpDetailsNModel *model=[FNUpDetailsNModel mj_objectWithKeyValues:self.dataDic];
        BOOL showMidUpgrade = model.mid_zgz && [model.mid_zgz[@"is_show"] isEqual:@"1"] && ![FNCurrentVersion isEqualToString:Setting_checkVersion];
        return showMidUpgrade ? 465 : 405;
    }else if(indexPath.section==1){
        return 50;
    }else if(indexPath.section==2){
        return 265;
    }else if(indexPath.section==3){
        return 50;
    }
    else{
        if( _printArray.count>0){
            UIImage*img = _printArray[indexPath.row];
            CGFloat height = 0;
            if (img && [img isKindOfClass:[UIImage class]]) {
                height = JMScreenWidth*(img.size.height/img.size.width);
            }else{
                height = 0;
            }
            return height;
        }else{
            return 0;
        }
        
        
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        FNUPdetailsHeadNCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UPdetailsHeadNCell"];
        if (cell == nil) {
            cell = [[FNUPdetailsHeadNCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UPdetailsHeadNCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        @weakify(self)
        cell.upgradeClicked = ^{
            @strongify(self);
            [self loadMembershipUpgradeViewController];
        };
        cell.shareClicked = ^{
            @strongify(self);
            [self shareBtnAction];
        };
        cell.dataDic=self.dataDic;
        return cell;
    }else if(indexPath.section==1){
        FNUpChoiceSpecificationCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UPSpecificationCell"];
        if (cell == nil) {
            cell = [[FNUpChoiceSpecificationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UPSpecificationCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataArr=self.propertyArray;
        return cell;
    }else if(indexPath.section==2){
        FNUpDetailsLikeNCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UPDetailsLikeNCell"];
        if (cell == nil) {
            cell = [[FNUpDetailsLikeNCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UPDetailsLikeNCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.recommend=self.dataDic;
        cell.delegate=self;
        return cell;
    }else if(indexPath.section==3){
        FNUpDetailsReferralNCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UPDetailsReferralNCell"];
        if (cell == nil) {
            cell = [[FNUpDetailsReferralNCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UPDetailsReferralNCell"];
        }
        cell.delegate=self;
        cell.printInt=self.printInt;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        
        FNUpDetailsPictureNCell* cell = [tableView dequeueReusableCellWithIdentifier:@"FNUpDetailsPictureNCell"];
        if (cell == nil) {
            cell = [[FNUpDetailsPictureNCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FNUpDetailsPictureNCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.image=self.printArray[indexPath.row];
        cell.imgview.image=self.printArray[indexPath.row];
        return cell;
    
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//   
//        [FNUpSpecificationsNSView showWithModel:self.dataDic view:self.view backblock:^(id model) {
//            
//        }];
    if(indexPath.section==1){
        @WeakObj(self);
        /*[FNUpSpecificationsNSView showWithModel:self.dataDic selectWithProperty:self.propertyArray view:self.view backblock:^(id model) {
            selfWeak.propertyArray=model;
            [self.jm_tableview reloadData];
        }];*/
        [FNUpSpecificationsNSView showWithModel:self.dataDic selectWithProperty:self.propertyArray view:self.view backblock:^(id model, NSString *amountString) {
            selfWeak.propertyArray=model;
            selfWeak.amountString=amountString;
            [self.jm_tableview reloadData];
        }];
    }
    
    
}
#pragma mark -  FNUpDetailsLikeNCellDelegate
-(void)selectDetailsLikeNAction:(id)model{ 
    FNRecommendNMode* itemmodel=[FNRecommendNMode mj_objectWithKeyValues:model];
    FNUpGoodsDetailsNController *detailsVC=[[FNUpGoodsDetailsNController alloc]init];
    detailsVC.DetailsID=itemmodel.id;
    [self.navigationController pushViewController:detailsVC animated:YES];
}
#pragma mark -  FNUpDetailsReferralNCellDelegate :// 点击
- (void)likeBtnClickAction:(NSInteger)sender{
    self.printInt=sender;
    NSMutableArray *imageArr =[NSMutableArray array];
    if(sender==0){
        imageArr =self.dataDic[@"detail_img"];
    }else{
        imageArr =self.dataDic[@"standard_img"];
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (imageArr.count>=1) {
            [self.printArray removeAllObjects];
            NSMutableArray* results = [NSMutableArray arrayWithArray:imageArr];
            for (NSInteger i = 0; i<=imageArr.count; i++) {
                if (i<=imageArr.count-1) {
                    UIImage* img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:results[i]]]];
                    if (img) {
                        [self.printArray addObject:img];
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            //NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:4];
                            //[self.jm_tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
                            [self.jm_tableview reloadData];
                        });
                    }else{
                        [self.printArray addObject:@""];
                    }
                }
            }
            dispatch_sync(dispatch_get_main_queue(), ^{
                //NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:4];
                //[self.jm_tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
                [self.jm_tableview reloadData];
            });
        }
        
    });
    
}
#pragma mark - bottomView
-(UIView*)bottomView{
    if (_bottomView == nil) {
        _bottomView=[[UIView alloc]init];
        
        _purchaseBtn = [[UIButton alloc] init];
        _purchaseBtn.titleLabel.numberOfLines = 0;
        _purchaseBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_bottomView addSubview:_purchaseBtn];
        [_purchaseBtn addTarget:self action:@selector(purchaseBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_purchaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-5);
            make.height.mas_equalTo(44);
            make.centerY.equalTo(@0);
            make.left.equalTo(_bottomView.mas_centerX);
        }];
        
        _shareBtn = [[UIButton alloc] init];
        _shareBtn.titleLabel.numberOfLines = 0;
        _shareBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_bottomView addSubview:_shareBtn];
        [_shareBtn addTarget:self action:@selector(shareBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@5);
            make.height.mas_equalTo(44);
            make.centerY.equalTo(@0);
            make.right.equalTo(_bottomView.mas_centerX);
        }];
    }
    return _bottomView;
}
#pragma mark - 升级购
-(void)purchaseBtnAction{
    NSMutableArray *arr=[NSMutableArray array];
    NSMutableArray *natureArr=[NSMutableArray array];
    NSString *attr_idString=@"";
    if(self.propertyArray.count>0){
        for (NSInteger i = 0; i < self.propertyArray.count; i++) {
            FNUpGoodsAttrNModel *model=self.propertyArray[i];
            for (NSInteger j = 0; j < model.attr_val.count; j++) {
                FNUpGoodsAttrItemNModel *ExModel= model.attr_val[j];
                if (ExModel.isSelect == YES) {
                    [arr addObject:ExModel.name];
                    [natureArr addObject:ExModel.id];
                }
            }
        }
        if(arr.count<self.propertyArray.count){
            [FNTipsView showTips:@"请选择规格!"];
            return;
        }
    } 
    if(natureArr.count>0){
       attr_idString=[natureArr componentsJoinedByString:@","];
    }
    
    if ([_dataDic[@"is_show_tip"] isEqualToString:@"1"]) {
        JMAlertView* alert = [JMAlertView alertWithTitle:@"" content:_dataDic[@"tip_str"] firstTitle:@"取消" andSecondTitle:_dataDic[@"btn_str"] alertType:(AlertTypeAlert) clickBlock:^(NSInteger index) {
            if (index == 1) {
                [self goOrderAttr:attr_idString];
            }
        }];
        [alert showAlert];
    } else {
        [self goOrderAttr:attr_idString];
    }
    
    
}

- (void)goOrderAttr: (NSString*)attr {
    FNUpOrderMessageNeController *OrderVC=[[FNUpOrderMessageNeController alloc]init];
    OrderVC.commodityID=self.DetailsID;
    OrderVC.numString=self.amountString;
    OrderVC.attr_idString=attr;
    [self.navigationController pushViewController:OrderVC animated:YES];
}

#pragma mark - 分享赚
-(void)shareBtnAction{
    FNShareViewController *share = [[FNShareViewController alloc] init];
    share.SkipUIIdentifier = self.dataDic[@"SkipUIIdentifier"];
    share.fnuo_id = self.dataDic[@"id"];
    [self.navigationController pushViewController:share animated:YES];
}
#pragma mark - //获取商品列表
- (FNRequestTool *)apiRequestDetails{
    
    [SVProgressHUD show];
    @WeakObj(self);
    NSString *token = UserAccessToken;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":token,@"id":self.DetailsID,}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=update_goods&ctrl=goods_detail" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"商品详情:%@",respondsObject);
        NSDictionary *commitsList =  respondsObject [DataKey];
        selfWeak.dataDic=respondsObject [DataKey];
        NSMutableArray *imageArr =commitsList[@"detail_img"];
        
        
        
        NSMutableArray *proArr =commitsList[@"attr_data"];
        NSMutableArray *addArr =[NSMutableArray array];
        for (NSDictionary *dic in proArr) {
            [addArr addObject:[FNUpGoodsAttrNModel mj_objectWithKeyValues:dic]];
        }
        selfWeak.propertyArray=addArr;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            if (imageArr.count>=1) {
                [self.printArray removeAllObjects];
                
                NSMutableArray* results = [NSMutableArray arrayWithArray:imageArr];
                for (NSInteger i = 0; i<=imageArr.count; i++) {
                    if (i<=imageArr.count-1) {
                        UIImage* img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:results[i]]]];
                        //CGFloat height = img?JMScreenWidth*(img.size.height/img.size.width):0;
                        if (img) {
                            [self.printArray addObject:img];
                            dispatch_sync(dispatch_get_main_queue(), ^{
                                self.jm_tableview.hidden=NO;
                                [self.jm_tableview reloadData];
                            });
                        }else{
                            [self.printArray addObject:@""];
                        }
                    }
                }
                dispatch_sync(dispatch_get_main_queue(), ^{
                    self.jm_tableview.hidden=NO;
                    [self.jm_tableview reloadData];
                });
            }
        });
        
        self.jm_tableview.hidden=NO;
        [self.jm_tableview reloadData];
        [UIView animateWithDuration:0.2 animations:^{ 
            [SVProgressHUD dismiss];
        }];
        
        FNUpDetailsNModel *model=[FNUpDetailsNModel mj_objectWithKeyValues:self.dataDic];
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:[model.btn_fxz[@"bili"] kr_isNotEmpty] ? @"%@\n" : @"%@", model.btn_fxz[@"bili"]] attributes: @{NSFontAttributeName: kFONT14, NSForegroundColorAttributeName: UIColor.whiteColor}];
        [str1 appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", model.btn_fxz[@"str"]] attributes:@{NSFontAttributeName: kFONT12, NSForegroundColorAttributeName: UIColor.whiteColor}]];
        [_shareBtn setAttributedTitle:str1 forState:UIControlStateNormal];
        [_shareBtn setTitleColor:[UIColor colorWithHexString:model.btn_fxz[@"fontcolor"]] forState:UIControlStateNormal];
        [_shareBtn sd_setBackgroundImageWithURL:URL(model.btn_fxz[@"img"]) forState:UIControlStateNormal];
        _shareBtn.hidden = !model.btn_fxz[@"is_show"];
        
        NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:[model.btn_zgz[@"bili"] kr_isNotEmpty] ? @"%@\n" : @"%@", model.btn_zgz[@"bili"]] attributes: @{NSFontAttributeName: kFONT14, NSForegroundColorAttributeName: UIColor.whiteColor}];
        [str2 appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", model.btn_zgz[@"str"]] attributes:@{NSFontAttributeName: kFONT12, NSForegroundColorAttributeName: UIColor.whiteColor}]];
        [_purchaseBtn setAttributedTitle:str2 forState:UIControlStateNormal];
        [_purchaseBtn setTitleColor:[UIColor colorWithHexString:model.btn_zgz[@"fontcolor"]] forState:UIControlStateNormal];
        [_purchaseBtn sd_setBackgroundImageWithURL:URL(model.btn_zgz[@"img"]) forState:UIControlStateNormal];
        _purchaseBtn.hidden = !model.btn_zgz[@"is_show"];
        
        if ([FNCurrentVersion isEqualToString: Setting_checkVersion]) {
            _shareBtn.hidden = YES;
            [_purchaseBtn setAttributedTitle:[[NSAttributedString alloc] initWithString:@"立即购买"] forState:UIControlStateNormal];
        }
        
    } failure:^(NSString *error) {
        [self apiRequestDetails]; 
    } isHideTips:NO];
}

- (NSMutableArray *)printArray {
    if (!_printArray) {
        _printArray = [NSMutableArray array];
    }
    return _printArray;
}
- (NSMutableArray *)propertyArray {
    if (!_propertyArray) {
        _propertyArray = [NSMutableArray array];
    }
    return _propertyArray;
}

@end
