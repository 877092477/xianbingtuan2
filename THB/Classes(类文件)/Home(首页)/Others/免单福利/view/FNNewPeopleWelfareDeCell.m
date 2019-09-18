//
//  FNNewPeopleWelfareDeCell.m
//  THB
//
//  Created by Jimmy on 2018/12/18.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//新人
#import "FNNewPeopleWelfareDeCell.h"

@implementation FNNewPeopleWelfareDeCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializedSubviews];
        
    }
    return self;
}

- (void)initializedSubviews
{
    
    self.backgroundColor=RGB(245, 245, 245);
    
//    self.bgView=[[UIView alloc]init];
//    self.bgView.backgroundColor=[UIColor whiteColor];
//    self.bgView.cornerRadius=15/2;
//    [self addSubview:self.bgView];
    
    
    self.goodsView=[[FNpeopleNewDeView alloc]initWithFrame:CGRectMake(0, 0, FNDeviceWidth-20, 230)];
    self.goodsView.backgroundColor=RGB(245, 245, 245);
    self.goodsView.goodscollectionview.backgroundColor=RGB(245, 245, 245);
    [self addSubview:self.goodsView];
    
}
-(void)setDataArr:(NSArray *)dataArr{
    _dataArr=dataArr;
    if(dataArr){
       self.goodsView.dataArr=dataArr;
    }
}
-(void)incomposition{
    CGFloat inter_20=20;
    CGFloat inter_10=10;
    CGFloat inter_5=5;
    self.bgView.sd_layout
    .bottomEqualToView(self).topSpaceToView(self, inter_10).rightSpaceToView(self, inter_10).leftSpaceToView(self, inter_10);
}
@end
