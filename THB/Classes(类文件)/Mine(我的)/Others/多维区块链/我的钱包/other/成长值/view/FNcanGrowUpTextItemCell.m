//
//  FNcanGrowUpTextItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcanGrowUpTextItemCell.h"

@implementation FNcanGrowUpTextItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews { 
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.titleLB.font=[UIFont systemFontOfSize:12];
    self.titleLB.textColor=RGB(44,44,51);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    self.titleLB.numberOfLines=0;
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
    //self.titleLB.backgroundColor=[UIColor whiteColor];
    //self.titleLB.text=@"待冻结成长值";
    
}
-(void)setContentStr:(NSString *)contentStr{
    _contentStr=contentStr;
    if([contentStr kr_isNotEmpty]){
       self.titleLB.text=contentStr;
       CGFloat itemW=[contentStr kr_getWidthWithTextHeight:16 font:12];
       
       if(itemW > FNDeviceWidth-40){
           [self.titleLB fn_changeLineSpaceWithTextLineSpace:10];
       }
       //[self.titleLB updateLayout];
    }
}
@end
