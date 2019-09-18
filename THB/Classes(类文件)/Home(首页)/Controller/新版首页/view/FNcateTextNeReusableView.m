//
//  FNcateTextNeReusableView.m
//  THB
//
//  Created by Jimmy on 2018/12/17.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNcateTextNeReusableView.h"

@implementation FNcateTextNeReusableView
-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

-(void)initUI{
    //商品图片
    self.TypeLB=[UILabel new];
    self.TypeLB.font=FNFontDefault(12);
    [self addSubview:self.TypeLB];
    
    self.TypeLB.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self, 10).rightSpaceToView(self, 10).heightIs(20);
    
    
}
-(void)setModel:(FNLeftclassifyModel *)model{
    _model = model;
    if (model) {
        
        self.TypeLB.text=model.name;
        
    }
}
@end
