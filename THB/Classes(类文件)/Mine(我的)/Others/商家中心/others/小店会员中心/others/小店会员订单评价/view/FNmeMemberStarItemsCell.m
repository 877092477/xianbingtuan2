//
//  FNmeMemberStarItemsCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmeMemberStarItemsCell.h"

@implementation FNmeMemberStarItemsCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    self.imgView=[[UIImageView alloc]init];
    [self addSubview:self.imgView];
    self.imgView.sd_layout 
    .leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
}

-(void)setModel:(FNmeMemberStarsModel *)model{
    _model=model;
    if(model){
        if([model.state integerValue]==0){
            self.imgView.image=IMAGE(model.imgNor);
        }else{
            self.imgView.image=IMAGE(model.imgSeleted);
        }
    }
}
@end
