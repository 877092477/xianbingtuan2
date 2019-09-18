//
//  MyLikeCell.m
//  THB
//
//  Created by zhongxueyu on 16/3/31.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import "MyLikeCell.h"

@implementation MyLikeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.img.alpha = 0.1f;
    
    // 执行动画
    [UIView animateWithDuration:IMGDuration animations:^{
        self.img.alpha = 1.f;
    }];
    
    
    
    self.title.font = kFONT14;
//    self.originalPrice.font = kFONT12;
    self.price.font = kFONT13;
    self.isrebates.font = kFONT17;
    self.isValid.font = kFONT13;
//    [self.view addSubview:label];
    
}

-(void)setModel:(MyLikeListModel *)model{
    [self.img setUrlImg:model.goods_img];
    self.title.text = model.goods_title;
    self.isValid.text = model.mylike_all_msg;
    self.price.text = [NSString stringWithFormat:@"￥%@",model.goods_price];
    //    加删除线 这是必要的属性
    NSDictionary *attrDict = @{
                               NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle | NSUnderlinePatternSolid),
                               NSStrikethroughColorAttributeName:GrayColor
                               };
    
    //    这里注意需要使用attributedText
    self.originalPrice.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",model.goods_cost_price] attributes:attrDict];
    
    //        cell.originalPrice.text = model.goods_cost_price;
    self.isrebates.text = [NSString stringWithFormat:@"%@%@",model.return_title,[FNBaseSettingModel settingInstance].CustomUnit];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
