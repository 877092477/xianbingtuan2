//
//  FNUpgradeRecommendNCell.m
//  THB
//
//  Created by Jimmy on 2018/9/25.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNUpgradeRecommendNCell.h"
#import "FNUpgradeGoodsNView.h"
#import "FNUpgradeNMode.h"
@implementation FNUpgradeRecommendNCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
    //标题图片
    self.titleImage=[UIImageView new];
    self.titleImage.contentMode=UIViewContentModeScaleToFill;
    //self.titleImage.image=IMAGE(@"APP底图.png");
    [self.contentView addSubview:self.titleImage];
    CGFloat interval_10 = 10;
    self.titleImage.sd_layout
    .topSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, interval_10).rightSpaceToView(self.contentView, interval_10).heightIs(40);
    
    self.GoodsNView=[[FNUpgradeGoodsNView alloc]init];
    self.GoodsNView.frame=CGRectMake(0, 0, JMScreenWidth, 200);
    self.GoodsNView.delegate=self;
    self.GoodsNView.frame=CGRectMake(0, 40, FNDeviceWidth, 175);
    [self.contentView addSubview:self.GoodsNView];
    
    self.LineView=[UIView new];
    self.LineView.backgroundColor=FNColor(239, 239, 239);
    [self.contentView addSubview:self.LineView];
    self.LineView.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(interval_10/2).bottomSpaceToView(self.contentView, 0);
    
}
-(void)setRecommend:(NSDictionary *)recommend{
    _recommend=recommend;
    if(recommend){
        FNrecommendNMode *model=[FNrecommendNMode mj_objectWithKeyValues:recommend];
        [self.titleImage setUrlImg:model.img];
        self.GoodsNView.productArr=model.goods;
        
    }
    
}

-(void)selectRecommendAction:(id)model{
    
    if ([self.delegate respondsToSelector:@selector(selectRecommendNAction:)]) {
        [self.delegate selectRecommendNAction:model];
    }
    
}
@end
