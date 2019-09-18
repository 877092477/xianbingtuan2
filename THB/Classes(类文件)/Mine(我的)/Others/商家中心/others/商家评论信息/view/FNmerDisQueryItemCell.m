//
//  FNmerDisQueryItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/30.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerDisQueryItemCell.h"

@implementation FNmerDisQueryItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.stateView=[[UIImageView alloc]init];
    [self addSubview:self.stateView];
    
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    
    self.lineView=[[UIView alloc]init];
    [self addSubview:self.lineView];
    self.lineView.backgroundColor=RGB(246, 245, 245);
    
    self.nameLB.font=[UIFont systemFontOfSize:13];
    self.nameLB.textColor=RGB(0, 0, 0);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.nameLB.sd_layout
    .leftSpaceToView(self, 15).centerYEqualToView(self).rightSpaceToView(self, 60).heightIs(20);
    self.stateView.sd_layout
    .rightSpaceToView(self, 16).centerYEqualToView(self).widthIs(15).heightIs(15);
    
    self.lineView.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0).heightIs(1);
    
}

-(void)setModel:(FNmerReviewQueryItemModel *)model{
    _model=model;
    if(model){
        self.nameLB.text=model.str;
        if(model.state==0){
            self.stateView.image=IMAGE(@"FN_merNorRedYWimg");
        }else{
            self.stateView.image=IMAGE(@"FN_merRedYWimg");
        }
    }
}
@end
