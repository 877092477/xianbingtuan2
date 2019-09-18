//
//  FNmeMeEvaluateItemsCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/21.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmeMeEvaluateItemsCell.h"

@implementation FNmeMeEvaluateItemsCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    self.listView=[[FNmeMeEvaluMsgView alloc]initWithFrame:CGRectZero];
    [self addSubview:self.listView];
    self.listView.sd_layout
    .leftSpaceToView(self,  0).rightSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
}
-(void)setModel:(FNmerchentReviewModel *)model{
    _model=model;
    if(model){
        self.listView.model=model;
        
    }
}
@end
