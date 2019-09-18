//
//  FNCardActivityTeController.m
//  THB
//
//  Created by 李显 on 2019/2/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//
//打卡活动规则
#import "FNCardActivityTeController.h"
#import "FNcardActTeModel.h"
@interface FNCardActivityTeController ()
@property(nonatomic,strong)FNcardActTeModel *dataModel;
@property(nonatomic,strong)UIScrollView *bgScrollView;

@property(nonatomic,strong)UIImageView *BGImageView;
@property(nonatomic,strong)UIImageView *oneImageView;
@property(nonatomic,strong)UIImageView *twoImageView;
@property(nonatomic,strong)UIImageView *threeImageView;
@property(nonatomic,strong)UIView *rulewhiteView;
@property(nonatomic,assign)CGFloat rulewConY;
@property(nonatomic,assign)CGFloat explainY;

@end

@implementation FNCardActivityTeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"活动规则";
    [self contentView];
    [self apiRequestpayType];

}
-(void)contentView{
    self.BGImageView=[[UIImageView alloc]init];
    //self.BGImageView.contentMode=UIViewContentModeScaleToFill;
    [self.view addSubview:self.BGImageView];
    
    self.BGImageView.sd_layout
    .leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0);
    
    self.bgScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, FNDeviceHeight-SafeAreaTopHeight)];
    self.bgScrollView.backgroundColor=[UIColor clearColor];
    self.bgScrollView.contentSize=CGSizeMake(FNDeviceWidth, 738);
    [self.view addSubview:self.bgScrollView];
    self.bgScrollView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    
    
    self.oneImageView=[[UIImageView alloc]init];
    self.oneImageView.contentMode=UIViewContentModeScaleToFill;
    [self.bgScrollView addSubview:self.oneImageView];
    
    
    
    
    
    self.oneImageView.sd_layout
    .topSpaceToView(self.bgScrollView, 40).centerXEqualToView(self.bgScrollView).widthIs(270).heightIs(71);
    
    
}
-(void)addWhitedView:(NSArray*)arr{
    if(arr.count>0){
        self.rulewhiteView=[[UIView alloc]init];
        self.rulewhiteView.backgroundColor=[UIColor whiteColor];
        self.rulewhiteView.cornerRadius=5;
        self.rulewhiteView.frame=CGRectMake(10, 159, FNDeviceWidth-20, 150);
        [self.bgScrollView addSubview:self.rulewhiteView];
        CGFloat height=45;
        CGFloat widthT=FNDeviceWidth-80;
        self.rulewConY=45;
        for(NSInteger i=0;i<arr.count;i++){
            NSString *str=arr[i];
            CGSize conSize = [str sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(widthT, MAXFLOAT)];
            UILabel* titleLB = [[UILabel alloc]init];
            titleLB.numberOfLines=0;
            titleLB.font=[UIFont systemFontOfSize:12];
            titleLB.textAlignment=NSTextAlignmentLeft;
            titleLB.frame=CGRectMake(30, self.rulewConY, widthT, conSize.height+30);
            [self.rulewhiteView addSubview:titleLB];
            titleLB.text=arr[i];
            self.rulewConY=self.rulewConY+conSize.height+30;
        }
        
        self.rulewhiteView.frame=CGRectMake(10, 159, FNDeviceWidth-20, self.rulewConY+20);
        
        [self addExplainWhitedView:self.dataModel.explain];
        
        self.twoImageView=[[UIImageView alloc]init];
        self.twoImageView.contentMode=UIViewContentModeScaleToFill;
        [self.bgScrollView addSubview:self.twoImageView];
        
        self.twoImageView.sd_layout
        .centerXEqualToView(self.bgScrollView).topSpaceToView(self.oneImageView, 30).widthIs(128).heightIs(45);
        
        self.threeImageView=[[UIImageView alloc]init];
        self.threeImageView.contentMode=UIViewContentModeScaleToFill;
        [self.bgScrollView addSubview:self.threeImageView];
        
        self.threeImageView.sd_layout
        .centerXEqualToView(self.bgScrollView).topSpaceToView(self.rulewhiteView, 30).widthIs(128).heightIs(45);
        
        [self.twoImageView setUrlImg:self.dataModel.sign_rule_title];
        [self.threeImageView setUrlImg:self.dataModel.sign_rule_title2];
    }
}

-(void)addExplainWhitedView:(NSArray*)arr{
    if(arr.count>0){
        UIView *explainwhiteView=[[UIView alloc]init];
        explainwhiteView.backgroundColor=[UIColor whiteColor];
        explainwhiteView.cornerRadius=5;
        explainwhiteView.frame=CGRectMake(10, self.rulewConY+20+159+40, FNDeviceWidth-20, 150);
        [self.bgScrollView addSubview:explainwhiteView];
        
        CGFloat widthT=FNDeviceWidth-80;
        self.explainY=45;
        for(NSInteger i=0;i<arr.count;i++){
            NSString *str=arr[i];
            CGSize conSize = [str sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(widthT, MAXFLOAT)];
            UILabel* titleLB = [[UILabel alloc]init];
            titleLB.numberOfLines=0;
            titleLB.font=[UIFont systemFontOfSize:12];
            titleLB.text=arr[i];
            titleLB.textAlignment=NSTextAlignmentLeft;
            titleLB.frame=CGRectMake(30, self.explainY, widthT, conSize.height+30);
            [explainwhiteView addSubview:titleLB];
            self.explainY=self.explainY+conSize.height+30;
        }
        explainwhiteView.frame=CGRectMake(10, self.rulewConY+159+40+20, FNDeviceWidth-20, self.explainY+20);
        [self.bgScrollView setupAutoContentSizeWithBottomView:explainwhiteView bottomMargin:35];
 
        [self.bgScrollView updateLayout];
        
    }
    
   
}

#pragma mark - //打卡明细
- (FNRequestTool *)apiRequestpayType{
    [SVProgressHUD show];
    @WeakObj(self);
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=appClockRecord&ctrl=dk_rule" respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dictry = respondsObject[DataKey];
        selfWeak.dataModel=[FNcardActTeModel mj_objectWithKeyValues:dictry];
        [self.BGImageView setUrlImg:selfWeak.dataModel.sign_rule_bjimg];
        [self.oneImageView setUrlImg:selfWeak.dataModel.sign_rule_font];
        
       
        [self addWhitedView:selfWeak.dataModel.rule];
      
    } failure:^(NSString *error) {
        
    } isHideTips:YES];
}


@end
