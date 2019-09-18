//
//  FNTeOddPromptlyNeController.m
//  69橙子
//
//  Created by Jimmy on 2018/11/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//立即支付
#import "FNTeOddPromptlyNeController.h"
//view
#import "FNTePayModelDaNeCell.h"
//model
#import "FNTePayDaNeModel.h"
@interface FNTeOddPromptlyNeController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *payArr;
@end

@implementation FNTeOddPromptlyNeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"付款";
    self.view.backgroundColor=RGB(246, 246, 246);
    NSArray* Arr=@[@{@"image":@"pay_tanb_Wechat",@"name":@"微信",@"state":@"1",@"aid":@"1"},@{@"image":@"pay_tanb_Alipay",@"name":@"微信",@"state":@"0",@"aid":@"2"}];
    self.payArr=[NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dic in Arr) {
        FNTePayDaNeModel *mode=[FNTePayDaNeModel mj_objectWithKeyValues:dic];
        [self.payArr addObject:mode];
    }
    [self constructView];
    
}
#pragma mark - 界面
-(void)constructView{
    //CGFloat spaceeHeight=SafeAreaTopHeight+20;
    CGFloat spaceeHeight=20;
    UIView *whiteBgView=[[UIView alloc]init];
    whiteBgView.frame=CGRectMake(20, spaceeHeight, FNDeviceWidth-40, 250);
    whiteBgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:whiteBgView];
    whiteBgView.sd_layout
    .widthIs(330).heightIs(250).centerXEqualToView(self.view).topSpaceToView(self.view, spaceeHeight);
    
    UILabel *storeName=[[UILabel alloc]init];
    //storeName.backgroundColor=[UIColor lightGrayColor];
    storeName.textAlignment=NSTextAlignmentCenter;
    storeName.font=kFONT14;
    storeName.text=@"支付";
    [whiteBgView addSubview:storeName];
    storeName.sd_layout
    .topSpaceToView(whiteBgView, 25).heightIs(20).leftSpaceToView(whiteBgView, 20).rightSpaceToView(whiteBgView, 20);
    
    UILabel *estimateLb=[[UILabel alloc]init];
    //estimateLb.backgroundColor=[UIColor lightGrayColor];
    estimateLb.font=kFONT17;
    estimateLb.text=@"¥10000";
    estimateLb.textAlignment=NSTextAlignmentCenter;
    [whiteBgView addSubview:estimateLb];
    estimateLb.sd_layout
    .topSpaceToView(storeName, 25).heightIs(25).leftSpaceToView(whiteBgView, 20).rightSpaceToView(whiteBgView, 20);
    
    self.jm_tableview = [[UITableView alloc]initWithFrame:CGRectMake(20, 150, FNDeviceWidth-80, 100) style:UITableViewStylePlain];
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.rowHeight=50;
    self.jm_tableview.showsVerticalScrollIndicator=NO;
    self.jm_tableview.showsHorizontalScrollIndicator=NO;
    [whiteBgView addSubview:self.jm_tableview];
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.estimatedRowHeight = 0;
        self.jm_tableview.estimatedSectionFooterHeight = 0;
        self.jm_tableview.estimatedSectionHeaderHeight= 0;
        self.jm_tableview.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
    }
    
    self.jm_tableview.sd_layout.leftSpaceToView(whiteBgView, 20).rightSpaceToView(whiteBgView, 20).bottomSpaceToView(whiteBgView, 10);
    
    UIButton *confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 20+250+20 , FNDeviceWidth-40, 50)];
    [confirmBtn.layer setMasksToBounds:YES];
    [confirmBtn.layer setCornerRadius:8.0];//设置矩形四个圆角半径
    [confirmBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = kFONT16;
    confirmBtn.titleLabel.textColor = [UIColor whiteColor];
    confirmBtn.backgroundColor = RGB(246, 51, 40);
    [confirmBtn addTarget:self action:@selector(clickBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    confirmBtn.sd_layout
    .topSpaceToView(whiteBgView, 20).leftEqualToView(whiteBgView).rightEqualToView(whiteBgView).heightIs(50);
    
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.payArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FNTePayModelDaNeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"TePayModelDaNeCellID"];
    if (cell == nil) {
        cell = [[FNTePayModelDaNeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TePayModelDaNeCellID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model=self.payArr[indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FNTePayDaNeModel *model=self.payArr[indexPath.row];
    for (FNTePayDaNeModel *Fmodel in self.payArr) {
        if (Fmodel.aid==model.aid) {
            Fmodel.state=1;
        }else{
            Fmodel.state=0;
        }
    }
    [self.jm_tableview reloadData];
}

-(void)clickBtnMethod{
    //FNTeOddEnsureNeController *vc=[[FNTeOddEnsureNeController alloc]init];
    //[self.navigationController pushViewController:vc animated:YES];
}


@end
