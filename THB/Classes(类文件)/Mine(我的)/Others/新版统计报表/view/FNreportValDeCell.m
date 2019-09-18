//
//  FNreportValDeCell.m
//  THB
//
//  Created by Jimmy on 2018/12/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//报表单个值  135
#import "FNreportValDeCell.h"

@implementation FNreportValDeCell
-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    self.backgroundColor=[UIColor whiteColor];//RGB(246, 245, 245); 
    
    self.titleLB=[UILabel new];
    self.titleLB.font=kFONT12;
    self.titleLB.textColor=RGB(200,200,200);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    //[self addSubview:self.titleLB];
    
    self.sumLB=[UILabel new];
    self.sumLB.font=[UIFont systemFontOfSize:16];
    self.sumLB.textAlignment=NSTextAlignmentLeft;
    self.sumLB.textColor=[UIColor blackColor];
    //[self addSubview:self.sumLB];
    
    self.estimateLB=[UILabel new];
    self.estimateLB.font=kFONT12;
    self.estimateLB.textColor=RGB(200,200,200);
    self.estimateLB.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.estimateLB];
    
    self.estimateSumLB=[UILabel new];
    self.estimateSumLB.font=[UIFont systemFontOfSize:16];
    self.estimateSumLB.textAlignment=NSTextAlignmentLeft;
    self.estimateSumLB.textColor=[UIColor blackColor];
    [self addSubview:self.estimateSumLB];
    
    self.colorView=[[UIView alloc]init];
    self.colorView.cornerRadius=4;
    self.colorView.backgroundColor=RGB(18, 184, 254);
    self.colorView.hidden=YES;
    [self addSubview:self.colorView];
    
    [self incompositionFrames];
}
-(void)incompositionFrames{
    
    CGFloat inter_15=15;
    CGFloat inter_10=10;
    
//    self.titleLB.sd_layout
//    .heightIs(15).topSpaceToView(self, inter_15).leftSpaceToView(self, inter_50);
//    [self.titleLB setSingleLineAutoResizeWithMaxWidth:150];
//
//    self.sumLB.sd_layout
//    .heightIs(20).leftSpaceToView(self, inter_50).topSpaceToView(self.titleLB, inter_10);
//    [self.sumLB setSingleLineAutoResizeWithMaxWidth:150];
    
    self.colorView.sd_layout
    .heightIs(8).widthIs(8).leftSpaceToView(self, inter_10).topSpaceToView(self, 17.5);
    
    self.estimateLB.sd_layout
    .centerYEqualToView(self.colorView).heightIs(15).leftSpaceToView(self.colorView, inter_15).widthIs(120);
    
    self.estimateSumLB.sd_layout
    .heightIs(20).leftEqualToView(self.estimateLB).topSpaceToView(self.estimateLB, inter_10).widthIs(120);
    
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath=indexPath;
    if(indexPath){
        CGFloat value = indexPath.row % (2);
        //XYLog(@"=:%f",value);
        
        CGFloat inter_15=15;
        CGFloat inter_10=10;
        CGFloat estimateLBW=[self getWidthWithText:self.estimateLB.text height:15 font:12];
        
        if(value==1){
            
            self.estimateLB.sd_layout
            .topSpaceToView(self, inter_10).heightIs(15).leftSpaceToView(self, 38).widthIs(estimateLBW);
            
            self.estimateSumLB.sd_layout
            .heightIs(20).leftEqualToView(self.estimateLB).topSpaceToView(self.estimateLB, inter_10).widthIs(estimateLBW);
            
            self.colorView.sd_layout
            .heightIs(8).widthIs(8).leftSpaceToView(self, inter_15).centerYEqualToView(self.estimateLB);//.topSpaceToView(self, 15.5);
            
        }else{
            
            self.estimateLB.sd_layout
            .topSpaceToView(self, inter_10).heightIs(15).rightSpaceToView(self, inter_15).widthIs(estimateLBW);
            
            self.estimateSumLB.sd_layout
            .heightIs(20).rightSpaceToView(self, inter_15).topSpaceToView(self.estimateLB, inter_10).widthIs(estimateLBW);
            
            self.colorView.sd_layout
            .heightIs(8).widthIs(8).rightSpaceToView(self.estimateLB, inter_15).centerYEqualToView(self.estimateLB);//.topSpaceToView(self, 15.5);
            
        }
        
        [self setNeedsLayout];
        
    }
}
-(void)setModel:(FNstatisticsReportItemModel *)model{
    _model=model;
    if(model){
        self.estimateLB.text=model.str;//@"全部付款预估收入(元)";
        self.estimateSumLB.text=model.val;//@"290.00";
        self.estimateLB.textColor=[UIColor colorWithHexString:model.str_color];
        self.estimateSumLB.textColor=[UIColor colorWithHexString:model.val_color];
        self.colorView.backgroundColor=[UIColor colorWithHexString:model.color];
        NSInteger is_check=[model.is_check integerValue];
        if(is_check==1){
           self.colorView.hidden=NO;
        }else{
           self.colorView.hidden=YES;
        }
        CGFloat value = model.place % (2);
        //XYLog(@"=:%f",value);
        CGFloat inter_15=15;
        CGFloat inter_10=10;
        CGFloat estimateLBW=[self getWidthWithText:self.estimateLB.text height:15 font:12];
        if(estimateLBW<120){
           estimateLBW=120;
        }
        if(value==1){
            self.estimateLB.sd_layout
            .topSpaceToView(self, inter_15).heightIs(15).leftSpaceToView(self, 38).widthIs(estimateLBW);
            self.estimateSumLB.sd_layout
            .heightIs(20).leftEqualToView(self.estimateLB).topSpaceToView(self.estimateLB, inter_10).widthIs(estimateLBW);
            self.colorView.sd_layout
            .heightIs(8).widthIs(8).leftSpaceToView(self, inter_15).centerYEqualToView(self.estimateLB);
        }else{
            self.estimateLB.sd_layout
            .topSpaceToView(self, inter_15).heightIs(15).rightSpaceToView(self, inter_15).widthIs(estimateLBW);
            self.estimateSumLB.sd_layout
            .heightIs(20).rightSpaceToView(self, inter_15).topSpaceToView(self.estimateLB, inter_10).widthIs(estimateLBW);
            self.colorView.sd_layout
            .heightIs(8).widthIs(8).rightSpaceToView(self.estimateLB, inter_15).centerYEqualToView(self.estimateLB);
            [self.estimateLB updateLayout];
            [self.estimateSumLB updateLayout];
            [self.estimateSumLB updateLayout];
        }
        [self setNeedsLayout];
    }
}
//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}
@end
