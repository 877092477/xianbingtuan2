//
//  FNrushNoGoodsNeCell.m
//  每选
//
//  Created by Jimmy on 2018/12/12.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNrushNoGoodsNeCell.h"

@implementation FNrushNoGoodsNeCell
-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        
        [self initUI];
        
    }
    return self;
}
-(void)initUI{
    //260
    self.contentView.backgroundColor=[UIColor whiteColor];
    
    //店铺
    self.goodsImage=[UIImageView new];
    self.goodsImage.image=IMAGE(@"rushNogoods");
    [self.contentView addSubview:self.goodsImage];
    
    //店铺
    self.nogoodLB=[UILabel new];
    [self.nogoodLB sizeToFit];
    self.nogoodLB.textColor=RGB(200, 200, 200);
    self.nogoodLB.font=[UIFont systemFontOfSize:20];
    self.nogoodLB.text=@"附近暂无商店";
    
    [self.contentView addSubview:self.nogoodLB];
    
    [self initPlaceSubviews];
}
#pragma mark - initPlaceSubviews
- (void)initPlaceSubviews {
    
    
    self.goodsImage.sd_layout
    .widthIs(225).heightIs(155).topSpaceToView(self.contentView, 40).centerXEqualToView(self.contentView);
    
    self.nogoodLB.sd_layout
    .topSpaceToView(self.goodsImage, 30).heightIs(20).centerXEqualToView(self.contentView);
    [self.nogoodLB setSingleLineAutoResizeWithMaxWidth:200];
    
   
    
}

@end
