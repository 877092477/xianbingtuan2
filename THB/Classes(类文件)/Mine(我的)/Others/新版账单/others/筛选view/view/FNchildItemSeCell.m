//
//  FNchildItemSeCell.m
//  THB
//
//  Created by Jimmy on 2018/12/26.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNchildItemSeCell.h"

@implementation FNchildItemSeCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews
{
    self.titleLB=[UILabel new];
    self.titleLB.textColor=RGB(140,140,140);
    self.titleLB.font=kFONT13;
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    self.titleLB.backgroundColor=[UIColor whiteColor];
    self.titleLB.borderWidth=0.5;
    self.titleLB.borderColor=RGB(140,140,140);
    self.titleLB.cornerRadius=2.5;
    self.titleLB.clipsToBounds = YES;
    [self addSubview:self.titleLB];
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
    //[self.titleLB setSingleLineAutoResizeWithMaxWidth:280];
    
    //self.titleLB.text=@"会员升级";
}

-(void)setModel:(FNreckScreenItemModel *)model{
    _model=model;
    if(model){
        NSInteger state=model.state;
        self.titleLB.text=model.name;
        if(state==1){
            self.titleLB.backgroundColor=RGB(255,90,0);
            self.titleLB.textColor=[UIColor whiteColor];
            self.titleLB.borderColor=RGB(255,90,0); 
            if(model.typeInt==1){
                self.titleLB.backgroundColor=[UIColor colorWithHexString:model.check_bj_color];
                self.titleLB.textColor=[UIColor colorWithHexString:model.check_color];
                self.titleLB.borderColor=[UIColor colorWithHexString:model.check_bj_color];
            }
        }else{
            self.titleLB.backgroundColor=[UIColor whiteColor];
            self.titleLB.textColor=RGB(140,140,140);
            self.titleLB.borderColor=RGB(140,140,140);
            if(model.typeInt==1){
                self.titleLB.backgroundColor=[UIColor colorWithHexString:model.bj_color];
                self.titleLB.textColor=[UIColor colorWithHexString:model.color];
                self.titleLB.borderColor=[UIColor colorWithHexString:model.color];
            }
        }
    }
}
@end
