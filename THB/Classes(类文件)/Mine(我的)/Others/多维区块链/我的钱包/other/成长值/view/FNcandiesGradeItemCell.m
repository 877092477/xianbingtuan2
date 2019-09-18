//
//  FNcandiesGradeItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcandiesGradeItemCell.h"

@implementation FNcandiesGradeItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.planView=[[UIView alloc]init];
    [self addSubview:self.planView];
    
    self.dotLeftImgView=[[UIImageView alloc]init];
    [self addSubview:self.dotLeftImgView];
    
    self.dotRightImgView=[[UIImageView alloc]init];
    [self addSubview:self.dotRightImgView];
    
//    self.gradeLeftImgView=[[UIImageView alloc]init];
//    [self addSubview:self.gradeLeftImgView];
//
//    self.gradeRightImgView=[[UIImageView alloc]init];
//    [self addSubview:self.gradeRightImgView];
    
    self.gradeLeftLB=[[UILabel alloc]init];
    [self addSubview:self.gradeLeftLB];
    self.gradeRightLB=[[UILabel alloc]init];
    [self addSubview:self.gradeRightLB];
    
    self.gradeLeftLB.font=[UIFont systemFontOfSize:9];
    self.gradeLeftLB.textColor=RGB(240, 211, 55);
    self.gradeLeftLB.textAlignment=NSTextAlignmentLeft;
    
    self.gradeRightLB.font=[UIFont systemFontOfSize:9];
    self.gradeRightLB.textColor=RGB(240, 211, 55);
    self.gradeRightLB.textAlignment=NSTextAlignmentRight;
    
    self.planView.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(4).centerYEqualToView(self);
    
    self.dotLeftImgView.sd_layout
    .leftSpaceToView(self, 0).centerYEqualToView(self).widthIs(7).heightIs(7);
    
    self.dotRightImgView.sd_layout
    .rightSpaceToView(self, 0).centerYEqualToView(self).widthIs(7).heightIs(7);
    
//    self.gradeLeftImgView.sd_layout
//    .leftSpaceToView(self, 0).bottomSpaceToView(self, 0).widthIs(12).heightIs(10);
//
//    self.gradeRightImgView.sd_layout
//    .rightSpaceToView(self, 0).bottomSpaceToView(self, 0).widthIs(12).heightIs(10);
    
    self.gradeLeftLB.sd_layout
    .leftSpaceToView(self, 0).bottomSpaceToView(self, 0).widthIs(22).heightIs(20);
    
    self.gradeRightLB.sd_layout
    .rightSpaceToView(self, 0).bottomSpaceToView(self, 0).widthIs(22).heightIs(20);
    
    //self.gradeLeftImgView.backgroundColor=[UIColor lightGrayColor];
    //self.gradeRightImgView.backgroundColor=[UIColor lightGrayColor];
}

-(void)setModel:(FNcandiesGrowGardeItemModel *)model{
    _model=model;
    if(model){
        self.gradeLeftLB.text=model.gradeValue;
        
        self.gradeLeftLB.textColor=[UIColor colorWithHexString:model.colourText];
        self.gradeRightLB.textColor=[UIColor colorWithHexString:model.colourText];
        [self.gradeLeftLB fn_changeFontWithTextFont:[UIFont systemFontOfSize:15] changeText:@"V"];
        if(model.gardeInt==0){
           self.gradeLeftLB.hidden=YES;
           self.planView.backgroundColor=RGB(27, 27, 27);
            if(model.presentInt==1){
               self.gradeLeftLB.hidden=NO;
            }
        }else{
           
            self.gradeLeftLB.hidden=NO;
            
            if(model.bufferState==1){
                [self.planView az_setGradientBackgroundWithColors:@[[UIColor colorWithHexString:model.colour1str],[UIColor colorWithHexString:model.colour2str]] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
               
            }else{
               self.planView.backgroundColor=[UIColor colorWithHexString:model.colour1str];
            }

        }
        if(model.valLGarde==0){
            self.dotLeftImgView.borderColor=RGB(27, 27, 27);
            self.dotLeftImgView.borderWidth=4;
            //小于最高等级
            self.dotLeftImgView.backgroundColor=RGB(27, 27, 27);
            self.dotLeftImgView.sd_resetLayout
            .leftSpaceToView(self, 0).centerYEqualToView(self).widthIs(12).heightIs(12);
            self.dotLeftImgView.cornerRadius=12/2;
        }else{
            if(model.presentInt==1){
                if(model.valRDGarde==0){
//                    self.dotLeftImgView.backgroundColor=[UIColor colorWithHexString:model.colour1str];
//                    self.dotLeftImgView.sd_resetLayout
//                    .leftSpaceToView(self, 0).centerYEqualToView(self).widthIs(7).heightIs(7);
//                    self.dotLeftImgView.cornerRadius=7/2;
                }else{
                    
                    self.dotLeftImgView.backgroundColor=[UIColor colorWithHexString:model.colour2str];
                    self.dotLeftImgView.borderColor=RGBA(130, 88, 42,1);
                    self.dotLeftImgView.borderWidth=4;
                    self.dotLeftImgView.sd_resetLayout
                    .leftSpaceToView(self, 0).centerYEqualToView(self).widthIs(12).heightIs(12);
                    self.dotLeftImgView.cornerRadius=12/2;
                    
                }
            }else{ 
                self.dotLeftImgView.backgroundColor=[UIColor colorWithHexString:model.colour1str];
                //self.dotLeftImgView.borderColor=RGBA(130, 88, 42,0.5);
                //self.dotLeftImgView.borderWidth=3;
                self.dotLeftImgView.sd_resetLayout
                .leftSpaceToView(self, 0).centerYEqualToView(self).widthIs(7).heightIs(7);
                self.dotLeftImgView.cornerRadius=7/2;
                
            }
        }
        if(model.valRGarde==0){
            //等于最高等级
            self.dotRightImgView.hidden=YES;
            
            self.gradeRightLB.hidden=YES;
        }else{
            self.dotRightImgView.hidden=NO;
            
            if(model.valRDGarde==0){
                self.dotRightImgView.borderColor=RGB(27, 27, 27);
                self.dotRightImgView.borderWidth=4;
                self.gradeRightLB.hidden=YES;
                self.dotRightImgView.cornerRadius=12/2;
                self.dotRightImgView.sd_resetLayout
                .rightSpaceToView(self, 0).centerYEqualToView(self).widthIs(12).heightIs(12);
                self.dotRightImgView.backgroundColor=RGB(27, 27, 27);
            }else{
                
                self.gradeRightLB.hidden=NO;
                self.dotRightImgView.cornerRadius=7/2;
                //self.dotRightImgView.borderColor=RGB(130, 88, 42);
                //self.dotRightImgView.borderWidth=3;
                self.dotRightImgView.backgroundColor=RGB(240, 211, 55);
                self.dotRightImgView.sd_resetLayout
                .rightSpaceToView(self, 0).centerYEqualToView(self).widthIs(12).heightIs(12);
            }
        }
        
        if(model.maxVal==model.presentVal){
            self.gradeRightLB.hidden=NO;
            self.gradeRightLB.text=model.gradeRiValue;
            [self.gradeRightLB fn_changeFontWithTextFont:[UIFont systemFontOfSize:15] changeText:@"V"];
            self.gradeRightLB.hidden=NO;
            self.dotRightImgView.cornerRadius=12/2;
            self.dotRightImgView.borderColor=RGB(130, 88, 42);
            self.dotRightImgView.borderWidth=3;
            self.dotRightImgView.backgroundColor=[UIColor colorWithHexString:model.colour2str];
            self.dotRightImgView.sd_resetLayout
            .rightSpaceToView(self, 0).centerYEqualToView(self).widthIs(12).heightIs(12);
        }else{
            self.gradeRightLB.borderColor=RGB(27, 27, 27);
            self.gradeRightLB.borderWidth=4;
            self.gradeRightLB.hidden=YES;
            self.dotRightImgView.cornerRadius=12/2;
            self.dotRightImgView.sd_resetLayout
            .rightSpaceToView(self, 0).centerYEqualToView(self).widthIs(12).heightIs(12);
            self.dotRightImgView.backgroundColor=RGB(27, 27, 27);
        }
    }
}
@end
