//
//  FNcanGrowUpTopCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcanGrowUpTopCell.h"

@implementation FNcanGrowUpTopCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    self.headImgView=[[UIImageView alloc]init];
    [self addSubview:self.headImgView];
    
    self.headStateImgView=[[UIImageView alloc]init];
    [self addSubview:self.headStateImgView];
    
    self.valueJoLB=[[UILabel alloc]init];
    [self addSubview:self.valueJoLB];
    
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    
    self.hintLB=[[UILabel alloc]init];
    [self addSubview:self.hintLB];
    
    self.nameLB.font=[UIFont systemFontOfSize:15];
    self.nameLB.textColor=[UIColor whiteColor];
    self.nameLB.textAlignment=NSTextAlignmentLeft;
    
    self.valueJoLB.font=[UIFont systemFontOfSize:12];
    self.valueJoLB.textColor=[UIColor whiteColor];
    self.valueJoLB.textAlignment=NSTextAlignmentLeft;
    
    self.hintLB.font=[UIFont systemFontOfSize:12];
    self.hintLB.textColor=RGB(149, 149, 151);
    self.hintLB.textAlignment=NSTextAlignmentCenter;
    
    self.headImgView.cornerRadius=62/2;
    self.headImgView.borderWidth=1;
    self.headImgView.borderColor=RGB(252, 211, 53);
    self.headImgView.clipsToBounds = YES;
    
    CGFloat topGap=SafeAreaTopHeight;
    self.headImgView.sd_layout
    .leftSpaceToView(self, 20).topSpaceToView(self, topGap).widthIs(62).heightIs(62);
    [self.headStateImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImgView.mas_right).offset(-14);
        make.bottom.equalTo(self.headImgView.mas_bottom).offset(-43);
        make.height.equalTo(@30);
        make.width.equalTo(@28);
    }];
    
    self.nameLB.sd_layout
    .leftSpaceToView(self.headImgView, 28).centerYEqualToView(self.headImgView).heightIs(19).rightSpaceToView(self, 10);
    
    self.valueJoLB.sd_layout
    .leftSpaceToView(self.headImgView, 28).bottomEqualToView(self.headImgView).rightSpaceToView(self, 10).heightIs(16);
    
    self.hintLB.sd_layout
    .leftSpaceToView(self, 20).rightSpaceToView(self, 20).heightIs(16).bottomSpaceToView(self, 40);
    
    self.gradeView=[[FNcanGrowUpGradeView alloc]init];
    self.gradeView.frame=CGRectMake(9, 147, FNDeviceWidth-18, 50);
    [self addSubview:self.gradeView];
    
    self.gradeView.sd_layout
    .leftSpaceToView(self, 9).rightSpaceToView(self, 9).heightIs(50).topSpaceToView(self.headImgView, 20);
    
}

-(void)setModel:(FNcandiesGrowModel *)model{
    _model=model;
    if(model){
        [self.headImgView setUrlImg:model.head_img];
        self.nameLB.text=model.nickname;//@"可爱的小鱼";
        self.valueJoLB.text=[NSString stringWithFormat:@"%@ | %@",model.now_experie_str,model.sxf];
        //@"成长值：3541 | 手续费：1%";
        self.hintLB.text=model.dwqkb_grow_upgrade_detial;//@"距下已等级还需要2成长值";
        self.nameLB.textColor=[UIColor colorWithHexString:model.dwqkb_grow_top_color];
        self.valueJoLB.textColor=[UIColor colorWithHexString:model.dwqkb_grow_top_color];
        self.hintLB.textColor=[UIColor colorWithHexString:model.dwqkb_grow_upgrade_detial_color];
    }
}
@end
