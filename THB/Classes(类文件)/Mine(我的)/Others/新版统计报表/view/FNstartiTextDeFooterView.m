//
//  FNstartiTextDeFooterView.m
//  THB
//
//  Created by Jimmy on 2018/12/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNstartiTextDeFooterView.h"

@implementation FNstartiTextDeFooterView
-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    
    self.backgroundColor=RGB(246, 245, 245);
    
    UIView *topView=[UIView new];
    topView.backgroundColor=[UIColor whiteColor];
    [self addSubview:topView];
    
    self.hintLB=[UILabel new];
    self.hintLB.font=kFONT12;
    self.hintLB.textColor=RGB(200,200,200);
    self.hintLB.textAlignment=NSTextAlignmentCenter;
    self.hintLB.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.hintLB];
    
    topView.sd_layout
    .heightIs(10).topSpaceToView(self, 0).leftSpaceToView(self, 0).rightSpaceToView(self, 0);
    
    self.hintLB.sd_layout
    .heightIs(25).topSpaceToView(topView, 0).leftSpaceToView(self, 0).rightSpaceToView(self, 0);
    
    //self.hintLB.text=@"每个月20日结算上月预估收入，本月预估收入则在下月20日结算";
    @WeakObj(self);
    self.topSlideBar = [[FDSlideBar alloc] initWithFrame:CGRectMake(0, 45, FNDeviceWidth, 40)];
    self.topSlideBar.backgroundColor = FNWhiteColor;
    //self.topSlideBar.is_middle=YES;
    self.topSlideBar.is_mean=YES;
    [self.topSlideBar selectSlideBarItemAtIndex:0];
    [self.topSlideBar slideBarItemSelectedCallback:^(NSUInteger index) {
        if ([selfWeak.delegate respondsToSelector:@selector(intypeStairScreenType:)]) {
            [selfWeak.delegate intypeStairScreenType:index];
        }
    }];
    [self addSubview:self.topSlideBar];
}
-(void)setModel:(FNstatisticsDeModel *)model{
    _model=model;
    if(model){
        NSArray *tabArr=model.tab_list;//@[@"财务报表",@"订单报表"];
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
        self.topSlideBar.SelectedfontSize=14;
    }
}
-(void)setTopOneType:(NSInteger)topOneType{
    _topOneType=topOneType;
    if(topOneType){
        [self.topSlideBar selectSlideBarItemAtIndex:topOneType];
    }
}
@end
