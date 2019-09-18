//
//  FNcartogramImgCell.m
//  THB
//
//  Created by Jimmy on 2018/12/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//统计图
#import "FNcartogramImgCell.h"

@implementation FNcartogramImgCell


-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    
    UIView *grayline=[UIView new];
    grayline.backgroundColor=RGB(246, 246, 246);
    [self addSubview:grayline];
    self.grayline=grayline;
    
    UIButton *moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setTitle:@"更多明细 >>" forState:UIControlStateNormal];
    [moreBtn setTitleColor:RGB(42, 152, 254) forState:UIControlStateNormal];
    moreBtn.titleLabel.font=kFONT12;
    [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:moreBtn];
    self.moreBtn=moreBtn;
    
    self.line=[[UIView alloc]initWithFrame:CGRectMake(0, 53, 1, 14)];
    self.line.backgroundColor=RGB(246, 246, 246);
    [self addSubview:self.line];
    
    self.grayline.sd_layout
    .centerXEqualToView(self).widthIs(FNDeviceWidth).heightIs(20).bottomEqualToView(self);
    
    self.moreBtn.sd_layout
    .centerXEqualToView(self).widthIs(100).heightIs(30).bottomSpaceToView(self.grayline, 0);
    
    self.line.sd_layout
    .leftSpaceToView(self, 10).rightSpaceToView(self, 10).heightIs(1).bottomSpaceToView(self.moreBtn, 0);
    
    self.aaChartView = [[AAChartView alloc]init];
    self.aaChartView.frame = CGRectMake(15, 10, FNDeviceWidth-30, 220);
    self.aaChartView.delegate = self;
    self.aaChartView.scrollEnabled = YES;//禁用 AAChartView 滚动效果
    [self addSubview:self.aaChartView];
    self.aaChartView.backgroundColor = [UIColor clearColor];
    //设置 AAChartView 的背景色是否为透明
    self.aaChartView.isClearBackgroundColor = YES;
    self.aaChartView.contentWidth=FNDeviceWidth-30+10;
    
}
-(void)moreBtnClick{
    
}
#pragma mark -- AAChartView delegate
- (void)AAChartViewDidFinishLoad {
    //NSLog(@" AAChartView content did finish load!!!");
}
-(void)setPicDataArr:(NSMutableArray *)picDataArr{
    _picDataArr=picDataArr;
    if (picDataArr) {
        NSMutableArray *timeArr=[NSMutableArray arrayWithCapacity:0];
        NSMutableArray *valArr=[NSMutableArray arrayWithCapacity:0];
        NSMutableArray *val1Arr=[NSMutableArray arrayWithCapacity:0];
        NSString *color1=@"";
        NSString *color2=@"";
        NSString *name1=@"";
        NSString *name2=@"";
        NSMutableArray *jointArr=[NSMutableArray arrayWithCapacity:0];
        
        for (NSDictionary *dictry  in picDataArr) {
            FNstatisticsItemTimeModel *item=[FNstatisticsItemTimeModel mj_objectWithKeyValues:dictry];
            
            NSString *oneString=[NSString stringWithFormat:@"%.3f",[item.val floatValue]];
            NSNumberFormatter *oneF = [[NSNumberFormatter alloc] init];
            oneF.numberStyle = NSNumberFormatterDecimalStyle;
            NSNumber *num1=[oneF numberFromString:oneString];
            //NSNumber *num1=[NSNumber numberWithFloat:[item.val floatValue]];
            
            NSNumberFormatter *twoF = [[NSNumberFormatter alloc] init];
            twoF.numberStyle = NSNumberFormatterDecimalStyle;
            NSString *twoString=[NSString stringWithFormat:@"%.3f",[item.val1 floatValue]];
            NSNumber *num2=[twoF numberFromString:twoString];
            //NSNumber *num2=[NSNumber numberWithFloat:[item.val1 floatValue]];
            
            [timeArr addObject:item.time];
            [valArr addObject:num1];
            [val1Arr addObject:num2];
            color1=[NSString stringWithFormat:@"#%@",item.val_color];
            color2=[NSString stringWithFormat:@"#%@",item.val1_color];
            name1=item.name;
            name2=item.name1;
            
            [jointArr addObject:item.val];
            [jointArr addObject:item.val1];
        }
        NSMutableArray *fairlyArr=[NSMutableArray arrayWithCapacity:0];
        for (NSString *string in jointArr) {
            if([string isEqualToString:@"0"]){
                [fairlyArr addObject:string];
            }
        }
//        if(fairlyArr.count==jointArr.count){
//            self.grayline.hidden=YES;
//            self.moreBtn.hidden=YES;
//            self.aaChartView.hidden=YES;
//            self.line.hidden=YES;
//        }
//        else{
//            self.grayline.hidden=NO;
//            self.moreBtn.hidden=NO;
//            self.aaChartView.hidden=NO;
//            self.line.hidden=NO;
//        }
        
        CGFloat maxPrice = [[jointArr valueForKeyPath:@"@max.floatValue"] floatValue]+10;
        CGFloat minPrice = [[jointArr valueForKeyPath:@"@min.floatValue"] floatValue];
        
        
        NSString *maxString=[NSString stringWithFormat:@"%.4f",maxPrice];
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber *numMax=[f numberFromString:maxString];
        //NSNumber *numMax=[NSNumber numberWithFloat:maxPrice];
        NSNumber *numMin=[NSNumber numberWithFloat:minPrice];
        
        //设置aaChartVie 的内容高度(content height)
        self.aaChartView.contentHeight = 220;
        CGFloat contentW=46*timeArr.count;
        if (contentW<FNDeviceWidth-30) {
            contentW=FNDeviceWidth-30+10;
        }
        
        //设置aaChartVie 的内容宽度(content  width)
        self.aaChartView.contentWidth =  contentW;//46*timeArr.count;
        AAChartType chartType = AAChartTypeSpline;//样式
        self.aaChartModel= AAChartModel.new
        .chartTypeSet(chartType)//图表类型
        .titleSet(@"")//图表主标题
        .subtitleSet(@"")//图表副标题
        .yAxisLineWidthSet(@0)//Y轴轴线线宽为0即是隐藏Y轴轴线
        .colorsThemeSet(@[color1,color2])//设置主体颜色数组
        .yAxisTitleSet(@"")//设置 Y 轴标题
        .tooltipValueSuffixSet(@"")//设置浮动提示框单位后缀
        .backgroundColorSet(@"#ffffff")//#4b2b7f
        .yAxisGridLineWidthSet(@0)//y轴横向分割线宽度为0(即是隐藏分割线)
        .seriesSet(@[
                     AASeriesElement.new
                     .nameSet(name1)
                     .dataSet(valArr),
                     AASeriesElement.new
                     .nameSet(name2)
                     .dataSet(val1Arr)
                     ]
                   );
        //@[@7.0, @6.9, @9.5, @14.5, @18.2, @21.5]
        self.aaChartModel.yAxisLabelsFontColor=(@"#FFFFFF");
        self.aaChartModel.legendEnabledSet(false);
        self.aaChartModel.tooltipShared=NO;
        //为不同类型图表设置样式
        _aaChartModel.markerSymbol =AAChartSymbolTypeCircle;
        _aaChartModel.categories = timeArr;
        //@[@"12/01", @"12/02", @"12/03", @"12/04", @"12/05", @"12/06", @"12/07", @"12/08", @"12/09", @"12/10", @"12/11", @"12/12", @"12/01"];
        //设置 X 轴坐标文字内容
        _aaChartModel.animationType = AAChartAnimationBounce;//图形的渲染动画为弹性动画
        _aaChartModel.yAxisTitle = @"";
        _aaChartModel.markerSymbolStyle = AAChartSymbolStyleTypeDefault;//设置折线连接点样式为:边缘白色
        _aaChartModel.xAxisCrosshairWidth = @1;
        _aaChartModel.xAxisCrosshairColor = @"#ffffff";//@"#778899";//浅石板灰准星线
        _aaChartModel.xAxisCrosshairDashStyleType = AALineDashSyleTypeLongDashDotDot;
        _aaChartModel.animationDuration = @1000;//图形渲染动画时长为1200毫秒
        //配置 Y 轴标注线,解开注释,即可查看添加标注线之后的图表效果
        _aaChartModel
        .yAxisMaxSet(numMax)//Y轴最大值
        .yAxisMinSet(numMin)//Y轴最小值
        .yAxisAllowDecimalsSet(NO)//是否允许Y轴坐标值小数
        .yAxisTickPositionsSet(@[numMin,numMax]);
        [self.aaChartView aa_drawChartWithChartModel:_aaChartModel];
        
       
        
    }
}
@end
