//
//  FNtypeStatementDeCell.m
//  THB
//
//  Created by Jimmy on 2018/12/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//财务报表  订单报表
#import "FNtypeStatementDeCell.h"

@implementation FNtypeStatementDeCell
-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    @WeakObj(self);
    self.backgroundColor=[UIColor whiteColor];//RGB(246, 245, 245);
    /*self.topSlideBar = [[FDSlideBar alloc] initWithFrame:CGRectMake(0, 0, FNDeviceWidth, 40)];
    self.topSlideBar.backgroundColor = FNWhiteColor;
    //self.topSlideBar.is_middle=YES;
    self.topSlideBar.is_mean=YES;
    [self.topSlideBar selectSlideBarItemAtIndex:0];
    [self.topSlideBar slideBarItemSelectedCallback:^(NSUInteger index) {
        if ([selfWeak.delegate respondsToSelector:@selector(intypeStairScreenType:)]) {
            [selfWeak.delegate intypeStairScreenType:index];
        }
    }];*/
    [self addSubview:self.topSlideBar];
    
    self.screeningView = [[FDSlideBar alloc]initWithFrame:(CGRectMake(0, 1, FNDeviceWidth-75, 30))];
    self.screeningView.backgroundColor  =FNWhiteColor;
    [self.screeningView slideBarItemSelectedCallback:^(NSUInteger index) {
        if ([selfWeak.delegate respondsToSelector:@selector(intypeStairScreenTwoType:)]) {
            [selfWeak.delegate intypeStairScreenTwoType:index];
        }
    }];
    [self addSubview:self.screeningView];
    
    UIView *lineTwo=[[UIView alloc]initWithFrame:CGRectMake(0, 13, 1, 14)];
    lineTwo.backgroundColor=RGB(246, 246, 246);
    [self addSubview:lineTwo];
    
    UIButton *screenBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    screenBtn.selected=NO;
    [screenBtn setImage:IMAGE(@"FJ_ySJ_topimg") forState:UIControlStateNormal];
    [screenBtn setImage:IMAGE(@"FJ_ySJ_Botimg") forState:UIControlStateSelected];
    [screenBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [screenBtn setTitle:@"筛选" forState:UIControlStateSelected];
    screenBtn.titleLabel.font=kFONT13;
    [screenBtn addTarget:self action:@selector(screenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:screenBtn];
    self.screenBtn=screenBtn;
    
    UIView *lineThree=[[UIView alloc]initWithFrame:CGRectMake(0, 31, FNDeviceWidth, 1)];
    lineThree.backgroundColor=RGB(246, 246, 246);
    [self addSubview:lineThree];
    
    UIView *lineOne=[[UIView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth, 1)];
    lineOne.backgroundColor=RGB(246, 246, 246);
    [self addSubview:lineOne];
    
//    NSArray *items = @[@"全部", @"自购", @"推广"];
//    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:items];
//    [segment setApportionsSegmentWidthsByContent:YES];
//    [segment addTarget:self action:@selector(segmentSelected:) forControlEvents:UIControlEventValueChanged];
//    segment.frame = CGRectMake(20, 50, 135, 20);
//    [segment setTintColor:RGB(255, 61, 61)];
//    //[segment setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//     segment.selectedSegmentIndex = 0;
//    [segment setBackgroundImage:[UIImage createImageWithColor:RGB(255, 61, 61)] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
//    segment.layer.cornerRadius = 5;
//    segment.layer.borderColor = RGB(140, 140, 140).CGColor;
//    segment.clipsToBounds = YES;
//    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:RGB(140, 140, 140)};
//    [segment setTitleTextAttributes:dic forState:UIControlStateNormal];
    //[self addSubview:segment];
    //self.segment=segment;
    //[self.segment removeAllSegments];
    //control.selectedSegmentIndex;
    self.screenBtn.sd_layout
    .centerYEqualToView(self.screeningView).heightIs(30).rightSpaceToView(self, 0).widthIs(75);
    [screenBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    
    lineTwo.sd_layout
    .widthIs(1).heightIs(14).centerYEqualToView(self.screeningView).rightSpaceToView(screenBtn, 0);
    
    lineThree.sd_layout
    .widthIs(FNDeviceWidth).heightIs(1).leftSpaceToView(self, 0).topSpaceToView(self.screeningView, 0);
    
    lineOne.sd_layout
    .widthIs(FNDeviceWidth).heightIs(1).leftSpaceToView(self, 0).topSpaceToView(self, 0);   
    
    [self.screeningView selectSlideBarItemAtIndex:0];
}
-(void)screenBtnClick:(UIButton*)btn{
    btn.selected=!btn.selected;
    NSInteger state=0;
    if(btn.selected==YES){
        state=1;
    }else{
        state=0;
    }
    if ([self.delegate respondsToSelector:@selector(intypeStateScreenDupAction:withState:)]) {
        [self.delegate intypeStateScreenDupAction:self.indexPath withState:state];
    }
}

-(void)segmentSelected:(UISegmentedControl *)sender{
    XYLog(@"sender=:%ld",(long)sender.selectedSegmentIndex);
    if ([self.delegate respondsToSelector:@selector(intypeStairScreenThreeType:)]) {
        [self.delegate intypeStairScreenThreeType:sender.selectedSegmentIndex];
    }
}
 
-(void)setModel:(FNstatisticsDeModel *)model{
    _model=model;
    if(model){
        /*NSArray *tabArr=model.tab_list;//@[@"财务报表",@"订单报表"];
        NSMutableArray *title=[NSMutableArray arrayWithCapacity:0];
        FNstatisticsTABModel *oneModel=[FNstatisticsTABModel mj_objectWithKeyValues:tabArr[0]];
        NSString *noColor=oneModel.color;
        NSString *check_color=oneModel.check_color;
        [tabArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNstatisticsTABModel *model=[FNstatisticsTABModel mj_objectWithKeyValues:obj];
            [title addObject:model.name];
        }];
        self.topSlideBar.itemsTitle = title;
        self.topSlideBar.itemColor = [UIColor colorWithHexString:noColor];//RGB(140, 140, 140);
        self.topSlideBar.itemSelectedColor =  [UIColor colorWithHexString:check_color];//RGB(255, 62, 62);
        self.topSlideBar.sliderColor = [UIColor colorWithHexString:check_color];//RGB(255, 62, 62);
        self.topSlideBar.fontSize=14;
        self.topSlideBar.SelectedfontSize=14; */
    }
}
-(void)setTimeArray:(NSMutableArray *)timeArray{
    _timeArray=timeArray;
    if(timeArray.count>0){
        FNstatisticsTimeModel *oneModel=timeArray[0];
        NSString *noColor=oneModel.color;
        NSString *check_color=oneModel.check_color;
        //NSArray *name=@[@"今日",@"昨日",@"近一周",@"近一个月"];
        NSMutableArray *nameArr=[NSMutableArray arrayWithCapacity:0];
        [timeArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNstatisticsTimeModel *model=obj;
            [nameArr addObject:model.name];
        }];
        self.screeningView.itemsTitle = nameArr;
        self.screeningView.itemColor = [UIColor colorWithHexString:noColor];//RGB(140, 140, 140);
        self.screeningView.itemSelectedColor =[UIColor colorWithHexString:check_color];// RGB(255, 62, 62);
        self.screeningView.sliderColor = [UIColor whiteColor];
        self.screeningView.fontSize=12;
        self.screeningView.SelectedfontSize=12; 
        
        [self.screenBtn setTitleColor:RGB(140, 140, 140) forState:UIControlStateNormal];
        [self.screenBtn setTitleColor:RGB(255, 61, 61) forState:UIControlStateSelected];
    }
}
-(void)setOrdertypeArray:(NSMutableArray *)ordertypeArray{
    _ordertypeArray=ordertypeArray;
    if(ordertypeArray.count>0){
        NSMutableArray *nameArr=[NSMutableArray arrayWithCapacity:0];
        [ordertypeArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNstatisticsTimeModel *model=obj;
            [nameArr addObject:model.name];
        }];
        [self.segment removeAllSegments];
        [self.segment removeFromSuperview];
        
        self.segment = [[UISegmentedControl alloc] initWithItems:nameArr];
        FNstatisticsTimeModel *oneModel=ordertypeArray[0];
        NSString *noColor=oneModel.color;
        NSString *checkBJ_color=oneModel.checkbj_color;
        NSString *textNoColor=oneModel.color;
        NSString *textSeleColor=oneModel.check_color;
        [self.segment setApportionsSegmentWidthsByContent:YES];
        [self.segment addTarget:self action:@selector(segmentSelected:) forControlEvents:UIControlEventValueChanged];
        self.segment.frame = CGRectMake(20, 50, 40*ordertypeArray.count, 20);
        [self.segment setTintColor:[UIColor colorWithHexString:checkBJ_color]];//RGB(255, 61, 61)
        //[segment setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        self.segment.selectedSegmentIndex = 0;
        [self.segment setBackgroundImage:[UIImage createImageWithColor:RGB(255, 61, 61)] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        self.segment.layer.cornerRadius = 5;
        self.segment.layer.borderColor = RGB(140, 140, 140).CGColor;
        self.segment.clipsToBounds = YES;
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor colorWithHexString:textNoColor]};
        [self.segment setTitleTextAttributes:dic forState:UIControlStateNormal];
        NSDictionary *seledic = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor colorWithHexString:textSeleColor]};
        [self.segment setTitleTextAttributes:seledic forState:UIControlStateSelected];
        
        [self addSubview:self.segment];
        
    }
}
@end
