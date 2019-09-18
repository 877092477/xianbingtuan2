//
//  FNHandResultController.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/13.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNHandResultController.h"
#import "FNCustomeNavigationBar.h"
#import "FNHandSlapdModel.h"
#import "FNMarketCentreController.h"
@interface FNHandResultController ()
@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIScrollView *bgScrollView;
@property (nonatomic, strong)UIImageView *bgImageView;
@property (nonatomic, strong)UIImageView *centreImg;
@property (nonatomic, strong)UIImageView *leftImg;
@property (nonatomic, strong)UIImageView *rightImg;
@property (nonatomic, strong)UIImageView *stateBeImg;
@property (nonatomic, strong)UIView *leftLine;
@property (nonatomic, strong)UIView *rightLine;
@property (nonatomic, strong)UILabel *stateCeLB;
@property (nonatomic, strong)UILabel *stateLeLB;
@property (nonatomic, strong)UILabel *stateReLB;
@property (nonatomic, strong)UILabel *hintCeLB;
@property (nonatomic, strong)UILabel *hintLeLB;
@property (nonatomic, strong)UILabel *hintReLB;
@property (nonatomic, strong)UILabel *stateBeLB;
@property (nonatomic, strong)UILabel *hintBeLB;
@property (nonatomic, strong)UIButton *baseBtn;

@property (nonatomic, strong)FNHandResultsModel *dataModel;
@end

@implementation FNHandResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO]; 
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
#pragma mark - set up views
- (void)jm_setupViews{
    
    self.navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.leftBtn.size = CGSizeMake(40, 30);
    self.navigationView.leftButton = self.leftBtn;
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.leftBtn setImage:IMAGE(@"return") forState:UIControlStateNormal];
    
    [self.view addSubview:self.navigationView];
    self.leftBtn.imageView.sd_layout
    .leftSpaceToView(self.leftBtn, 5).centerYEqualToView(self.leftBtn).widthIs(9).heightIs(16);
    self.leftBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationView.titleLabel.font=[UIFont systemFontOfSize:16];
    self.navigationView.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.navigationView.titleLabel.sd_layout
    .centerYEqualToView(self.navigationView.leftButton).centerXEqualToView(self.navigationView).heightIs(20);
    self.navigationView.titleLabel.textColor=[UIColor blackColor];
    self.navigationView.titleLabel.text=@"审核进度";
    [self.navigationView.titleLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    self.navigationView.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor=RGB(250, 250, 250);
    if(self.understand==YES){
        self.leftBtn.hidden=YES;
    }
    if([UserAccessToken kr_isNotEmpty]){
       [self contentSubViews];
       [self requestHandResultMsg];
    }
}
-(void)contentSubViews{
    self.bgScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, FNDeviceWidth, FNDeviceHeight-SafeAreaTopHeight)];
    self.bgScrollView.backgroundColor=RGB(250, 250, 250);
    //self.bgScrollView.contentSize=CGSizeMake(FNDeviceWidth, FNDeviceHeight);
    [self.view addSubview:self.bgScrollView];
   
    self.bgImageView=[[UIImageView alloc]init];
    //bgImageView.contentMode=UIViewContentModeScaleToFill;
    self.bgImageView.frame=CGRectMake(13, 14, FNDeviceWidth-26, 431);
    [self.bgScrollView addSubview:self.bgImageView];
    
    [self.bgScrollView setupAutoContentSizeWithBottomView:self.bgImageView bottomMargin:161]; 
    
    self.centreImg=[[UIImageView alloc]init];
    [self.bgScrollView addSubview:self.centreImg];
    
    self.leftImg=[[UIImageView alloc]init];
    [self.bgScrollView addSubview:self.leftImg];
    
    self.rightImg=[[UIImageView alloc]init];
    [self.bgScrollView addSubview:self.rightImg];
    
    self.leftLine=[[UIView alloc]init];
    [self.bgScrollView addSubview:self.leftLine];
    
    self.rightLine=[[UIView alloc]init];
    [self.bgScrollView addSubview:self.rightLine];
    
    self.stateCeLB=[[UILabel alloc]init];
    [self.bgScrollView addSubview:self.stateCeLB];
    self.stateLeLB=[[UILabel alloc]init];
    [self.bgScrollView addSubview:self.stateLeLB];
    self.stateReLB=[[UILabel alloc]init];
    [self.bgScrollView addSubview:self.stateReLB];
    
    self.hintCeLB=[[UILabel alloc]init];
    [self.bgScrollView addSubview:self.hintCeLB];
    self.hintLeLB=[[UILabel alloc]init];
    [self.bgScrollView addSubview:self.hintLeLB];
    self.hintReLB=[[UILabel alloc]init];
    [self.bgScrollView addSubview:self.hintReLB];
    
    self.stateBeImg=[[UIImageView alloc]init];
    [self.bgScrollView addSubview:self.stateBeImg];
    self.stateBeLB=[[UILabel alloc]init];
    [self.bgScrollView addSubview:self.stateBeLB];
    self.hintBeLB=[[UILabel alloc]init];
    [self.bgScrollView addSubview:self.hintBeLB];
    
    self.stateCeLB.font=[UIFont systemFontOfSize:14];
    self.stateCeLB.textColor=RGB(102, 102, 102);
    self.stateCeLB.textAlignment=NSTextAlignmentCenter;
    self.stateLeLB.font=[UIFont systemFontOfSize:14];
    self.stateLeLB.textColor=RGB(102, 102, 102);
    self.stateLeLB.textAlignment=NSTextAlignmentCenter;
    self.stateReLB.font=[UIFont systemFontOfSize:14];
    self.stateReLB.textColor=RGB(102, 102, 102);
    self.stateReLB.textAlignment=NSTextAlignmentCenter;
    
    self.hintCeLB.font=[UIFont systemFontOfSize:10];
    self.hintCeLB.textColor=RGB(204, 204, 204);
    self.hintCeLB.textAlignment=NSTextAlignmentCenter;
    self.hintLeLB.font=[UIFont systemFontOfSize:10];
    self.hintLeLB.textColor=RGB(204, 204, 204);
    self.hintLeLB.textAlignment=NSTextAlignmentCenter;
    self.hintReLB.font=[UIFont systemFontOfSize:10];
    self.hintReLB.textColor=RGB(204, 204, 204);
    self.hintReLB.textAlignment=NSTextAlignmentCenter;
    
    self.stateBeLB.font=[UIFont systemFontOfSize:20];
    self.stateBeLB.textColor=RGB(51, 51, 51);
    self.stateBeLB.textAlignment=NSTextAlignmentCenter;
    self.hintBeLB.font=[UIFont systemFontOfSize:12];
    self.hintBeLB.textColor=RGB(153, 153, 153);
    self.hintBeLB.textAlignment=NSTextAlignmentCenter;
    
    CGFloat meanLbW=(FNDeviceWidth-46)/3;
    
    self.centreImg.sd_layout
    .centerXEqualToView(self.bgScrollView).widthIs(11).heightIs(11).topSpaceToView(self.bgScrollView, 44);
    
    self.stateCeLB.sd_layout
    .centerXEqualToView(self.bgScrollView).topSpaceToView(self.centreImg, 13).heightIs(18).widthIs(meanLbW);
    
    self.stateLeLB.sd_layout
    .rightSpaceToView(self.stateCeLB, 5).centerYEqualToView(self.stateCeLB).heightIs(18).widthIs(meanLbW);
    
    self.stateReLB.sd_layout
    .leftSpaceToView(self.stateCeLB, 5).centerYEqualToView(self.stateCeLB).heightIs(18).widthIs(meanLbW);
    
    self.hintCeLB.sd_layout
    .centerXEqualToView(self.bgScrollView).topSpaceToView(self.stateCeLB, 3).heightIs(14).widthIs(meanLbW);
    
    self.hintLeLB.sd_layout
    .rightSpaceToView(self.hintCeLB, 5).centerYEqualToView(self.hintCeLB).heightIs(14).widthIs(meanLbW);
    
    self.hintReLB.sd_layout
    .leftSpaceToView(self.hintCeLB, 5).centerYEqualToView(self.hintCeLB).heightIs(14).widthIs(meanLbW);
    
    self.leftImg.sd_layout
    .centerXEqualToView(self.stateLeLB).centerYEqualToView(self.centreImg).widthIs(11).heightIs(11);
    
    self.rightImg.sd_layout
    .centerXEqualToView(self.stateReLB).centerYEqualToView(self.centreImg).widthIs(11).heightIs(11);
    
    self.leftLine.sd_layout
    .leftSpaceToView(self.leftImg, 5).rightSpaceToView(self.centreImg, 5).heightIs(1).centerYEqualToView(self.centreImg);
    
    self.rightLine.sd_layout
    .leftSpaceToView(self.centreImg, 5).rightSpaceToView(self.rightImg, 5).heightIs(1).centerYEqualToView(self.centreImg);
    
    self.stateBeImg.sd_layout
    .centerXEqualToView(self.bgScrollView).widthIs(96).heightIs(87).topSpaceToView(self.bgScrollView, 161);
    self.stateBeLB.sd_layout
    .leftSpaceToView(self.bgScrollView, 18).rightSpaceToView(self.bgScrollView, 18).heightIs(24).topSpaceToView(self.stateBeImg, 10);
    
    self.hintBeLB.sd_layout
    .leftSpaceToView(self.bgScrollView, 18).rightSpaceToView(self.bgScrollView, 18).heightIs(16).topSpaceToView(self.stateBeLB, 16); 
    
    self.baseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgScrollView addSubview:self.baseBtn];
    
    self.baseBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.baseBtn addTarget:self action:@selector(baseBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.baseBtn.sd_layout
    .leftSpaceToView(self.bgScrollView, 34).rightSpaceToView(self.bgScrollView, 34).topSpaceToView(self.hintBeLB, 25).heightIs(46);
    
}
#pragma mark - 点击
//返回
-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//底部按钮Click
-(void)baseBtnAction{
    //审核结果 0 审核中 1 审核通过 2 审核未通过
    NSInteger statusInt=[self.dataModel.status integerValue];
    if(statusInt==0){
        //刷新
        [SVProgressHUD show];
        [self requestHandResultMsg];
    }
    if(statusInt==1){ 
        //进入推手中心
        FNMarketCentreController *vc=[[FNMarketCentreController alloc]init];
        vc.confirm=@"1";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if(statusInt==2){
        //重新申请
        [self requestHand];
    }
}

#pragma mark - request
//推手中心-审核结果页面
-(FNRequestTool*)requestHandResultMsg{
    @weakify(self);
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=push_hand&ctrl=apply_status" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        @strongify(self);
        NSDictionary *dictry = respondsObject[DataKey];
        self.dataModel=[FNHandResultsModel mj_objectWithKeyValues:dictry];
        self.navigationView.titleLabel.text=self.dataModel.title;
        [self.bgImageView setUrlImg:self.dataModel.bg_img];
        
        NSArray *progressList=self.dataModel.progress;
        if(progressList.count>0){
           FNHandResultsModel *leModel=[FNHandResultsModel mj_objectWithKeyValues:progressList[0]];
            self.stateLeLB.text=leModel.str;
            self.hintLeLB.text=leModel.time;
        }
        if(progressList.count>1){
            FNHandResultsModel *ceModel=[FNHandResultsModel mj_objectWithKeyValues:progressList[1]];
            self.stateCeLB.text=ceModel.str;
            self.hintCeLB.text=ceModel.time;
        }
        if(progressList.count>2){
            FNHandResultsModel *reModel=[FNHandResultsModel mj_objectWithKeyValues:progressList[2]];
            self.stateReLB.text=reModel.str;
            self.hintReLB.text=reModel.time;
        }
        
        self.stateBeLB.text=self.dataModel.str;
        self.hintBeLB.text=self.dataModel.tips;
        [self.stateBeImg setUrlImg:self.dataModel.img];
        [self.baseBtn sd_setBackgroundImageWithURL:URL(self.dataModel.btn_bj) forState:UIControlStateNormal];
        
        [self.baseBtn setTitleColor:[UIColor colorWithHexString:self.dataModel.btn_color] forState:UIControlStateNormal];
        
        //审核结果 0 审核中 1 审核通过 2 审核未通过
        NSInteger statusInt=[self.dataModel.status integerValue];
        if(statusInt==0){
            self.leftLine.backgroundColor=[UIColor colorWithHexString:self.dataModel.red_line];
            self.rightLine.backgroundColor=[UIColor colorWithHexString:self.dataModel.gray_line];
            [self.centreImg setUrlImg:self.dataModel.red_circle];
            [self.leftImg setUrlImg:self.dataModel.red_circle];
            [self.rightImg setUrlImg:self.dataModel.gray_circle];
            [self.baseBtn setTitle:@"刷新" forState:UIControlStateNormal];
        }
        if(statusInt==1){
            self.leftLine.backgroundColor=[UIColor colorWithHexString:self.dataModel.red_line];
            self.rightLine.backgroundColor=[UIColor colorWithHexString:self.dataModel.red_line];
            [self.centreImg setUrlImg:self.dataModel.red_circle];
            [self.leftImg setUrlImg:self.dataModel.red_circle];
            [self.rightImg setUrlImg:self.dataModel.red_circle];
            [self.baseBtn setTitle:@"进入推手中心" forState:UIControlStateNormal];
        }
        if(statusInt==2){
            self.leftLine.backgroundColor=[UIColor colorWithHexString:self.dataModel.red_line];
            self.rightLine.backgroundColor=[UIColor colorWithHexString:self.dataModel.red_line];
            [self.centreImg setUrlImg:self.dataModel.red_circle];
            [self.leftImg setUrlImg:self.dataModel.red_circle];
            [self.rightImg setUrlImg:self.dataModel.red_circle];
            [self.baseBtn setTitle:@"重新申请" forState:UIControlStateNormal];
        }
        if([self.dataModel.btn_str kr_isNotEmpty]){
           [self.baseBtn setTitle:self.dataModel.btn_str forState:UIControlStateNormal];
        }
        
    } failure:^(NSString *error) {
         [SVProgressHUD dismiss];
    } isHideTips:NO isCache:NO];
}
//推手中心-申请接口
-(FNRequestTool*)requestHand{
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken,@"time":[NSString GetNowTimes]}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=push_hand&ctrl=apply" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        NSString *msgStr=respondsObject[MsgKey];
        [FNTipsView showTips:msgStr];
    } failure:^(NSString *error) {
    } isHideTips:NO isCache:NO];
}
@end
