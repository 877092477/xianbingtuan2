//
//  FNWaresSortItemACell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNWaresSortItemACell.h"

@implementation FNWaresSortItemACell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews]; 
    }
    return self;
}

- (void)initializedSubviews{
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    self.titleLB.font=[UIFont systemFontOfSize:14];
    self.titleLB.textColor=RGB(51, 51, 51);
    self.titleLB.textAlignment=NSTextAlignmentCenter; 
    
    self.sortImgView=[[UIImageView alloc]init];
    [self addSubview:self.sortImgView];
    
    
    self.titleLB.sd_layout
    .centerXEqualToView(self).centerYEqualToView(self).heightIs(20).widthIs(80);
    self.sortImgView.sd_layout
    .leftSpaceToView(self.titleLB, 3).centerYEqualToView(self).widthIs(5).heightIs(11);
}

-(void)setModel:(FNWaresSortAModel *)model{
    _model=model;
    if(model){
        self.titleLB.text=model.name;
        CGFloat yhq_spanW= [model.name kr_getWidthWithTextHeight:20 font:14];
        if(yhq_spanW>80){
            yhq_spanW=80;
        }
        self.titleLB.sd_layout
        .centerXEqualToView(self).centerYEqualToView(self).heightIs(20).widthIs(yhq_spanW); 
        
        self.sortImgView.sd_layout
        .leftSpaceToView(self.titleLB, 3).centerYEqualToView(self).widthIs(5).heightIs(11);
        if(model.state==1){
           self.titleLB.textColor=RGB(253, 49, 20);
        }else{
           self.titleLB.textColor=RGB(51, 51, 51);
        }
    }
}
@end
