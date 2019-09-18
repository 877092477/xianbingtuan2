//
//  FNpacketRedNeController.m
//  THB
//
//  Created by Jimmy on 2018/12/11.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//支付宝红包
#import "FNpacketRedNeController.h"
#import "FNCustomeNavigationBar.h"
#import "FNredPacketDeModel.h"
@interface FNpacketRedNeController ()

@property(nonatomic,strong)FNCustomeNavigationBar *navigationView;
@property(nonatomic,strong)UIButton* backbtn;
@property(nonatomic,strong)UIScrollView *bgScrollView;
//BGImageView
@property(nonatomic,strong)UIImageView *BGImageView;
//topImage
@property(nonatomic,strong)UIImageView *topImageView;
//belowImage
@property(nonatomic,strong)UIImageView *belowImageView;

@property(nonatomic,strong)UIView *lineCentreView;
//红包背部内容文字
@property(nonatomic,strong)UILabel *yardLB;
@property(nonatomic,strong)UIImageView *codeImageView;
//复制按钮背景图
@property(nonatomic,strong)UIImageView *replicationImageView;
@property(nonatomic,strong)UIButton *replicationBtn;
//打开支付宝页面搜索
@property(nonatomic,strong)UILabel *reminderLB;
//belowImage
@property(nonatomic,strong)UILabel *belowLB;
@property(nonatomic,strong)UILabel *belowTwoLB;
@property(nonatomic,strong)UILabel *belowThreeLB;
@property(nonatomic,strong)UIImageView *knowImageView;

@property(nonatomic,strong)FNredPacketDeModel *dataModel;

@property(nonatomic,strong)UIImageView *topBttImageLeft;
@property(nonatomic,strong)UIImageView *topBttImageRight;

@end

@implementation FNpacketRedNeController

- (BOOL)isFullScreenShow {
    return YES;
}

- (BOOL) needLogin {
    return YES;
}

#pragma mark - 一些系统的方法
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
    self.headHeight=1226;
    [self contentView];
    [self topNavigationView];
    
    [self apiRequestRedPacket];
    
}
-(void)topNavigationView{
    _navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@"分享码"];
    _navigationView.titleLabel.textColor=[UIColor blackColor];
    _navigationView.backgroundColor = [UIColor clearColor];
    UIButton* backbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [backbtn setImage:IMAGE(@"return") forState:(UIControlStateNormal)];
    [backbtn addTarget:self action:@selector(backbtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [backbtn sizeToFit];
    backbtn.size=CGSizeMake(30, 30);
    [backbtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _navigationView.leftButton = backbtn;
    [self.view addSubview:_navigationView];
    
    self.backbtn=backbtn;
    //self.backbtn.hidden=YES;
    [self compositionFramesS];
}
-(void)backbtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (FNRequestTool *)apiRequestRedPacket{
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=alipay_packet&ctrl=index" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        selfWeak.backbtn.hidden=NO;
        NSDictionary* dictry = respondsObject[DataKey];
        XYLog(@"红包码:%@",respondsObject[DataKey]);
        NSString *bingImageUrl=dictry[@"alipay_packet_bjimg"];
        selfWeak.dataModel=[FNredPacketDeModel mj_objectWithKeyValues:dictry];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            if ([bingImageUrl kr_isNotEmpty]) {
                CGFloat imgH = 0;
                UIImage* img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:bingImageUrl]]];
                CGFloat height = img?JMScreenWidth*(img.size.height/img.size.width):0;
                imgH=height ;
                if (img) {
                    //selfWeak.headHeight=imgH;
                    
                }
            }
        });
        [self compositionFramesS];
    } failure:^(NSString *error) {

    } isHideTips:YES];
}
-(void)contentView{
    self.bgScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight)];
    self.bgScrollView.backgroundColor=[UIColor whiteColor];
    self.bgScrollView.contentSize=CGSizeMake(FNDeviceWidth, 1226);
    [self.view addSubview:self.bgScrollView];
    self.bgScrollView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    if (@available(iOS 11.0, *)) {
        self.bgScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.BGImageView=[[UIImageView alloc]init];
    self.BGImageView.userInteractionEnabled=YES;
    self.BGImageView.contentMode=UIViewContentModeScaleToFill;
    [self.bgScrollView addSubview:self.BGImageView];
    
    self.lineCentreView=[[UIView alloc]init];
    //self.lineCentreView.backgroundColor=[UIColor greenColor];
    [self.BGImageView addSubview:self.lineCentreView];
    
    //上部
    self.topImageView=[[UIImageView alloc]init];
    self.topImageView.userInteractionEnabled=YES;
    [self.BGImageView addSubview:self.topImageView];
    
    
    self.topBttImageLeft=[[UIImageView alloc]init];
    self.topBttImageLeft.userInteractionEnabled=YES;
    [self.topImageView addSubview:self.topBttImageLeft];
    
    self.topBttImageRight=[[UIImageView alloc]init];
    self.topBttImageRight.userInteractionEnabled=YES;
    [self.topImageView addSubview:self.topBttImageRight];
    
    
    self.reminderLB=[UILabel new];
    self.reminderLB.font=[UIFont systemFontOfSize:12];//kFONT17;
    self.reminderLB.textAlignment=NSTextAlignmentCenter;
    [self.topImageView addSubview:self.reminderLB];
    
    self.codeImageView=[[UIImageView alloc]init];
    [self.BGImageView addSubview:self.codeImageView];
    
    self.yardLB=[UILabel new];
    self.yardLB.font=[UIFont systemFontOfSize:30];//kFONT17;
    self.yardLB.textAlignment=NSTextAlignmentCenter;
    [self.codeImageView addSubview:self.yardLB];
    
    self.replicationImageView=[[UIImageView alloc]init];
    self.replicationImageView.userInteractionEnabled=YES;
    [self.topImageView addSubview:self.replicationImageView];
    
    self.replicationBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.replicationBtn.titleLabel.font=[UIFont systemFontOfSize:20];
    [self.replicationBtn  addTarget:self action:@selector(replicationBtnAction)];
    [self.replicationImageView addSubview:self.replicationBtn];
    
    
    
    //底部
    self.belowImageView=[[UIImageView alloc]init];
    [self.BGImageView addSubview:self.belowImageView];
    
    self.belowLB=[UILabel new];
    self.belowLB.font=[UIFont systemFontOfSize:30];//kFONT17;
    self.belowLB.textAlignment=NSTextAlignmentCenter;
    [self.belowImageView addSubview:self.belowLB];
    
    self.belowTwoLB=[UILabel new];
    self.belowTwoLB.font=[UIFont systemFontOfSize:13];//kFONT17;
    self.belowTwoLB.textAlignment=NSTextAlignmentLeft;
    self.belowTwoLB.numberOfLines=2;
    [self.belowImageView addSubview:self.belowTwoLB];
    
    self.belowThreeLB=[UILabel new];
    self.belowThreeLB.font=[UIFont systemFontOfSize:12];//kFONT17;
    self.belowThreeLB.textAlignment=NSTextAlignmentCenter;
    [self.belowImageView addSubview:self.belowThreeLB];
    
    self.knowImageView=[[UIImageView alloc]init];
    [self.belowImageView addSubview:self.knowImageView];
    
    
    
    
    
}
-(void)compositionFramesS{
    CGFloat interval_40=40;
    CGFloat interval_20=20;
    CGFloat interval_10=10;
    
    self.BGImageView.sd_layout
    .topSpaceToView(self.bgScrollView, 0).leftSpaceToView(self.bgScrollView, 0).rightSpaceToView(self.bgScrollView, 0).heightIs(self.headHeight);
    
    self.lineCentreView.sd_layout
    .centerYEqualToView(self.BGImageView).heightIs(1).leftSpaceToView(self.BGImageView, interval_10).rightSpaceToView(self.BGImageView, interval_10);
    
    self.topImageView.sd_layout
    .leftSpaceToView(self.BGImageView, interval_20).rightSpaceToView(self.BGImageView, interval_20).heightIs(506).bottomSpaceToView(self.lineCentreView, 68);
    
    
    self.topBttImageLeft.sd_layout
    .heightIs(10).bottomSpaceToView(self.topImageView, 30).widthIs(27).leftSpaceToView(self.topImageView, 40);
    self.topBttImageRight.sd_layout
    .heightIs(10).bottomSpaceToView(self.topImageView, 30).widthIs(27).rightSpaceToView(self.topImageView, 40);
    
    
    
    self.reminderLB.sd_layout
    .heightIs(20).centerXEqualToView(self.topImageView).leftSpaceToView(self.topBttImageLeft, 0).rightSpaceToView(self.topBttImageRight, 0).centerYEqualToView(self.topBttImageLeft);
    
    self.replicationImageView.sd_layout
     .heightIs(76).bottomSpaceToView(self.reminderLB, 10).widthIs(226).centerXEqualToView(self.topImageView);
    //self.replicationImageView.backgroundColor=[UIColor blueColor];
    //self.codeImageView.backgroundColor=[UIColor cyanColor];
    
    self.replicationBtn.sd_layout
    .heightIs(50).centerXEqualToView(self.replicationImageView).topSpaceToView(self.replicationImageView, 10).widthIs(200);
    
    
    self.codeImageView.sd_layout
    .widthIs(235).heightIs(60).bottomSpaceToView(self.replicationImageView, 0).centerXEqualToView(self.topImageView);
    
    self.yardLB.sd_layout
    .widthIs(235).heightIs(60).bottomSpaceToView(self.codeImageView, 0).centerXEqualToView(self.codeImageView);
    
    //底部
    self.belowImageView.sd_layout
    .leftSpaceToView(self.BGImageView, interval_10).rightSpaceToView(self.BGImageView, interval_10).heightIs(506).topSpaceToView(self.lineCentreView, 68);
    
    [self.bgScrollView setupAutoContentSizeWithBottomView:self.BGImageView bottomMargin:0];
    
    
    [self.BGImageView setNoPlaceholderUrlImg:self.dataModel.alipay_packet_bjimg];
    [self.topImageView setUrlImg:self.dataModel.alipay_packet_top_bjimg];
    [self.belowImageView setUrlImg:self.dataModel.alipay_packet_btm_bjimg];
    
    //码
    [self.codeImageView setUrlImg:self.dataModel.alipay_packet_code_img];
    self.yardLB.text=self.dataModel.alipay_packet_code;
    self.yardLB.textColor=[UIColor colorWithHexString:self.dataModel.alipay_packet_code_strcolor];
    
    //底部文字
    self.reminderLB.text=self.dataModel.alipay_packet_str;
    self.reminderLB.textColor=[UIColor colorWithHexString:self.dataModel.alipay_packet_strcolor];
    
    //复制
    [self.replicationImageView setUrlImg:self.dataModel.alipay_packet_btn_img];
    [self.replicationBtn setTitle:self.dataModel.alipay_packet_btn_str forState:UIControlStateNormal];
    [self.replicationBtn setTitleColor:[UIColor colorWithHexString:self.dataModel.alipay_packet_btn_strcolor] forState:UIControlStateNormal];
    
    self.belowLB.text=self.dataModel.alipay_packet_btm_str1;
    self.belowLB.textColor=[UIColor colorWithHexString:self.dataModel.alipay_packet_btm_strcolor1];
    
    self.belowTwoLB.text=self.dataModel.alipay_packet_btm_str2;
    self.belowTwoLB.textColor=[UIColor colorWithHexString:self.dataModel.alipay_packet_btm_strcolor2];
    
    self.belowThreeLB.text=self.dataModel.alipay_packet_btm_str3;
    self.belowThreeLB.textColor=[UIColor colorWithHexString:self.dataModel.alipay_packet_btm_strcolor3];
    
    [self.knowImageView setUrlImg:self.dataModel.alipay_packet_courseimg];
    
    self.topBttImageLeft.image=IMAGE(@"right_Slices");
    self.topBttImageRight.image=IMAGE(@"left_Slices");
    
    self.belowLB.sd_layout
    .topSpaceToView(self.belowImageView, 30).leftSpaceToView(self.belowImageView, 10).rightSpaceToView(self.belowImageView, 10).heightIs(40);
    
    
    
    self.belowThreeLB.sd_layout
    .leftSpaceToView(self.belowImageView, 10).rightSpaceToView(self.belowImageView, 10).heightIs(20).bottomSpaceToView(self.belowImageView, 40);
    
    
    
    self.knowImageView.sd_layout
    .heightIs(210).bottomSpaceToView(self.belowThreeLB, 30).widthIs(270).centerXEqualToView(self.belowImageView);
    
    self.belowTwoLB.sd_layout
    .bottomSpaceToView(self.knowImageView, 20).leftSpaceToView(self.belowImageView, 40).rightSpaceToView(self.belowImageView, 40).heightIs(45);
    
    
    [self.bgScrollView updateLayout];
    [self.BGImageView updateLayout];
}

//-(void)setHeadHeight:(CGFloat)headHeight{
//    if(headHeight>0){
//        XYLog(@"headHeight:%f",headHeight);
//        [self compositionFramesS];
//    }
//}
-(void)replicationBtnAction{
    
    
    //if([self ALIisLogin]){
        if([self.dataModel.alipay_packet_code kr_isNotEmpty]){
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = self.dataModel.alipay_packet_code;
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"alipays://platformapi/startapp?appId=20001003"]];
        }
    //}
    
}
-(BOOL)ALIisLogin{
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay://"]]) {
        return YES;
    }
    else {
            NSLog(@"未安装");
        return NO;
    }
}

@end
