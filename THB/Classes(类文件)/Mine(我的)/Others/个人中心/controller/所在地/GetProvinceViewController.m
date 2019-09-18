//
//  GetProvinceViewController.m
//  THB
//
//  Created by zhongxueyu on 16/5/10.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "GetProvinceViewController.h"
#import "SettingCell.h"
#import "GetCityModel.h"
#import "CityModel.h"
#import "DistrictModel.h"
#import "ProfileViewController.h"
@interface GetProvinceViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *xy_TableView;

/** 数据数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString *province;

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *district;

@end

@implementation GetProvinceViewController
@synthesize xy_TableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == 0) {
        self.title = @"选择省份";
    }else if (self.type == 1){
        
        self.title = @"选择城市";
    }
    else if (self.type == 2){
        self.title = @"选择地区";
    }
    
    [self getCityInfoMethod: self.type];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:XYDistrict];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:XYCity];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:XYProvince];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



#pragma mark 初始化界面
-(void)initTableView{
    if(!xy_TableView){
        xy_TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, XYScreenHeight-XYNavBarHeigth) style:UITableViewStylePlain];
        xy_TableView.dataSource=self;
        xy_TableView.delegate=self;
        xy_TableView.showsVerticalScrollIndicator = NO;
        xy_TableView.showsHorizontalScrollIndicator = YES;
        xy_TableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        xy_TableView.estimatedSectionHeaderHeight = 0;
        xy_TableView.sectionHeaderHeight = 0;
        xy_TableView.estimatedSectionFooterHeight = 0;
        xy_TableView.sectionFooterHeight = 0;
        [self.view addSubview:xy_TableView];
        
        if (@available(iOS 11.0, *)) {
            xy_TableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    
    
}

#pragma mark 配置TableView数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.dataArray.count>0)
    {
        return self.dataArray.count;
    }
    
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *ID = @"SettingCell";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([SettingCell class]) bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:ID];
        nibsRegistered = YES;
    }
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (self.dataArray.count>0) {
        if (self.type == 0) {
            GetCityModel *model = self.dataArray[indexPath.row];
            cell.leftLbl.text = model.ProvinceName;
        }else if (self.type == 1){
            CityModel *model = self.dataArray[indexPath.row];
            cell.leftLbl.text = model.CityName;
        }
        else if (self.type == 2){
            DistrictModel *model = self.dataArray[indexPath.row];
            cell.leftLbl.text = model.DistrictName;
        }
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.dataArray.count>0) {
        if (self.type == 0) {
            GetCityModel *model = self.dataArray[indexPath.row];
            self.province = model.ProvinceName;
            [[NSUserDefaults standardUserDefaults] setValue:self.province forKey:XYProvince];
            [[NSUserDefaults standardUserDefaults] synchronize];
            self.title = @"选择城市";
            self.selectId = [model.ProvinceID intValue];
            [self getCityInfoMethod: 1];
            
        }else if (self.type == 1){
            CityModel *model = self.dataArray[indexPath.row];
            self.city = model.CityName;
            [[NSUserDefaults standardUserDefaults] setValue:self.city forKey:XYCity];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            self.title = @"选择地区";
            
            self.selectId = [model.CityID intValue];
            [self getCityInfoMethod: 2];;
        }else if (self.type == 2){
            DistrictModel *model = self.dataArray[indexPath.row];
            self.district = model.DistrictName;
            [[NSUserDefaults standardUserDefaults] setValue:self.district forKey:XYDistrict];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self finishSelectedAddress];
        }
        
    }

}

- (void) finishSelectedAddress{
    self.address = [NSString stringWithFormat:@"%@%@%@",UserProvince,UserCity,UserDistrict];
    [[NSUserDefaults standardUserDefaults] setValue:self.address forKey:XYAddress];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSNotification *notification =[NSNotification notificationWithName:@"EditProfile" object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getCityInfoMethod: (NSInteger)type {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    NSString *url ;
    
    if (type == 0) {
        url = _api_home_getProvince;
    }else if (type == 1){
        params[@"id"] = @(_selectId);
        url = _api_home_getCity;
    }
    else if (type == 2){
        params[@"id"] = @(_selectId);
        url = _api_home_getDistrict;
    }
    
    [SVProgressHUD show];
    @weakify(self);
    NSString *modelType = @"GetCityModel";
    if (type == 1) {
        modelType = @"CityModel";
    } else if (type == 2) {
        modelType = @"DistrictModel";
    }
    [self.dataArray removeAllObjects];
    [self.xy_TableView reloadData];
    [FNRequestTool requestWithParams:params api:url respondType:(ResponseTypeArray) modelType:modelType success:^(id respondsObject) {
        @strongify(self);
        self.type = type;
        self.dataArray = respondsObject;
        if (self.dataArray.count <= 0) {
            [self finishSelectedAddress];
        }
        [self initTableView];
        [xy_TableView reloadData];
        [SVProgressHUD dismiss];
        
    } failure:^(NSString *error) {
        //
    } isHideTips:NO];
    
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


@end
