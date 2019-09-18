//
//  MyFootPrintCell.m
//  THB
//
//  Created by zhongxueyu on 16/3/31.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "MyFootPrintCell.h"

@implementation MyFootPrintCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.img.alpha = 0.1f;
    
    // 执行动画
    [UIView animateWithDuration:IMGDuration animations:^{
        self.img.alpha = 1.f;
    }];
    self.title.font = kFONT14;
    self.price.font = kFONT14;
    self.rebates.font = kFONT12;
    self.rebatePercentage.font = kFONT14;
    self.firstTime.font = kFONT10;
    self.lastTime.font = kFONT10;
}

-(void)setModel:(MyFootModel *)model{
    [self.img setUrlImg:model.goods_img];
    self.title.text = model.goods_title;
    self.price.text =[NSString stringWithFormat:@"￥%@",model.goods_price];
    self.rebates.text = [NSString stringWithFormat:@"%@%@%@",model.fan_all_str,model.returnfb,[FNBaseSettingModel settingInstance].CustomUnit];
    //        NSString *footString = model.goods_shop;
    if (![model.goods_shop kr_isNotEmpty]) {
        self.fromShop.text = @"";
    }else{
        self.fromShop.text = [NSString stringWithFormat:@"来自:%@",model.goods_shop];
    }
    self.rebatePercentage.text = [NSString stringWithFormat:@"(比例%.2f%%)",model.returnbl];
    self.firstTime.text = [NSString stringWithFormat:@"首次查看%@",model.starttime];
    self.lastTime.text = [NSString stringWithFormat:@"最后查看%@",model.endtime];
    
    if ([FNDisplayName isEqualToString:@"糖果淘"]){
        self.rebatePercentage.hidden=YES;
    }else{
        self.rebatePercentage.hidden=NO;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
