//
//  FNlogisticsHeadView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/2.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNlogisticsHeadView.h"

@implementation FNlogisticsHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    self.imgView=[[UIImageView alloc]init];
    [self addSubview:self.imgView];
    
    self.orderLB=[[UILabel alloc]init];
    [self addSubview:self.orderLB];
    
    self.stateLB=[[UILabel alloc]init];
    [self addSubview:self.stateLB];
    
    self.cyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.cyBtn];
    
    self.lineView=[[UIView alloc]init];
    [self addSubview:self.lineView];
    
    self.wlImgView=[[UIImageView alloc]init];
    [self addSubview:self.wlImgView];
    
    self.wlNameLB=[[UILabel alloc]init];
    [self addSubview:self.wlNameLB];
    
    self.orderLB.font=[UIFont systemFontOfSize:12];
    self.orderLB.textColor=RGB(39, 39, 46);
    self.orderLB.textAlignment=NSTextAlignmentLeft;
    
    self.stateLB.font=[UIFont systemFontOfSize:12];
    self.stateLB.textColor=RGB(39, 39, 46);
    self.stateLB.textAlignment=NSTextAlignmentRight;
    
    self.wlNameLB.font=[UIFont systemFontOfSize:15];
    self.wlNameLB.textColor=RGB(31, 31, 31);
    self.wlNameLB.textAlignment=NSTextAlignmentLeft;
    
    self.imgView.sd_layout
    .topSpaceToView(self, 0).leftSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(195);
    
    self.orderLB.sd_layout
    .leftSpaceToView(self, 12).topSpaceToView(self.imgView, 6).heightIs(16).widthIs(180);
    
    self.stateLB.sd_layout
    .rightSpaceToView(self, 15).topSpaceToView(self.imgView, 6).heightIs(16).widthIs(80);
    
    self.cyBtn.sd_layout
    .leftSpaceToView(self.orderLB, 0).centerYEqualToView(self.orderLB).widthIs(30).heightIs(30);
    
    self.cyBtn.imageView.sd_layout
    .centerYEqualToView(self.cyBtn).centerYEqualToView(self.cyBtn).widthIs(11).heightIs(11);
    
    self.lineView.sd_layout
    .leftSpaceToView(self, 12).rightSpaceToView(self, 12).bottomSpaceToView(self, 0).heightIs(1);
    
    self.wlImgView.sd_layout
    .leftSpaceToView(self, 12).topSpaceToView(self, 172).widthIs(28).heightIs(15);
    
    self.wlNameLB.sd_layout
    .leftSpaceToView(self.wlImgView, 5).centerYEqualToView(self.wlImgView).heightIs(19).rightSpaceToView(self, 12);
    
    self.imgView.image=IMAGE(@"FN_wuliu_bgimg");
    self.orderLB.text=@" ";
    self.stateLB.text=@" ";
}

-(void)setModel:(FNlogisticsInfoModel *)model{
    _model=model;
    if(model){
        [self.imgView setUrlImg:model.img];
        [self.wlImgView setUrlImg:model.wl_ico];
        self.wlNameLB.text=model.wl_name;
        self.wlNameLB.textColor=[UIColor colorWithHexString:model.wl_name_color];
        NSString *joint1Str=[NSString stringWithFormat:@"%@%@",model.str,model.wl_num];
        NSString *joint2Str=[NSString stringWithFormat:@"%@%@",model.status_str,model.status];
        if([model.wl_num kr_isNotEmpty]){
           self.orderLB.text=joint1Str;
           [self.cyBtn setImage:IMAGE(@"FN_logisticsCopy") forState:UIControlStateNormal];
            CGFloat orderLBW=[joint1Str kr_getWidthWithTextHeight:16 font:12];
            if(orderLBW>180){
               orderLBW=180;
            }
            self.orderLB.sd_layout
            .leftSpaceToView(self, 12).topSpaceToView(self.imgView, 6).heightIs(16).widthIs(orderLBW);
            self.cyBtn.sd_layout
            .leftSpaceToView(self.orderLB, 0).centerYEqualToView(self.orderLB).widthIs(30).heightIs(30);
            
            self.lineView.backgroundColor=RGB(240, 240, 240);
        }
        if([model.status kr_isNotEmpty]){
            self.stateLB.text=joint2Str;
            [self.stateLB fn_changeColorWithTextColor:[UIColor colorWithHexString:model.status_color] changeText:model.status];
        } 
    }
}
@end
