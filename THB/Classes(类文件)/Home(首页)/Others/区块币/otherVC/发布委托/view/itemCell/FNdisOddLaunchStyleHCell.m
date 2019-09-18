//
//  FNdisOddLaunchStyleHCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdisOddLaunchStyleHCell.h"

@implementation FNdisOddLaunchStyleHCell
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
    self.titleLB.font=[UIFont systemFontOfSize:15];
    self.titleLB.textColor=RGB(51, 51, 51);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    self.titleLB.sd_layout
    .leftSpaceToView(self, 15).centerYEqualToView(self).widthIs(105).heightIs(20);
    
    self.styleView=[[FNdisOddLaunchStyleView alloc]init];
    self.styleView.frame=CGRectMake(123, 0, FNDeviceWidth-123, 50);
    [self addSubview:self.styleView];
}

-(void)setModel:(FNdisOddLaunchModel *)model{
    _model=model;
    if(model){
        NSArray *bottomArr=model.mode;
        
        NSMutableArray *tyArray=[NSMutableArray arrayWithCapacity:0];
        [bottomArr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FNdisOddLaunchMoItemModel *itemModel=[FNdisOddLaunchMoItemModel mj_objectWithKeyValues:obj];
            itemModel.stateID=idx;
            if(idx==0){
                itemModel.stateInt=1;
            }else{
                itemModel.stateInt=0;
            }
            [tyArray addObject:itemModel];
        }];
        self.styleView.dataArr=tyArray;
    }
}
@end
