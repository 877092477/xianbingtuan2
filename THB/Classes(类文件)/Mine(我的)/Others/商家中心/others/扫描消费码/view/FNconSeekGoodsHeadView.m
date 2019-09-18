//
//  FNconSeekGoodsHeadView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNconSeekGoodsHeadView.h"

@implementation FNconSeekGoodsHeadView
-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self initSubviewsUI];
    }
    return self;
}
-(void)initSubviewsUI{
    self.bgView=[[UIView alloc]init];
    [self addSubview:self.bgView];
    
    self.titleLB=[[UILabel alloc]init];
    [self.bgView addSubview:self.titleLB];
    
    self.lineView=[[UIView alloc]init];
    [self.bgView addSubview:self.lineView];
    
    self.bgView.backgroundColor=[UIColor whiteColor];
    //self.lineView.backgroundColor=RGB(246, 245, 245);
    
    self.titleLB.font=[UIFont systemFontOfSize:16];
    self.titleLB.textColor=RGB(60, 60, 60);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.bgView.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self, 10).rightSpaceToView(self, 10).bottomSpaceToView(self, 0);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self.bgView, 10).centerYEqualToView(self.bgView).rightSpaceToView(self.bgView, 10).heightIs(14);
    
    self.lineView.sd_layout
    .leftSpaceToView(self.bgView, 10).rightSpaceToView(self.bgView, 10).bottomSpaceToView(self.bgView, 0).heightIs(1);
}
@end
