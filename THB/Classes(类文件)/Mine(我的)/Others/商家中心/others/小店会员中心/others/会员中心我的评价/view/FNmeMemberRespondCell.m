//
//  FNmeMemberRespondCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/21.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmeMemberRespondCell.h"

@implementation FNmeMemberRespondCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.imgView=[[UIImageView alloc]init];
    [self addSubview:self.imgView];
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.titleLB.font=[UIFont systemFontOfSize:11];
    self.titleLB.textColor=RGB(102, 102, 102);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.imgView.sd_layout
    .leftSpaceToView(self, 68).widthIs(11).heightIs(11).topSpaceToView(self, 12);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self.imgView, 7).rightSpaceToView(self, 15).topSpaceToView(self, 10).bottomSpaceToView(self, 15);
    
    self.lineView=[[UIView alloc]init];
    [self addSubview:self.lineView];
    self.lineView.backgroundColor=RGB(232, 232, 232);
    self.lineView.sd_layout
    .leftSpaceToView(self, 60).rightSpaceToView(self, 15).topSpaceToView(self, 0).heightIs(1);
    
}
-(void)setModel:(FNmerchentReviewModel *)model{
    _model=model;
    if(model){
        [self.imgView setUrlImg:model.sub_comment_icon];
        self.titleLB.text=[NSString stringWithFormat:@"%@:  %@",model.sub_comment_str,model.sub_comment];
        if([model.sub_comment_str kr_isNotEmpty]){
           [self.titleLB fn_changeColorWithTextColor:RGB(153, 153, 153) changeText:model.sub_comment_str];
        }
    }
}
@end
