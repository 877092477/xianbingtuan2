//
//  FNmerOrderMsgItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/6.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerOrderMsgItemCell.h"

@implementation FNmerOrderMsgItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.bgView=[[UIView alloc]init];
    [self addSubview:self.bgView];
    self.titleLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.titleLB];
    self.bgView.backgroundColor=[UIColor whiteColor];
    self.titleLB.font=[UIFont systemFontOfSize:12];
    self.titleLB.textColor=RGB(200, 200, 200);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.bgView.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self, 0).rightSpaceToView(self, 10).bottomSpaceToView(self, 0);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self.bgView, 20).centerYEqualToView(self.bgView).rightSpaceToView(self.bgView, 20).heightIs(15);
}
-(void)setModel:(FNmerOrderZZHModel *)model{
    _model=model;
    if (model) {
//        NSString *jointStr=[NSString stringWithFormat:@"%@  %@",model.str,model.val];
//        self.titleLB.text=jointStr;
        
        if ([model.str kr_isNotEmpty] && [model.val kr_isNotEmpty]) {
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",model.str,model.val] attributes:@{NSFontAttributeName: kFONT12,NSForegroundColorAttributeName: RGB(200, 200, 200)}];
            
            [string addAttributes:@{NSForegroundColorAttributeName: RGB(51, 51, 51)} range:NSMakeRange(model.str.length, model.val.length)];
            
            self.titleLB.attributedText = string;
        } else {
            self.titleLB.text=[NSString stringWithFormat:@"%@%@",model.str,model.val];//@"订单号:4503180279";
        }
    }
}
@end
