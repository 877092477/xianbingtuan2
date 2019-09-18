//
//  FNRelationUeController.m
//  THB
//
//  Created by 李显 on 2019/1/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//
//邀请好友发送
#import "FNRelationUeController.h"
//view
#import "FNrelationFlockItemUeCell.h"
#import "FNrelationPersonUeCell.h"
#import "FNrelationUeHeader.h"
#import "FNlinkmanCountUeFooter.h"

@interface FNRelationUeController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) UIView *SearchView;
@property(nonatomic,strong) UISearchBar* searchBar;
@end

@implementation FNRelationUeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"选择";
    [self topSearchView];
    [self invitationViews];
}
-(void)topSearchView{
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.delegate=self;
    self.searchBar.backgroundImage = [UIImage createImageWithColor:FNWhiteColor];
    self.searchBar.placeholder=@"搜索";
    [self.searchBar setBackgroundColor:FNWhiteColor];
    self.searchBar.backgroundImage = [UIImage createImageWithColor:FNWhiteColor];
    [self.view addSubview:self.searchBar];
    [self.searchBar setImage:IMAGE(@"FJ_slices_img") forSearchBarIcon:UISearchBarIconSearch  state:UIControlStateNormal];
    UITextField *searchField = [self.searchBar valueForKey:@"searchField"];
    if (searchField) {
        searchField.font=[UIFont systemFontOfSize:9];
        if ([self.searchBar.placeholder kr_isNotEmpty]) {
            NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.searchBar.placeholder attributes:
                                              @{NSForegroundColorAttributeName:RGB(165,165,165),
                                                NSFontAttributeName:[UIFont systemFontOfSize:9]}];
            searchField.attributedPlaceholder = attrString;
        }
    }
    
    self.searchBar.sd_layout
    .topSpaceToView(self.view, 0).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).heightIs(40);

}
#pragma mark - 搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if ([searchBar.text kr_isNotEmpty]) {
        [self.searchBar resignFirstResponder];
    }
}
#pragma mark - 邀请好友
- (void)invitationViews{
    
    self.view.backgroundColor = FNHomeBackgroundColor;
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStyleGrouped)];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.jm_tableview]; 
    self.jm_tableview.sd_layout
    .leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(self.view, 40).bottomSpaceToView(self.view, 0);
    
    [self.jm_tableview registerClass:[FNrelationPersonUeCell class] forCellReuseIdentifier:@"FNrelationPersonUeCell"];
    [self.jm_tableview registerClass:[FNrelationUeHeader class]  forHeaderFooterViewReuseIdentifier:@"relationUeHeaderID"];
    [self.jm_tableview registerClass:[FNlinkmanCountUeFooter class]  forHeaderFooterViewReuseIdentifier:@"linkmanCountUeFooterID"];
    
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{ 
   
    FNrelationPersonUeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNrelationPersonUeCell"];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   return 85;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    FNrelationUeHeader *headerView = [[FNrelationUeHeader alloc]initWithReuseIdentifier:@"relationUeHeaderID"];
    
    return headerView;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
   
    FNlinkmanCountUeFooter *footerView = [[FNlinkmanCountUeFooter alloc]initWithReuseIdentifier:@"linkmanCountUeFooterID"];
    
    
    return footerView;
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
    return 20;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
  
    return 30;
    
}
#pragma mark - //排行榜列表数据
- (FNRequestTool *)apiRequestArrangeList{
    [SVProgressHUD show];
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{ @"token":UserAccessToken}];
    
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection_phb&ctrl=phb_list" respondType:(ResponseTypeDataKey) modelType:@"" success:^(NSArray* respondsObject) {
        NSArray* array = respondsObject;
        [SVProgressHUD dismiss];
        [selfWeak.jm_tableview.mj_footer endRefreshing];
        [selfWeak.jm_tableview.mj_header endRefreshing];
        [selfWeak.dataArray addObjectsFromArray:array];
        
        selfWeak.jm_tableview.hidden = NO;
        [selfWeak.jm_tableview reloadData];
        //[selfWeak.jm_tableview reloadSections:[NSIndexSet indexSetWithIndex:1]];
        
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
                                                                                   
}
                                   
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
