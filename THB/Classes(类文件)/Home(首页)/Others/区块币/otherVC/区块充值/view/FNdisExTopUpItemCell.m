//
//  FNdisExTopUpItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/9.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdisExTopUpItemCell.h"

@implementation FNdisExTopUpItemCell
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
    
    self.stateLB=[[UILabel alloc]init];
    [self addSubview:self.stateLB];
    
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    
    self.sumLB=[[UILabel alloc]init];
    [self addSubview:self.sumLB];
    
    self.dateLB=[[UILabel alloc]init];
    [self addSubview:self.dateLB];
    
    self.lineView=[[UIView alloc]init];
    [self addSubview:self.lineView];
    
    self.stateLB.font=[UIFont systemFontOfSize:15];
    self.stateLB.textColor=RGB(51, 51, 51);
    self.stateLB.textAlignment=NSTextAlignmentLeft;
    
    self.nameLB.font=[UIFont systemFontOfSize:12];
    self.nameLB.textColor=RGB(51, 51, 51);
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.sumLB.font=[UIFont systemFontOfSize:18];
    self.sumLB.textColor=RGB(51, 51, 51);
    self.sumLB.textAlignment=NSTextAlignmentRight;
    
    self.dateLB.font=[UIFont systemFontOfSize:12];
    self.dateLB.textColor=RGB(153, 153, 153);
    self.dateLB.textAlignment=NSTextAlignmentLeft;
    
    self.lineView.backgroundColor=RGB(250, 250, 250);
    
    self.stateImg.sd_layout
    .leftSpaceToView(self, 19).topSpaceToView(self, 19).widthIs(32).heightIs(32);
    
    self.stateLB.sd_layout
    .leftSpaceToView(self.stateImg, 21).topSpaceToView(self, 18).widthIs(90).heightIs(19);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.stateImg, 21).topSpaceToView(self, 43).rightSpaceToView(self, 20).heightIs(16);
    
    self.dateLB.sd_layout
    .leftSpaceToView(self.stateImg, 21).topSpaceToView(self.nameLB, 5).rightSpaceToView(self, 20).heightIs(16);
    
    self.sumLB.sd_layout
    .leftSpaceToView(self.stateLB, 10).rightSpaceToView(self, 20).topSpaceToView(self, 18).heightIs(19);
    
    self.lineView.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0).heightIs(1);
    
}

-(void)setModel:(FNdisExTopUpItemModel *)model{
    _model=model;
    if(model){
        [self.stateImg setUrlImg:model.icon]; 
        self.stateLB.text=@"余额充值";
        self.nameLB.text=[NSString stringWithFormat:@"充值方式：%@",model.type];
        self.dateLB.text=[NSString stringWithFormat:@"充值时间:%@",model.time];
        self.sumLB.text=[NSString stringWithFormat:@"+%@",model.money];
    }
}
@end
