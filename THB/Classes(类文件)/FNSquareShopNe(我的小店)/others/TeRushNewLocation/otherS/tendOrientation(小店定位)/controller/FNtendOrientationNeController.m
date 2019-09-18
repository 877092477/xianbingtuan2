//
//  FNtendOrientationNeController.m
//  69橙子
//
//  Created by 李显 on 2018/12/9.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNtendOrientationNeController.h"
#import "ZYPinYinSearch.h"
#import "ButtonGroupView.h"
#import "PinYinForObjc.h"

#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "FNCityDeNeModel.h"
#define KSectionIndexBackgroundColor  [UIColor clearColor] //索引试图未选中时的背景颜色
#define kSectionIndexTrackingBackgroundColor [UIColor clearColor]//索引试图选中时的背景
#define kSectionIndexColor [UIColor grayColor]//索引试图字体颜色
#define HotBtnColumns 3 //每行显示的热门城市数
#define BGCOLOR [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]

@interface FNtendOrientationNeController ()<UIGestureRecognizerDelegate,UISearchBarDelegate,UITextFieldDelegate,ButtonGroupViewDelegate,MAMapViewDelegate>
{
    UIImageView   *_bgImageView;
    UIView        *_tipsView;
    UILabel       *_tipsLab;
    NSTimer       *_timer;
}
@property (strong, nonatomic) UITextField *searchText;

@property (strong, nonatomic) NSMutableDictionary *searchResultDic;

@property (strong, nonatomic) ButtonGroupView *locatingCityGroupView;//定位城市试图

@property (strong, nonatomic) ButtonGroupView *hotCityGroupView;//热门城市

@property (strong, nonatomic) ButtonGroupView *historicalCityGroupView; //历史使用城市/常用城市

@property (strong, nonatomic) UIView *tableHeaderView;

@property (nonatomic ,strong) NSMutableArray *arrayCitys;   //城市数据

@property (nonatomic ,strong) NSMutableDictionary *cities;

@property (nonatomic ,strong) NSMutableArray *keys; //城市首字母

@property (nonatomic ,strong) UIButton *orientationButton;

@property (nonatomic ,strong) UIButton *lictionImgButton;

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;
@property (nonatomic, strong) CLLocation *curenPlace;
@property (nonatomic, strong) NSString  *latitude;
@property (nonatomic, strong) NSString  *longitude;
//接口返回
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIView *topAddsView;
@end

@implementation FNtendOrientationNeController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.arrayHotCity = [NSMutableArray array];
        self.arrayHistoricalCity = [NSMutableArray array];
        self.arrayLocatingCity   = [NSMutableArray array];
        self.keys = [NSMutableArray array];
        self.arrayCitys = [NSMutableArray array];
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    UINavigationBar *bar = [UINavigationBar appearance];
    //设置显示的颜色
    bar.barTintColor =[UIColor whiteColor];
    [self backButtonAction];
}

-(void)backButtonAction{
    if ([self.delegate respondsToSelector:@selector(didCityWithLongitude:withLatitude:)]) {
        //[self.delegate didCityWithLongitude:self.longitude withLatitude:self.latitude];
        [_delegate didCityWithLongitude:self.longitude withLatitude:self.latitude withModel:self.model];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"添加城市";
    self.view.backgroundColor =[UIColor whiteColor];
    [self apiRequestCityStoreList];
    [self lictionDrawView];
    //[self setNavigationWithTitle:@"选择城市"];
    [self getCityData];
    
    self.topAddsView=[[UIView alloc]init];
    self.topAddsView.cornerRadius=5;
    self.topAddsView.backgroundColor=[UIColor whiteColor];
    
    //UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    //searchView.backgroundColor = RGB(1, 172, 243);
    //UIImageView *searchBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"FN_storehomeRighit"]];
    //searchBg.frame = CGRectMake(20, 35/2, 15, 15);
    //[searchView addSubview:searchBg];
    
    //搜索框
    _searchText = [[UITextField alloc]initWithFrame:CGRectMake(60, 5, self.view.frame.size.width-120, 35)];
    _searchText.backgroundColor = [UIColor whiteColor];
    _searchText.font = [UIFont systemFontOfSize:13];
    _searchText.placeholder  = @" 请输入城市名称";
    _searchText.returnKeyType = UIReturnKeySearch;
    _searchText.textColor    = [UIColor colorWithRed:58/255.0 green:58/255.0 blue:58/255.0 alpha:1];
    _searchText.delegate     = self;
    [_searchText addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    _searchText.cornerRadius=5;
    _searchText.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
   
    //[_searchText setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    [_searchText setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    NSMutableParagraphStyle *style = [_searchText.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    
    style.minimumLineHeight = _searchText.font.lineHeight - (_searchText.font.lineHeight - [UIFont systemFontOfSize:14.0].lineHeight) / 2.0;
    
    _searchText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" 请输入城市名称"attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:58/255.0f green:58/255.0f blue:58/255.0f alpha:0.7f], NSFontAttributeName : [UIFont systemFontOfSize:13.0],NSParagraphStyleAttributeName : style}];
     //[searchView addSubview:_searchText];
    if(self.topStyle==0){
        self.topAddsView.frame=CGRectMake(60, 5, self.view.frame.size.width-120, 35);
        _searchText.frame=CGRectMake(10, 0, FNDeviceWidth-140, 35);
        [self.topAddsView addSubview:_searchText];
        self.navigationItem.titleView=self.topAddsView;
    }
    if(self.topStyle==1){
        self.title = @"所在城市";
        _searchText.placeholder  = @" 输入城市名或首字母进行查询";
    }
    
    //[self.view addSubview:searchView];
    
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.frame= CGRectMake(0,0, self.view.frame.size.width, FNDeviceHeight-SafeAreaTopHeight);
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate= self;
    _tableView.dataSource= self;
    _tableView.sectionFooterHeight=0;
    [self.view addSubview:_tableView];
    
    [self ininHeaderView];
    
    //添加单击事件 取消键盘第一响应
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignFirstResponder:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
    self.tableView.sectionIndexColor =  [UIColor clearColor];
   
    self.tableView.sectionIndexTrackingBackgroundColor =  [UIColor clearColor];
    
    UINavigationBar *bar = [UINavigationBar appearance];
    //设置显示的颜色
    bar.barTintColor = RGB(1, 172, 243);
    if(self.topStyle==1){
       bar.barTintColor = [UIColor whiteColor];
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//如果当前是tableView
        return NO;
    }
    return YES;
}
#pragma mark - 编辑
- (void)textChange:(UITextField*)textField{
    [self filterContentForSearchText:textField.text];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)resignFirstResponder:(UITapGestureRecognizer*)tap{
    [_searchText resignFirstResponder];
}
#pragma mark - tableHeaderView
- (void)ininHeaderView{
    _tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 250)];
    _tableHeaderView.backgroundColor = [UIColor clearColor];
    _tableHeaderView.backgroundColor=[UIColor whiteColor];
    
    //定位城市
    //UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 160, 21)];
    //title1.text = @"定位城市";
    //title1.font = [UIFont systemFontOfSize:15];
    //[_tableHeaderView addSubview:title1];
    UIView *whitedView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    whitedView.backgroundColor=[UIColor whiteColor];
    [_tableHeaderView addSubview:whitedView];
    
    //图片
    self.lictionImgButton= [UIButton buttonWithType:UIButtonTypeCustom];
    self.lictionImgButton.frame=CGRectMake(10, 35/2, 15, 15);
    [self.lictionImgButton setImage:IMAGE(@"details_orientation") forState:UIControlStateNormal];
    [self.lictionImgButton addTarget:self action:@selector(orientationAction) forControlEvents:UIControlEventTouchUpInside];
    [whitedView addSubview:self.lictionImgButton];
 
    
    self.orientationButton= [UIButton buttonWithType:UIButtonTypeCustom];
    self.orientationButton.frame=CGRectMake(30, 10, 15, 15);
    self.orientationButton.titleLabel.font=kFONT14;
    [self.orientationButton addTarget:self action:@selector(orientationAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orientationButton setTitle:@"定位中" forState:UIControlStateNormal];
    [self.orientationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [whitedView addSubview:self.orientationButton];
    
    self.orientationButton.sd_layout
    .leftSpaceToView(self.lictionImgButton, 5).centerYEqualToView(whitedView);
    [self.orientationButton setupAutoSizeWithHorizontalPadding:5 buttonHeight:25];
    
    
    //历史城市
    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(10, self.orientationButton.frame.origin.y+self.orientationButton.frame.size.height+10, 160, 21)];
    title2.text = @"历史访问城市";
    title2.font = [UIFont systemFontOfSize:15];
    [_tableHeaderView addSubview:title2];
    
    
    long rowHistorical = _arrayHistoricalCity.count/3;
    if (_arrayHistoricalCity.count%3 > 0) {
        rowHistorical += 1;
    }
    CGFloat hisViewHight = 45*rowHistorical;
    _historicalCityGroupView = [[ButtonGroupView alloc]initWithFrame:CGRectMake(0, title2.frame.origin.y+title2.frame.size.height+10, _tableHeaderView.frame.size.width, hisViewHight)];
    _historicalCityGroupView.backgroundColor = [UIColor clearColor];
    _historicalCityGroupView.delegate = self;
    _historicalCityGroupView.columns = 3;
    _historicalCityGroupView.items = [self GetCityDataSoucre:_arrayHistoricalCity];
    [_tableHeaderView addSubview:_historicalCityGroupView];
    
    
    _tableHeaderView.frame = CGRectMake(0, 0, _tableView.frame.size.width, _historicalCityGroupView.frame.origin.y+_historicalCityGroupView.frame.size.height);
    _tableView.tableHeaderView.frame = _tableHeaderView.frame;
    _tableView.tableHeaderView = _tableHeaderView;
    
    if(self.topStyle==1){
        _tableView.rowHeight=55;
        _tableView.frame=CGRectMake(0, 40, FNDeviceWidth, FNDeviceHeight-40);
        self.topAddsView.frame=CGRectMake(15, 6, FNDeviceWidth-30, 35);
        [self.view addSubview:self.topAddsView];
        [self.topAddsView addSubview:_searchText];
        self.view.backgroundColor=RGB(250, 250, 250);
        _searchText.frame=CGRectMake(30, 0, FNDeviceWidth-90, 35);
        _searchText.tintColor=[UIColor lightGrayColor];
        _tableHeaderView.backgroundColor=RGB(250, 250, 250);
        whitedView.backgroundColor=RGB(250, 250, 250);
        UIImageView *searImgView=[[UIImageView alloc]init];
        [self.topAddsView addSubview:searImgView];
        searImgView.image=IMAGE(@"FJ_slices_img");
        searImgView.frame=CGRectMake(10, 10, 15, 15);
    }
    
}
//点击返回
-(void)orientationAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSArray*)GetCityDataSoucre:(NSArray*)ary
{
    NSMutableArray *cityAry = [[NSMutableArray alloc]init];
    for (NSString*cityName in ary) {
        [cityAry addObject: [CityItem initWithTitleName:cityName]];
    }
    
    return cityAry;
}

#pragma mark - 获取城市数据
-(void)getCityData
{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"citydict"
                                                   ofType:@"plist"];
    self.cities = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    [_keys addObjectsFromArray:[[self.cities allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    
    //    //添加热门城市
    //    NSString *strHot = @"#";
    //    [self.keys insertObject:strHot atIndex:0];
    //    [self.cities setObject:_arrayHotCity forKey:strHot];
    
    NSArray *allValuesAry = [self.cities allValues];
    for (NSArray*oneAry in allValuesAry) {
        
        for (NSString *cityName in oneAry) {
            [_arrayCitys addObject:cityName];
        }
    }
}

#pragma mark - Header
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat headHeight=20;
    if(self.topStyle==1){
        headHeight=30;
    }
    return headHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 20)];
    bgView.backgroundColor = BGCOLOR;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 250, 20)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 19, bgView.frame.size.width, 1)];
    line.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    
    if(self.topStyle==1){
        titleLabel.frame=CGRectMake(16, 5, 250, 20);
        bgView.backgroundColor = RGB(250, 250, 250);
        line.backgroundColor = RGB(250, 250, 250);
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textColor = RGB(153, 153, 153);
    }
    
    
    NSString *key = [_keys objectAtIndex:section];
    
    titleLabel.text = key;
    [bgView addSubview:line];
    
    [bgView addSubview:titleLabel];
    
    return bgView;
}
#pragma mark - rightViews
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    NSMutableArray *indexNumber = [NSMutableArray arrayWithArray:_keys];
    //    NSString *strHot = @"#";
    //    //添加搜索前的#号
    //    [indexNumber insertObject:strHot atIndex:0];
    return indexNumber;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    //    NSLog(@"title = %@",title);
    //[self showTipsWithTitle:title];
    
    return index;
}
#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [_keys count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *key = [_keys objectAtIndex:section];
    NSArray *citySection = [_cities objectForKey:key];
    return [citySection count];
    
//    NSArray *sectionArr=_dataArray[section];
//
//    return [sectionArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_tableView respondsToSelector:@selector(setSectionIndexColor:)]) {
        _tableView.sectionIndexBackgroundColor = KSectionIndexBackgroundColor;  //修改索引试图未选中时的背景颜色
        _tableView.sectionIndexTrackingBackgroundColor = kSectionIndexTrackingBackgroundColor;//修改索引试图选中时的背景颜色
        _tableView.sectionIndexColor = kSectionIndexColor;//修改索引试图字体颜色
    }
    
    static NSString *CellIdentifier = @"Cell";
    
    NSString *key = [_keys objectAtIndex:indexPath.section];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        cell.backgroundColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.textLabel setTextColor:[UIColor blackColor]];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        if(self.topStyle==1){
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            [cell.textLabel setTextColor:RGB(51, 51, 51)];
        }
    }
    cell.textLabel.text = [[_cities objectForKey:key] objectAtIndex:indexPath.row];
    
//    NSArray *sectionArr=_dataArray[indexPath.section];
//    FNCityDeNeModel *model=[FNCityDeNeModel mj_objectWithKeyValues:sectionArr[indexPath.row]];
//    cell.textLabel.text =model.CityName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *key = [_keys objectAtIndex:indexPath.section];
    NSString *cityName = [[_cities objectForKey:key] objectAtIndex:indexPath.row];
    
    //NSArray *sectionArr=_dataArray[indexPath.section];
    //FNCityDeNeModel *model=[FNCityDeNeModel mj_objectWithKeyValues:sectionArr[indexPath.row]];
    //XYLog(@"CityName:%@",model.CityName);
    if (_delegate) {
        //[_delegate didClickedWithCityName:cityName];
        
    }
    
    [self initCityName:cityName];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSArray *arr = [defaults objectForKey:@"arrayHistoricalCity"];
    
    NSMutableArray *arrallAry=[NSMutableArray arrayWithCapacity:0];
    for (NSString *string in arr) {
            [arrallAry addObject:string];
    }
    if([arr containsObject: cityName]){
        NSInteger place=[arr indexOfObject:cityName];
        [arrallAry removeObjectAtIndex:place];
    }
    NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
    
    if(arrallAry.count>=0 && arrallAry.count<6){
        [arrM addObject:cityName];
        for (NSString *string in arrallAry) {
            [arrM addObject:string];
        }
    }else if(arrallAry.count==6){
        [arrM addObject:cityName];
        [arrallAry removeObjectAtIndex:5];
        for (NSString *string in arrallAry) {
            [arrM addObject:string];
        }
    }
    
    [defaults setObject:arrM forKey:@"arrayHistoricalCity"];
    [defaults synchronize];
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 点击热门城市 无数据
-(void)ButtonGroupView:(ButtonGroupView *)buttonGroupView didClickedItem:(CityButton *)item
{
    if (_delegate) {
        
        //[_delegate didClickedWithCityName:item.cityItem.titleName];
    }
     [self initCityName:item.cityItem.titleName];
     [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -  检索
-(void)initCityName:(NSString*)string{
    FNCityDeNeModel *seletedmodel=[[FNCityDeNeModel alloc]init];
    for(FNCityDeNeModel *itemmodel in _dataArray){
        if([string isEqualToString:itemmodel.CityName]){
            self.model=itemmodel;
        }
    }
    XYLog(@"seletedmodelCityName:%@",seletedmodel.CityName);
    //if (_delegate) {
        //[_delegate didCityWithLongitude:@"" withLatitude:@"" withModel:self.model];
    //}
}


NSInteger cityNameSort(id str1, id str2, void *context)
{
    NSString *string1 = (NSString*)str1;
    NSString *string2 = (NSString*)str2;
    
    return  [string1 localizedCompare:string2];
}
/**
 *  通过搜索条件过滤得到搜索结果
 *
 *  @param searchText 关键词
 *  @param scope      范围
 */
- (void)filterContentForSearchText:(NSString*)searchText {
    
    if (searchText.length > 0) {
        _searchResultDic = nil;
        _searchResultDic = [[NSMutableDictionary alloc]init];
        
        //搜索数组中是否含有关键字
        NSArray *resultAry  = [ZYPinYinSearch searchWithOriginalArray:_arrayCitys andSearchText:searchText andSearchByPropertyName:@""];
        //     NSLog(@"搜索结果:%@",resultAry) ;
        
        for (NSString*city in resultAry) {
            //获取字符串拼音首字母并转为大写
            NSString *pinYinHead = [PinYinForObjc chineseConvertToPinYinHead:city].uppercaseString;
            NSString *firstHeadPinYin = [pinYinHead substringToIndex:1]; //拿到字符串第一个字的首字母
            //        NSLog(@"pinYin = %@",firstHeadPinYin);
            
            
            NSMutableArray *cityAry = [NSMutableArray arrayWithArray:[_searchResultDic objectForKey:firstHeadPinYin]]; //取出首字母数组
            
            if (cityAry != nil) {
                
                [cityAry addObject:city];
                
                NSArray *sortCityArr = [cityAry sortedArrayUsingFunction:cityNameSort context:NULL];
                [_searchResultDic setObject:sortCityArr forKey:firstHeadPinYin];
                
            }else
            {
                cityAry= [[NSMutableArray alloc]init];
                [cityAry addObject:city];
                NSArray *sortCityArr = [cityAry sortedArrayUsingFunction:cityNameSort context:NULL];
                [_searchResultDic setObject:sortCityArr forKey:firstHeadPinYin];
            }
            
        }
        //    NSLog(@"dic = %@",dic);
        
        if (resultAry.count>0) {
            _cities = nil;
            _cities = _searchResultDic;
            XYLog(@"_cities%@",_cities);
            [_keys removeAllObjects];
            //按字母升序排列
            [_keys addObjectsFromArray:[[self.cities allKeys] sortedArrayUsingSelector:@selector(compare:)]] ;
            _tableView.tableHeaderView = nil;
            [_tableView reloadData];
        }
        
    }else
    {
        //当字符串清空时 回到初始状态
        _cities = nil;
        [_keys removeAllObjects];
        [_arrayCitys removeAllObjects];
        //[self getCityData];
        [self apiRequestCityStoreList];
        _tableView.tableHeaderView = _tableHeaderView;
        [_tableView reloadData];
    }
    
}
#pragma mark - 定位
-(void)lictionDrawView{
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    self.mapView.hidden=YES;
    [self.view addSubview:self.mapView];
    self.mapView.showsScale= NO;
    
    self.mapView.showsUserLocation = YES;
    
    self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;

    self.mapView.desiredAccuracy = kCLLocationAccuracyBest;
    
    MAUserLocationRepresentation *represent = [[MAUserLocationRepresentation alloc] init];
    represent.showsAccuracyRing = YES;
    represent.showsHeadingIndicator = YES;
    represent.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:.3];
    represent.strokeColor = [UIColor lightGrayColor];;
    represent.lineWidth = 2.f;
    represent.image = [UIImage imageNamed:@"userPosition"];
    [self.mapView updateUserLocationRepresentation:represent];
}
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    //userLocation 就是用户当前的位置信息，通过userLocation 可以获取当前的经纬度信息及详细的地理位置信息，方法如下：//创建一个经纬度点：
    MAPointAnnotation *point = [[MAPointAnnotation alloc] init];
    //设置点的经纬度
    point.coordinate = userLocation.location.coordinate;
    CLLocation *currentLocation = [[CLLocation alloc]initWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
    // 初始化编码器
    self.latitude=[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
    self.longitude=[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        //获取当前城市位置信息，其中CLPlacemark包括name、thoroughfare、subThoroughfare、locality、subLocality等详细信息
        CLPlacemark *mark = [placemarks lastObject];
        NSString *cityName = mark.locality;//
        //NSLog(@"定位城市 - :%@", cityName);
        if([cityName kr_isNotEmpty]){
           [self.orientationButton setTitle:cityName forState:UIControlStateNormal];
            if (_delegate) {
                [_delegate didClickedWithCityName:cityName];
            }
        }
        //self.currentCity  = cityName;
        self.model.CityName=cityName;
        self.model.CityID=@"";
        
    }];
    
}
- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    XYLog(@"定位失败:%@",error);
    [self.orientationButton setTitle:@"定位失败,请稍后重试" forState:UIControlStateNormal];
}

//获取城市列表
- (FNRequestTool *)apiRequestCityStoreList{
    [self.jm_collectionview.mj_footer endRefreshing];
    [self.jm_collectionview.mj_header endRefreshing];
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
   
   
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=rebate_address&ctrl=city_list" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        XYLog(@"城市列表:%@",respondsObject);
        NSArray* arrM = respondsObject[DataKey];
        NSMutableArray *arrList=[NSMutableArray arrayWithCapacity:0];
        NSMutableArray *keyMarr=[NSMutableArray arrayWithCapacity:0];
        NSMutableArray *Allarr=[NSMutableArray arrayWithCapacity:0];
        NSMutableDictionary *alldic=[[NSMutableDictionary alloc]init];
        NSMutableArray *addmModel=[NSMutableArray arrayWithCapacity:0];
        for (NSArray *arr in arrM) {
            NSString *keyString=arr[0] [@"frist"];
            NSMutableArray *itemArr=[NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *dictry in arr) {
                FNCityDeNeModel *model=[FNCityDeNeModel mj_objectWithKeyValues:dictry];
                [Allarr addObject:model.CityName];
                [itemArr addObject:model.CityName];
                [addmModel addObject:model];
            }
            [keyMarr addObject:keyString];
            [arrList addObject:arr];
            alldic[keyString]=itemArr;
        }
        selfWeak.keys=keyMarr;
        selfWeak.dataArray=addmModel;
        selfWeak.arrayCitys=Allarr;
        selfWeak.cities=alldic;
        [self.tableView reloadData];
        XYLog(@"key:%@",keyMarr);
        XYLog(@"alldic:%@",alldic);
     //keys
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


#pragma mark -  //未使用 提示
- (void)showTipsWithTitle:(NSString*)title
{
    //获取当前屏幕window
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //添加黑色透明背景
    //    if (!_bgImageView) {
    //        _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, window.frame.size.width, window.frame.size.height)];
    //        _bgImageView.backgroundColor = [UIColor blackColor];
    //        _bgImageView.alpha = 0.1;
    //        [window addSubview:_bgImageView];
    //    }
    if (!_tipsView) {
        //添加字母提示框
        _tipsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        _tipsView.center = window.center;
        _tipsView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:0.8];
        //设置提示框圆角
        _tipsView.layer.masksToBounds = YES;
        _tipsView.layer.cornerRadius  = _tipsView.frame.size.width/20;
        _tipsView.layer.borderColor   = [UIColor whiteColor].CGColor;
        _tipsView.layer.borderWidth   = 2;
        [window addSubview:_tipsView];
    }
    if (!_tipsLab) {
        //添加提示字母lable
        _tipsLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _tipsView.frame.size.width, _tipsView.frame.size.height)];
        //设置背景为透明
        _tipsLab.backgroundColor = [UIColor clearColor];
        _tipsLab.font = [UIFont boldSystemFontOfSize:50];
        _tipsLab.textAlignment = NSTextAlignmentCenter;
        
        [_tipsView addSubview:_tipsLab];
    }
    _tipsLab.text = title;//设置当前显示字母
    
    //    [self performSelector:@selector(hiddenTipsView:) withObject:nil afterDelay:0.3];
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [self hiddenTipsView];
    //    });
    
    
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(hiddenTipsView) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
}

- (void)hiddenTipsView
{
    
    [UIView animateWithDuration:0.2 animations:^{
        _bgImageView.alpha = 0;
        _tipsView.alpha = 0;
    } completion:^(BOOL finished) {
        [_bgImageView removeFromSuperview];
        [_tipsView removeFromSuperview];
        _bgImageView = nil;
        _tipsLab     = nil;
        _tipsView    = nil;
    }];
}
//未使用导航
- (void)setNavigationWithTitle:(NSString *)title
{
    //自定义导航栏
    UIView *customNavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    customNavView.backgroundColor = BGCOLOR;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(20, 27, 30, 30);
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [customNavView addSubview:backBtn];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, customNavView.frame.size.width, customNavView.frame.size.height-20)];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text          = title;
    [customNavView addSubview:titleLab];
    
    
    [self.view addSubview:customNavView];
}

- (void)backBtnClick:(UIButton*)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
