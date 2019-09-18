//
//  FNWelfareFlowDeCell.m
//  THB
//
//  Created by Jimmy on 2018/12/18.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//免单流程
#import "FNWelfareFlowDeCell.h"
#define _quick_menuH  75
#define _quick_pageH   20
#define kIphone6Width 375.0
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
#define kFit(x) (Screen_Width*((x)/kIphone6Width))
@implementation FNWelfareFlowDeCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializedSubviews];
        
    }
    return self;
}

- (void)initializedSubviews
{
    
    self.backgroundColor=RGB(245, 245, 245);
    
    self.bgView=[[UIView alloc]init];
    self.bgView.backgroundColor=[UIColor whiteColor];
    self.bgView.cornerRadius=15/2;
    [self addSubview:self.bgView];
    
    self.mendLB=[UILabel new];
    self.mendLB.textColor=FNBlackColor;
    self.mendLB.font=kFONT14;
    self.mendLB.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:self.mendLB];
    
    self.baseImageView=[[UIImageView alloc]init];
    [self.bgView addSubview:self.baseImageView];
    
    self.baseLB=[UILabel new];
    self.baseLB.textColor=RGB(129, 128, 129);
    self.baseLB.font=kFONT10;
    self.baseLB.numberOfLines=1;
    self.baseLB.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:self.baseLB];
    
    
    
    
    //圆形按钮模块
    FNFunctionView *functionview = [[FNFunctionView alloc]initWithFrame:(CGRectMake(0, 45, FNDeviceWidth, _quick_menuH))];
    //functionview.backgroundColor=[UIColor orangeColor];//FNWhiteColor;
    functionview.column = 4;
    functionview.row = 1;
    functionview.singleH = 70;
    functionview.scrollview.pagingEnabled=NO;
    functionview.viewh=70;
    functionview.imageW=40;
    functionview.singFont=12;
    [self addSubview:functionview];
    self.functionview=functionview;
    
    
    self.centreline=[UILabel new];
    self.centreline.textColor=RGB(247, 75, 133);
    self.centreline.font=kFONT10;
    self.centreline.text=@"................";
    self.centreline.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.centreline];
    
    self.leftline=[UILabel new];
    self.leftline.textColor=RGB(247, 75, 133);
    self.leftline.font=kFONT10;
    self.leftline.text=@"................";
    self.leftline.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.leftline];
    
    self.rightline=[UILabel new];
    self.rightline.textColor=RGB(247, 75, 133);
    self.rightline.font=kFONT10;
    self.rightline.text=@"................";
    self.rightline.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.rightline];
    
    
    CGFloat inter_10=10;
    CGFloat inter_5=5;
    
    self.bgView.sd_layout
    .bottomEqualToView(self).topSpaceToView(self, inter_10).rightSpaceToView(self, inter_10).leftSpaceToView(self, inter_10);
    
    self.mendLB.sd_layout
    .topSpaceToView(self.bgView, 7.5).rightSpaceToView(self.bgView, inter_10).leftSpaceToView(self.bgView, inter_10).heightIs(20);
    
    self.baseImageView.sd_layout
    .bottomSpaceToView(self.bgView, inter_10).leftSpaceToView(self.bgView, inter_10).widthIs(11).heightIs(11);
    
    self.baseLB.sd_layout
    .centerYEqualToView(self.baseImageView).heightIs(15).leftSpaceToView(self.baseImageView, inter_10).rightSpaceToView(self.bgView, inter_10);
    
    
    NSString * lineLeng=@"..............";
    CGFloat lineW= [self getWidthWithText:lineLeng height:15 font:10];
    CGFloat LRSpace=kFit(55);
    self.centreline.sd_layout
    .centerXEqualToView(self).widthIs(kFit(lineW)).heightIs(15).topSpaceToView(self, 55);
    
    self.leftline.sd_layout
    .widthIs(lineW).heightIs(15).rightSpaceToView(self.centreline, LRSpace).topSpaceToView(self, 55);
    
    self.rightline.sd_layout
    .widthIs(lineW).heightIs(15).leftSpaceToView(self.centreline, LRSpace).topSpaceToView(self, 55);
    
}
-(void)setListArr:(NSArray *)listArr{
    _listArr=listArr;
    if(listArr>0){
        self.functionview.btnClickedBlock = ^(NSInteger index) {
            
        };
        NSMutableArray* images = [NSMutableArray new];
        NSMutableArray* titles = [NSMutableArray new];
        NSMutableArray* font_Colors = [NSMutableArray new];
        
        for (NSDictionary *dict in listArr) {
            FNwelfDeListItemModel *kuaisurukou=[FNwelfDeListItemModel mj_objectWithKeyValues:dict];
            [images addObject:kuaisurukou.img];
            [font_Colors addObject:@"818081"];
            [titles addObject:kuaisurukou.str];
        }
        self.functionview.titles = titles;
        self.functionview.images = images;
        self.functionview.font_Colors = font_Colors;
        self.functionview.height = _quick_menuH;
        
        [self.contentView setNeedsLayout];
        [self.functionview setBtnviews];
    }
}
-(void)setModel:(FNwelfDeModel *)model{
    _model=model;
    if(model){
        self.mendLB.text=model.name;//@"免单流程";
       [self.baseImageView setUrlImg:model.miandan_tiplogo];
        self.baseLB.text=model.str;//@"温馨提示：同一账号，同一商品仅能享受一次优惠活动哦！";
    }
}

//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}
@end
