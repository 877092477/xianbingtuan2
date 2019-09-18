//
//  FNdeliveryDayItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdeliveryDayItemCell.h"

@implementation FNdeliveryDayItemCell
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
    .centerYEqualToView(self).centerXEqualToView(self).widthIs(25).heightIs(25);
}
-(void)setModel:(FNdeliveryDayModel *)model{
    if(model.state==YES){
       self.imgView.image=IMAGE(model.seletedImg);
    }else{
       self.imgView.image=IMAGE(model.img);
    }
}
@end
