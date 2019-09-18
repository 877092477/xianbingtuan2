//
//  FNRushLocationNewDaController.m
//  69橙子
//
//  Created by Jimmy on 2018/11/30.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//小店新建地址
#import "FNRushLocationNewDaController.h"
//view
#import "FNRushConsigneeNameNeCell.h"
#import "FNRushConsigneeOtherNeCell.h"
#import "FNRushConsigneeDetailNeCell.h"
#import "FNRushConsigneeDefaultNeCell.h"
#import "FNRushConsigneeSaveNeCell.h"
//controller
#import "FNrushMessageDeController.h"
#import "FNRushLocationDeViewController.h"
#import "FNrushPhoneListDeController.h"

@interface FNRushLocationNewDaController ()<UITableViewDelegate,UITableViewDataSource,FNRushConsigneeNameNeCellDelegate,FNRushConsigneeOtherNeCellDelegate,FNRushConsigneeDetailNeCellDelegate,FNRushConsigneeDefaultNeCellDelegate,FNRushConsigneeSaveNeCellDelegate,FNrushPhoneListDeControllerDelegate,FNRushLocationDeViewControllerDelegate>

@end

@implementation FNRushLocationNewDaController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"新增地址";
    

    
    [self rushAddLocationTableView];
}
#pragma mark - 单元
-(void)rushAddLocationTableView{
    CGFloat tableHeight=FNDeviceHeight-SafeAreaTopHeight-1;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.jm_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, tableHeight) style:UITableViewStylePlain];
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.rowHeight=100;
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
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //FNrushSiteDaNeModel *model=[[FNrushSiteDaNeModel alloc]init];
    if(indexPath.row==0){
        FNRushConsigneeNameNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ConsigneeNameNeCellID"];
        if (cell == nil) {
            cell = [[FNRushConsigneeNameNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ConsigneeNameNeCellID"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate=self;
        cell.indexPath=indexPath;
        //if(self.addState==2){
            cell.model=self.addressModel;
        //}
        return cell; 
    }else if(indexPath.row==1 || indexPath.row==2){
        FNRushConsigneeOtherNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ConsigneeOtherNeCellID"];
        if (cell == nil) {
            cell = [[FNRushConsigneeOtherNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ConsigneeOtherNeCellID"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate=self;
        //if(self.addState==2){
            if(indexPath.row==1){
                if ([self.addressModel.phone kr_isNotEmpty]){
                    cell.NameText.text=self.addressModel.phone;
                }
            }
            if(indexPath.row==2){
                 if ([self.addressModel.long_address kr_isNotEmpty]){
                     cell.NameText.text=self.addressModel.long_address;
                 }
            }
        //}
        if(indexPath.row==2){
           [cell.NameText setEnabled:NO];
        }
        cell.rightState=indexPath.row;
        cell.indexPath=indexPath;
        return cell;
    }else if(indexPath.row==3){
        FNRushConsigneeDetailNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ConsigneeDetailNeCellID"];
        if (cell == nil) {
            cell = [[FNRushConsigneeDetailNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ConsigneeDetailNeCellID"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate=self;
        cell.indexPath=indexPath;
        //if(self.addState==2){
            if ([self.addressModel.long_address kr_isNotEmpty]){
                cell.siteView.text=self.addressModel.address;
                cell.placeholderLabel.hidden=YES;
            }
        //}
        return cell;
    }else if(indexPath.row==4){
        FNRushConsigneeDefaultNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ConsigneeDefaultNeCellID"];
        if (cell == nil) {
            cell = [[FNRushConsigneeDefaultNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ConsigneeDefaultNeCellID"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate=self;
        cell.indexPath=indexPath;
        //if(self.addState==2){
             if ([self.addressModel.is_check kr_isNotEmpty]){
                 if ([self.addressModel.is_check integerValue]==1) {
                    [cell.defaultSwitch setOn:YES];
                    cell.defaultSwitch.thumbTintColor =[UIColor whiteColor];
                 }else{
                    [cell.defaultSwitch setOn:NO];
                    cell.defaultSwitch.thumbTintColor =RGB(1, 172, 243);
                 }
             }
            
        //}
        return cell;
    }else{
        FNRushConsigneeSaveNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SiteItemDaNeCellID"];
        if (cell == nil) {
            cell = [[FNRushConsigneeSaveNeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SiteItemDaNeCellID"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate=self;
        return cell;
    }
   
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==2){
        FNHsearchModel *model=[[FNHsearchModel alloc]init];
        FNRushLocationDeViewController *vc=[[FNRushLocationDeViewController alloc]init];
        vc.delegate=self;
        vc.locationModel=model;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 90;
    } else{
        return 70;
    }
}
#pragma mark - FNRushConsigneeNameNeCellDelegate 编辑名字性别
//编辑名字性别
- (void)InConsigneeNameAction:(NSIndexPath *)indexPath withContent:(NSString*)string{
    XYLog(@"名字:%@",string);
    self.addressModel.name=string;
}
//选择性别
-(void)inConsigneechoicegender:(NSInteger)send{
    XYLog(@"性别:%ld",(long)send);
    self.addressModel.sex=send-1;
}
#pragma mark - FNRushConsigneeOtherNeCellDelegate 1:编辑电话  2:编辑地址
// 编辑电话
- (void)InOtherCopyreaderAction:(NSIndexPath *)indexPath withContent:(NSString*)string{
    XYLog(@"编辑电话地址:%@",string);
    self.addressModel.phone=string;
}
// 1:选择通讯录  2:选择地址
- (void)InOtherRightButtonActionR:(NSIndexPath *)indexPathR{
    XYLog(@"编辑电话地址:%ld",(long)indexPathR.row);
    if(indexPathR.row==1){
        FNrushPhoneListDeController *vc=[[FNrushPhoneListDeController alloc]init];
        vc.delegate=self;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if(indexPathR.row==2){
        FNHsearchModel *model=[[FNHsearchModel alloc]init];
        FNRushLocationDeViewController *vc=[[FNRushLocationDeViewController alloc]init];
        vc.delegate=self;
        vc.locationModel=model;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - FNRushConsigneeDetailNeCellDelegate 门牌号
- (void)InConsigneeDetailAction:(NSIndexPath *)indexPath withSite:(NSString*)string{
    XYLog(@"门牌号:%@",string);
    self.addressModel.address=string;
}
#pragma mark - FNRushConsigneeDefaultNeCellDelegate  设置默认
// 默认
- (void)InConsigneeDefaultAction:(NSIndexPath *)indexPath withDefault:(NSString*)type{
    XYLog(@"默认:%@",type);
    self.addressModel.is_check=type;
}
#pragma mark - //定位返回地址
-(void)inSelectLocationAction:(FNHsearchModel*)send{
    self.addressModel.long_address=send.address;
    self.addressModel.lat=[NSString stringWithFormat:@"%f",send.latitude];
    self.addressModel.lng=[NSString stringWithFormat:@"%f",send.longitude];
    [self.jm_tableview reloadData];
}
#pragma mark - FNRushConsigneeSaveNeCellDelegate 保存
// 保存
- (void)InConsigneeDefaultAction{
     XYLog(@"保存");
    if(![self.addressModel.name kr_isNotEmpty]){
        [FNTipsView showTips:@"姓名不能为空"];
    }
    else if(![self.addressModel.phone kr_isNotEmpty]){
        [FNTipsView showTips:@"电话不能为空"];
    }
    else if(![self.addressModel.long_address kr_isNotEmpty]){
        [FNTipsView showTips:@"请选择地址"];
    }
    else if(![self.addressModel.address kr_isNotEmpty]){
        [FNTipsView showTips:@"详细地址不能为空"];
    }
    else{
        if (self.addState==2) {
            if(![self.addressModel.is_check kr_isNotEmpty]){
                self.addressModel.is_check=@"0";
            }
            //修改
            [self apiRequestSiteModifier];
        }
        if (self.addState==1) {
            //添加
            if(![self.addressModel.is_check kr_isNotEmpty]){
                self.addressModel.is_check=@"0";
            }
            [self apiRequestSiteSaveAdd];
        }
    }
    
    
    
}

#pragma mark - FNrushPhoneListDeControllerDelegate  选择的电话
//选择电话
-(void)inSelectPhoneAction:(NSString*)send{
    XYLog(@"选择的电话:%@",send);
    self.addressModel.phone=send;
    [self.jm_tableview reloadData];
}
//添加收货地址
- (FNRequestTool *)apiRequestSiteSaveAdd{
    
    //@WeakObj(self);
    NSString *sexString=[NSString stringWithFormat:@"%ld",(long)self.addressModel.sex];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,@"name":self.addressModel.name,@"phone":self.addressModel.phone,@"is_check":self.addressModel.is_check,@"long_address":self.addressModel.long_address,@"address":self.addressModel.address,@"sex":sexString,@"lat":self.addressModel.lat,@"lng":self.addressModel.lng}];
    
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_address&ctrl=add" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"添加收货地址列表:%@",respondsObject);
        //NSArray* arrM = respondsObject[DataKey];
        NSInteger state=[respondsObject[SuccessKey] integerValue];
        if(state==1){
            [self backController];
        }else{
            [FNTipsView showTips:@"添加失败"];
        }
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}

//收货地址修改收货地址
- (FNRequestTool *)apiRequestSiteModifier{
    
    //@WeakObj(self);
    NSString *sexString=[NSString stringWithFormat:@"%ld",(long)self.addressModel.sex];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken,@"id":self.addressModel.id,@"name":self.addressModel.name,@"phone":self.addressModel.phone,@"is_check":self.addressModel.is_check,@"long_address":self.addressModel.long_address,@"address":self.addressModel.address,@"sex":sexString,@"lat":self.addressModel.lat,@"lng":self.addressModel.lng}];
    
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_address&ctrl=edit" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"修改地址:%@",respondsObject);
        //NSArray* arrM = respondsObject[DataKey];
        NSInteger state=[respondsObject[SuccessKey] integerValue];
        if(state==1){
           [self backController];
        }else{
           [FNTipsView showTips:@"修改失败"];
        }
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
-(void)backController{
    if ([self.delegate respondsToSelector:@selector(inLocationBackChoicegender)]) {
        [self.delegate inLocationBackChoicegender];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
