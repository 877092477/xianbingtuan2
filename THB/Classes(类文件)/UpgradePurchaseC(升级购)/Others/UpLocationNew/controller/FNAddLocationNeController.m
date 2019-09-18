//
//  FNAddLocationNeController.m
//  THB
//
//  Created by Jimmy on 2018/9/29.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNAddLocationNeController.h"

//view
#import "FNLocationItemNameNeCell.h"
#import "FNMinuteLocationNeCell.h"
#import "FNRedactDefaultNeCell.h"
//controller
#import "GetProvinceViewController.h"

@interface FNAddLocationNeController ()<UITableViewDelegate,UITableViewDataSource,FNLocationItemNameNeCellDelegate,FNMinuteLocationNeCellDelegate,FNRedactDefaultNeCellDelegate>

/** 保存 **/
@property (nonatomic, strong)UIButton *saveButton;
/** 名字 **/
@property (nonatomic, strong)NSString *nameString;
/** 电话 **/
@property (nonatomic, strong)NSString *numberString;
/** 选择地区拼接 **/
@property (nonatomic, strong)NSString *regionString;
/** 详细地址 **/
@property (nonatomic, strong)NSString *detailedAddressString;
/** 默认 **/
@property (nonatomic, strong)NSString *defaultString;
/** 省 **/
@property (nonatomic, strong)NSString *provinceString;
/** 市 **/
@property (nonatomic, strong)NSString *cityString;
/** 县 **/
@property (nonatomic, strong)NSString *districtString;
/** 街道 **/
@property (nonatomic, strong)NSString *areaString;


@end

@implementation FNAddLocationNeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"新建收货地址";
    self.defaultString=@"0";
    [self navButton];
    [self AddLocationTableView];
    
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(tongzhi:) name:@"EditProfile" object:nil];
}
-(void)navButton{
    self.saveButton= [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveButton.titleLabel.font=kFONT12;
    [self.saveButton sizeToFit];
    [self.saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveButton setTitleColor:[UIColor blackColor] forState:0];
    [self.saveButton addTarget:self action:@selector(saveButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.saveButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.saveButton];
    if(self.editBo==1){
        self.nameString=self.editModel.name;
        self.numberString=self.editModel.phone;
        self.defaultString=self.editModel.is_acquiesce;
        self.provinceString=self.editModel.province;
        self.cityString=self.editModel.city;
        self.districtString=self.editModel.district;
        self.regionString=[NSString stringWithFormat:@"%@%@%@",self.editModel.province,self.editModel.city,self.editModel.district];
        self.detailedAddressString=self.editModel.detail_address;
    }
    
}
#pragma mark - 保存
-(void)saveButtonAction{
    //[self.navigationController popViewControllerAnimated:YES];
    NSLog(@"name:%@",self.nameString);
    NSLog(@"number:%@",self.numberString);
    NSLog(@"regionString:%@",self.regionString);
    NSLog(@"detailedAddressString:%@",self.detailedAddressString);
    NSLog(@"defaultString:%@",self.defaultString);
    NSLog(@"provinceString:%@",self.provinceString);
    if(![self.nameString kr_isNotEmpty]){
        [FNTipsView showTips:@"请填写名字"];
        return;
    }else if(![self.numberString kr_isNotEmpty]){
        [FNTipsView showTips:@"请填写电话号码"];
        return;
    }
    else if(![self.regionString kr_isNotEmpty]){
        [FNTipsView showTips:@"请选择地区"];
        return;
    }
    else if(![self.detailedAddressString kr_isNotEmpty]){
        [FNTipsView showTips:@"请填写详细地址"];
        return;
    }
    
    [self apiRequestPreserveSite];
    
    
}
#pragma mark - 选择结果通知
- (void)tongzhi:(NSNotification *)noti{ 
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *siteString = [defaults objectForKey:XYAddress];
    XYLog(@"siteString:%@",siteString);
    //省
    self.provinceString = [defaults objectForKey:XYProvince];
    //市
    self.cityString = [defaults objectForKey:XYCity];
    //县
    self.districtString = [defaults objectForKey:XYDistrict];
    //街道
    self.areaString = @"";
    if([siteString kr_isNotEmpty]){
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2  inSection:0];
        FNLocationItemNameNeCell* cell = (FNLocationItemNameNeCell *)[self.jm_tableview cellForRowAtIndexPath:indexPath];
        cell.rightLabel.text=siteString;
        self.regionString=siteString;
    }
  
    //[self postUserInfo:[noti.userInfo objectForKey:@"isPhone"]];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 单元
-(void)AddLocationTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.jm_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 1, FNDeviceWidth, FNDeviceHeight) style:UITableViewStylePlain];
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self; 
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.estimatedRowHeight = 0;
        self.jm_tableview.estimatedSectionFooterHeight = 0;
        self.jm_tableview.estimatedSectionHeaderHeight= 0;
        self.jm_tableview.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:self.jm_tableview];
    self.jm_tableview.backgroundColor=FNColor(240,240,240);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==4){
        FNRedactDefaultNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"RedactDefaultNeCell"];
        if (cell == nil) {
            cell = [[FNRedactDefaultNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RedactDefaultNeCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.indexPath=indexPath;
        cell.delegate=self;
        cell.model=self.editModel;
        return cell;
    }else if(indexPath.row==3){
        FNMinuteLocationNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MinuteLocationNeCell"];
        if (cell == nil) {
            cell = [[FNMinuteLocationNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MinuteLocationNeCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.indexPath=indexPath;
        cell.delegate=self;
        if(self.editBo==1){
            cell.placeholderLabel.hidden = YES;
            cell.siteView.text=self.editModel.address;
        }
        return cell;
    }else{
        FNLocationItemNameNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"LocationItemNameNeCell"];
        if (cell == nil) {
            cell = [[FNLocationItemNameNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LocationItemNameNeCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate=self;
        cell.indexPath=indexPath;
        if(indexPath.row==0){
            cell.NameText.placeholder = @"收货人";
            cell.rightLabel.hidden=YES;
            cell.directionImage.hidden=YES;
            if(self.editBo==1){
              cell.NameText.placeholder = @"";
              cell.NameText.text=self.editModel.name;
            }
        }
        else if(indexPath.row==1){
            cell.NameText.placeholder = @"手机号码";
            cell.rightLabel.text=@"+86";
            cell.rightLabel.hidden=NO;
            cell.directionImage.hidden=NO;
            if(self.editBo==1){
                cell.NameText.placeholder = @"";
                cell.NameText.text=self.editModel.phone;
            }
        }
        else if(indexPath.row==2){
            cell.NameText.placeholder = @"所在地区";
            cell.rightLabel.text=@"请选择";
            [cell.NameText setEnabled:NO];
            cell.rightLabel.hidden=NO;
            cell.directionImage.hidden=NO;
            if(self.editBo==1){
                cell.rightLabel.text=[NSString stringWithFormat:@"%@%@%@",self.editModel.province,self.editModel.city,self.editModel.district];
            }
        }
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==3){
        return 100;
    }else{
        return 50;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==2){
        GetProvinceViewController *vc = [[GetProvinceViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.navigationController.navigationBarHidden = NO;
        vc.title = @"选择省份";
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark -  FNLocationItemNameNeCellDelegate   编辑
- (void)InHeadCopyreaderAction:(NSIndexPath *)indexPath withContent:(NSString*)string{
    NSLog(@"string:%@",string);
    //FNLocationItemNameNeCell* cell = (FNLocationItemNameNeCell *)[self.jm_tableview cellForRowAtIndexPath:indexPath];
    if(indexPath.row==0){
       self.nameString=string;
    }
    else if(indexPath.row==1){
       self.numberString=string;
    }
    
}
#pragma mark - FNMinuteLocationNeCellDelegate  详细地址编辑
- (void)InDetaileRedactSiteAction:(NSIndexPath *)indexPath withSite:(NSString*)string{
     self.detailedAddressString=string;
}
#pragma mark - FNRedactDefaultNeCellDelegate   默认
- (void)InRedactDefaultAction:(NSIndexPath *)indexPath withDefault:(NSString*)type{
    self.defaultString=type;
}

#pragma mark - //保存或新建地址
- (void)apiRequestPreserveSite{
   @WeakObj(self);
    NSString *siteID=@"";
    if(self.editBo==1){
        siteID=self.editModel.id;
    }
    [SVProgressHUD show];
    NSString *token = UserAccessToken;
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":token,@"name":self.nameString,@"phone":self.numberString,@"is_acquiesce":self.defaultString,@"province":self.provinceString,@"city":self.cityString,@"district":self.districtString,@"area":@"",@"address":self.detailedAddressString}];
    if([siteID kr_isNotEmpty]){
        params[@"id"]=siteID;
    }
    [FNRequestTool requestWithParams:params api:@"mod=appapi&act=update_goods&ctrl=add_address" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"地址:%@",respondsObject);
        if ([selfWeak.delegate respondsToSelector:@selector(selectPreserveMaybeNewAction)] ) {
            [selfWeak.delegate selectPreserveMaybeNewAction];
        }
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *error) {
        [self apiRequestPreserveSite];
    } isHideTips:NO];
}
@end
