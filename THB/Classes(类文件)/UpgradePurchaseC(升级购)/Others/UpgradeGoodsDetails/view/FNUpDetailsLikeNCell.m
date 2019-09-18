//
//  FNUpDetailsLikeNCell.m
//  THB
//
//  Created by Jimmy on 2018/9/26.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNUpDetailsLikeNCell.h"
#import "FNUpDetailsNModel.h"
@implementation FNUpDetailsLikeNCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCompositionView];
    }
    return self;
}
-(void)setCompositionView{
   
  
    //标题图片
    self.titleImage= [[UIImageView alloc]initWithImage:IMAGE(@"home_highRebate")];
    self.titleImage.hidden=YES;
    self.titleImage.contentMode = UIViewContentModeScaleAspectFit;
    self.titleImage.clipsToBounds = YES;
    [self.contentView addSubview:self.titleImage];
    CGFloat interval_10 = 10;
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.height.equalTo(@40);
    }];
    
    self.GoodsNView=[[FNUpgradeGoodsNView alloc]init];
    self.GoodsNView.delegate=self;
    self.GoodsNView.frame=CGRectMake(0, 45, FNDeviceWidth, 175);
    [self.contentView addSubview:self.GoodsNView];
    
    self.LineView=[UIView new];
    self.LineView.backgroundColor=FNColor(239, 239, 239);
    [self.contentView addSubview:self.LineView];
    self.LineView.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(interval_10/2).bottomSpaceToView(self.contentView, 0);
}
-(void)setRecommend:(NSDictionary *)recommend{
    _recommend=recommend;
    if(recommend){
        FNUpDetailsNModel *model=[FNUpDetailsNModel mj_objectWithKeyValues:recommend];
        FNUpDetailsLikeNModel *like=[FNUpDetailsLikeNModel mj_objectWithKeyValues:model.like];
        [self.titleImage setUrlImg:like.img];
        self.GoodsNView.productArr=like.goods;
        self.titleImage.hidden=NO;
        
    }
    
}
-(void)selectRecommendAction:(id)model{
    
    if ([self.delegate respondsToSelector:@selector(selectDetailsLikeNAction:)]) {
        [self.delegate selectDetailsLikeNAction:model];
    }
}
@end
