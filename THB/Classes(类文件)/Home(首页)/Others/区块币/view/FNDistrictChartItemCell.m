//
//  FNDistrictChartItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNDistrictChartItemCell.h"

@implementation FNDistrictChartItemCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNDistrictChartItemCellID";
    FNDistrictChartItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializedSubviews];
        
    }
    return self;
}

- (void)initializedSubviews{
    //198 
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.priceLB=[[UILabel alloc]init];
    [self addSubview:self.priceLB];
    
    self.stateImgView=[[UIImageView alloc]init];
    [self addSubview:self.stateImgView];
    
    self.yesterdayLB=[[UILabel alloc]init];
    [self addSubview:self.yesterdayLB];
    
    self.titleLB.font=[UIFont systemFontOfSize:15];
    self.titleLB.textColor=RGB(51, 51, 51);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.priceLB.font=[UIFont systemFontOfSize:12];
    self.priceLB.textColor=RGB(255, 96, 58);
    self.priceLB.textAlignment=NSTextAlignmentRight;
    
    self.yesterdayLB.font=[UIFont systemFontOfSize:12];
    self.yesterdayLB.textColor=RGB(153, 153, 153);
    self.yesterdayLB.textAlignment=NSTextAlignmentRight;
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 19).topSpaceToView(self, 16).heightIs(19).widthIs(120);
    
    self.priceLB.sd_layout
    .rightSpaceToView(self, 19).topSpaceToView(self, 16).heightIs(19).widthIs(50);
    
    self.stateImgView.sd_layout
    .rightSpaceToView(self, 72).centerYEqualToView(self.priceLB).heightIs(8).widthIs(14);
    
    self.yesterdayLB.sd_layout
    .rightSpaceToView(self, 88).topSpaceToView(self, 16).heightIs(19).widthIs(50);
    
    self.aaChartView = [[AAChartView alloc]init];
    self.aaChartView.frame = CGRectMake(-50, 55, FNDeviceWidth-15, 150);
    self.aaChartView.delegate = self;
    //self.aaChartView.scrollEnabled = YES;//禁用 AAChartView 滚动效果
    [self addSubview:self.aaChartView];
    self.aaChartView.backgroundColor = [UIColor clearColor];
    //设置 AAChartView 的背景色是否为透明
    self.aaChartView.isClearBackgroundColor = YES;
    self.aaChartView.contentWidth=FNDeviceWidth-15;
    self.aaChartView.contentHeight = 150;
    self.aaChartView.scrollEnabled = NO;
    
}

-(void)setModel:(FNDistrictCoinModel *)model{
    _model=model;
    if(model){
        self.titleLB.textColor=[UIColor colorWithHexString:model.qkb_bz_color];
        self.priceLB.textColor=[UIColor colorWithHexString:model.qkb_zf_color];
        self.yesterdayLB.textColor=[UIColor colorWithHexString:model.qkb_zrzf_color];
        self.titleLB.text=model.qkb_jgzs;
        self.priceLB.text=model.qkb_zrzf_percent;
        self.yesterdayLB.text=model.qkb_zrzf;
        [self.stateImgView setNoPlaceholderUrlImg:model.qkb_zrzf_icon]; 
        CGFloat priceLBW= [self.priceLB.text kr_getWidthWithTextHeight:19 font:12];
        if(priceLBW>90){
            priceLBW=90;
        }
        CGFloat yesterdayLBW= [self.yesterdayLB.text kr_getWidthWithTextHeight:19 font:12];
        if(yesterdayLBW>90){
            yesterdayLBW=90;
        }
        CGFloat stateImgRight=19+priceLBW+2;
        CGFloat yesterdayRight=19+priceLBW+2+14+2;
        self.priceLB.sd_layout
        .rightSpaceToView(self, 19).topSpaceToView(self, 16).heightIs(19).widthIs(priceLBW);
        self.stateImgView.sd_layout
        .rightSpaceToView(self, stateImgRight).centerYEqualToView(self.priceLB).heightIs(8).widthIs(14);
        self.yesterdayLB.sd_layout
        .rightSpaceToView(self, yesterdayRight).topSpaceToView(self, 16).heightIs(19).widthIs(50);
        
        NSDictionary *line_chart=model.line_chart;
        NSArray *qkb_list=line_chart[@"qkb_list"];
        NSString *joint1Str=[NSString stringWithFormat:@"%@",line_chart[@"max"]];
        NSString *joint2Str=[NSString stringWithFormat:@"%@",line_chart[@"min"]];
        CGFloat maxPrice = [joint1Str  floatValue];
        NSString *maxString=[NSString stringWithFormat:@"%.4f",maxPrice+0.0005];
        
        CGFloat minPrice = [joint2Str  floatValue];
        //CGFloat axSFloat=ceilf(maxPrice);
        CGFloat inSFloat=floorf(minPrice);
        
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber *numMax=[f numberFromString:maxString];
        NSNumber *numMin=[NSNumber numberWithFloat:inSFloat];
        
        CGFloat maxWide=[maxString kr_getWidthWithTextHeight:12 font:15];
        CGFloat witeW=FNDeviceWidth-15+maxWide;
        [self.aaChartView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(-maxWide);
            make.top.equalTo(self).offset(55);
            make.height.equalTo(@150);
            make.width.mas_equalTo(witeW);
        }];
        self.aaChartView.contentWidth=witeW;
        if(qkb_list.count>0){
            CGFloat width=(witeW-150)/7;
            NSNumber *numwidth=[NSNumber numberWithFloat:width];
            NSMutableArray *timeArr=[NSMutableArray arrayWithCapacity:0];
            NSMutableArray *valArr=[NSMutableArray arrayWithCapacity:0];
            
            
            NSString *color1=  @"#FF6742";
            if([model.qkb_zf_color kr_isNotEmpty]){
                color1= [NSString stringWithFormat:@"#%@",model.qkb_zf_color];
            }
            NSString *name1=@" ";
            for (NSDictionary *dictry  in qkb_list) {
                FNDistrictCoinChartItemModel *item=[FNDistrictCoinChartItemModel mj_objectWithKeyValues:dictry];
                NSString *oneString=[NSString stringWithFormat:@"%.4f",[item.qkb_wroth floatValue]];
                NSNumberFormatter *oneF = [[NSNumberFormatter alloc] init];
                oneF.numberStyle = NSNumberFormatterDecimalStyle;
                NSNumber *num1=[oneF numberFromString:oneString];
                //NSNumber *num1=[NSNumber numberWithFloat:[item.qkb_wroth floatValue]];
                [timeArr addObject:item.time];
                [valArr addObject:num1];
                
            }
            //设置aaChartVie 的内容宽度(content  width)
            
            AAChartType chartType = AAChartTypeSpline;//样式
            self.aaChartModel= AAChartModel.new
            .chartTypeSet(chartType)//图表类型
            .titleSet(@"")//图表主标题
            .subtitleSet(@"")//图表副标题
            .yAxisLineWidthSet(@0)//Y轴轴线线宽为0即是隐藏Y轴轴线
            .colorsThemeSet(@[color1])//设置主体颜色数组
            .yAxisTitleSet(@"")//设置 Y 轴标题
            .tooltipValueSuffixSet(@"")//设置浮动提示框单位后缀
            .backgroundColorSet(@"#ffffff")//#4b2b7f
            .yAxisGridLineWidthSet(@0)//y轴横向分割线宽度为0(即是隐藏分割线)
            .xAxisGridLineWidthSet(numwidth)
            
            .xAxisCrosshairColorSet(@"#FAFAFA")
            .seriesSet(@[
                         AASeriesElement.new
                         .nameSet(name1)
                         .dataSet(valArr)
                         ]
                       );
            self.aaChartModel.yAxisLabelsFontColor=(@"#FFFFFF");
            self.aaChartModel.yAxisCrosshairColor=(@"#FAFAFA");
            self.aaChartModel.legendEnabledSet(false);
            self.aaChartModel.tooltipShared=NO;
            //为不同类型图表设置样式
            _aaChartModel.markerSymbol =AAChartSymbolTypeCircle;
            _aaChartModel.categories = timeArr; 
            //设置 X 轴坐标文字内容
            _aaChartModel.animationType = AAChartAnimationBounce;//图形的渲染动画为弹性动画
            _aaChartModel.yAxisTitle = @"";
            _aaChartModel.markerSymbolStyle = AAChartSymbolStyleTypeDefault;//设置折线连接点样式为:边缘白色
            _aaChartModel.xAxisCrosshairWidth = @1;
            _aaChartModel.xAxisCrosshairColor = @"#FAFAFA";//@"#778899";//浅石板灰准星线
            _aaChartModel.xAxisLabelsFontColor= @"#999999";
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
}

#pragma mark -- AAChartView delegate
- (void)AAChartViewDidFinishLoad {
    XYLog(@" AAChartView content did finish load!!!");
}
@end
