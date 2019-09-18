//
//  FNmeMemberNorItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmeMemberNorItemCell.h"

@implementation FNmeMemberNorItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.imgView=[[UIImageView alloc]init];
    [self addSubview:self.imgView]; 
    
    self.hintLB=[[UILabel alloc]init];
    [self addSubview:self.hintLB];
    
    self.lookBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.lookBtn];
    
    self.lookBtn.backgroundColor=RGB(255, 155, 48);
    self.lookBtn.cornerRadius=5;
    self.lookBtn.titleLabel.font=kFONT17;
    [self.lookBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.hintLB.font=[UIFont systemFontOfSize:18];
    self.hintLB.textColor=RGB(200, 200, 200);
    self.hintLB.textAlignment=NSTextAlignmentCenter;
    
    self.imgView.sd_layout
    .centerXEqualToView(self).topSpaceToView(self, 107).widthIs(204).heightIs(150);
    
    self.hintLB.sd_layout
    .leftSpaceToView(self, 15).topSpaceToView(self.imgView, 28).rightSpaceToView(self, 15).heightIs(22);
    
    self.lookBtn.sd_layout
    .widthIs(164).heightIs(43).centerXEqualToView(self).topSpaceToView(self.imgView, 67);
    
    self.hintLB.text=@"暂无订单信息";
    [self.lookBtn setTitle:@"快去逛逛" forState:UIControlStateNormal];
    self.imgView.image = IMAGE(@"trade_image_empty");
    self.imgView.contentMode=UIViewContentModeScaleAspectFit;
    self.imgView.clipsToBounds=YES;
}
@end
