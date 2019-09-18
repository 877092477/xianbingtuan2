//
//  FNOddStyleLItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNOddStyleLItemCell.h"

@implementation FNOddStyleLItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews{
    self.stateImg=[[UIImageView alloc]init];
    [self addSubview:self.stateImg];
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];   
    self.titleLB.font=[UIFont systemFontOfSize:14];
    self.titleLB.textColor=RGB(153, 153, 153);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    self.stateImg.sd_layout
    .leftSpaceToView(self, 5).centerYEqualToView(self).widthIs(14).heightIs(14);
    self.titleLB.sd_layout
    .leftSpaceToView(self, 20).centerYEqualToView(self).rightSpaceToView(self, 15).heightIs(20);
}

-(void)setModel:(FNdisOddLaunchMoItemModel *)model{
    _model=model;
    if(model){
        self.titleLB.text=model.title;
        if(model.stateInt==0){
            self.stateImg.image=IMAGE(@"FN_DH_NgKzImg");
        }else{
            self.stateImg.image=IMAGE(@"FN_DH_SgKzImg");
        }
    }
}
@end
