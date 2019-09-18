//
//  FNConnectionsMessageController.m
//  THB
//
//  Created by Weller Zhao on 2019/2/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConnectionsMessageController.h"
#import "FNConnectionsMessageCell.h"
#import "FNChatMessageModel.h"
#import "FNConnectionsChatController.h"
#import "FNCustomeNavigationBar.h"

@interface FNConnectionsMessageController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<FNChatMessageModel*> *messages;

@property(nonatomic,strong)FNCustomeNavigationBar *topNaivgationbar;
@property(nonatomic,strong)UIButton *leftBtn;

@end

@implementation FNConnectionsMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _messages = [[NSMutableArray alloc] init];
    [self requestMessage];
    [self setTopNavBar];
    [self configUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.jm_tableview reloadData];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - 导航栏view
-(void)setTopNavBar{
    
    UIView *topView=[[UIView alloc]init];
    topView.frame=CGRectMake(0, 0, FNDeviceWidth, SafeAreaTopHeight);
    //self.topImg=[[UIImageView alloc]init];
    //[topView addSubview:self.topImg];
    self.topNaivgationbar = [FNCustomeNavigationBar customeNavigationBarWithCustomeView:topView];
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,FNDeviceWidth,SafeAreaTopHeight);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:177/255.0 green:101/255.0 blue:251/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:255/255.0 green:59/255.0 blue:153/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0)];
    
    [self.topNaivgationbar.layer addSublayer:gl];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn setImage:[UIImage imageNamed:@"return-white"] forState:UIControlStateNormal];
    [self.leftBtn setTitle:@"消息通知" forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font=kFONT17;
    [self.leftBtn sizeToFit];
    self.leftBtn.size = CGSizeMake(self.leftBtn.width+10, 30);
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.leftBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10.0f];
    
    self.topNaivgationbar.leftButton = self.leftBtn;
    
    [self.view addSubview:_topNaivgationbar];
    self.topNaivgationbar.backgroundColor =[UIColor whiteColor];
    
}

- (void)configUI {
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStyleGrouped)];
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.alpha = 1;
    self.jm_tableview.backgroundColor = [UIColor clearColor];
    self.jm_tableview.estimatedRowHeight = 200;
    self.jm_tableview.rowHeight = UITableViewAutomaticDimension;
    self.jm_tableview.showsVerticalScrollIndicator = NO;
    
    
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.jm_tableview];
    @weakify(self)
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.right.equalTo(@0);
        make.top.equalTo(self_weak_.topNaivgationbar.mas_bottom);
        make.left.right.bottom.equalTo(@0);
    }];
    
    [self.jm_tableview registerClass:[FNConnectionsMessageCell class] forCellReuseIdentifier:@"FNConnectionsMessageCell"];
    
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark - Network

- (FNRequestTool*) requestMessage {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=lt&ctrl=room_list" respondType:(ResponseTypeArray) modelType:@"FNChatMessageModel" success:^(id respondsObject) {
        @strongify(self);
        [self.messages addObjectsFromArray:respondsObject];
        [self.jm_tableview reloadData];
        
    } failure:^(NSString *error) {
        //
    } isHideTips:YES isCache:NO];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages == nil ? 0 : self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FNChatMessageModel *message = self.messages[indexPath.row];
    FNConnectionsMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNConnectionsMessageCell"];
    [cell.imgHeader sd_setImageWithURL:URL(message.head_img)];
    cell.lblName.text = message.name;
    cell.lblTime.text = message.time;
    cell.lblCount.text = message.unread;
    if ([message.unread isEqualToString:@""] || [message.unread isEqualToString:@"0"]) {
        cell.vCount.hidden = YES;
    } else {
        cell.vCount.hidden = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FNChatMessageModel *message = self.messages[indexPath.row];
    FNConnectionsChatController *chatController = [[FNConnectionsChatController alloc] init];
    chatController.room = message.room;
    chatController.uid = message.sendee_uid;
    chatController.target = message.target;
    chatController.nickname = message.name;
    [self.navigationController pushViewController:chatController animated:YES];
    message.unread = @"0";
}

#pragma mark - Action
- (void)leftBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
