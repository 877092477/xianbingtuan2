//
//  FNlogisticsInfoItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/2.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNlogisticsInfoItemCell.h"

@implementation FNlogisticsInfoItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.stateImgView=[[UIImageView alloc]init];
    [self addSubview:self.stateImgView];
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.dateLB=[[UILabel alloc]init];
    [self addSubview:self.dateLB];
    
    self.titleLB.font=[UIFont systemFontOfSize:15];
    self.titleLB.textColor=RGB(154, 154, 154);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    self.titleLB.numberOfLines=2;
    
    self.dateLB.font=[UIFont systemFontOfSize:12];
    self.dateLB.textColor=RGB(154, 154, 154);
    self.dateLB.textAlignment=NSTextAlignmentLeft;
    
    self.stateImgView.sd_layout
    .topSpaceToView(self, 24).leftSpaceToView(self, 12).widthIs(13).heightIs(13);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 36).rightSpaceToView(self, 33).topSpaceToView(self, 10).heightIs(40);
    
    self.dateLB.sd_layout
    .leftSpaceToView(self, 36).rightSpaceToView(self, 33).topSpaceToView(self.titleLB, 2).heightIs(16);
    
    self.titleLB.text=@"";
    self.dateLB.text=@"";
    self.stateImgView.cornerRadius=13/2;
    self.stateImgView.clipsToBounds = YES;
    self.stateImgView.borderWidth=1.5;
    self.stateImgView.borderColor = RGB(255, 91, 34);
}  
-(void)setModel:(FNlogisticsInfoItemModel *)model{
    _model=model;
    if(model){
        self.titleLB.text=model.content;
        self.dateLB.text=model.time;
        self.stateImgView.cornerRadius=13/2;
        self.stateImgView.clipsToBounds = YES;
        self.stateImgView.borderWidth=1.5; 
        if(model.state==0){
            self.stateImgView.borderColor = RGB(255, 91, 34);
            self.titleLB.textColor=RGB(37, 38, 44);
            if([model.content containsString:@"已签收"]){
               [self.titleLB fn_changeColorWithTextColor:RGB(255, 91, 34) changeText:@"已签收"];
            }
        }else{
            self.stateImgView.borderColor = RGB(154, 154, 154);
            self.titleLB.textColor=RGB(154, 154, 154);
        }
    }
}
@end
