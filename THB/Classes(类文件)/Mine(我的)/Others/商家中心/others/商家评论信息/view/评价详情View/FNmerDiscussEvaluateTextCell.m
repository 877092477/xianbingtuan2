//
//  FNmerDiscussEvaluateTextCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/31.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerDiscussEvaluateTextCell.h"

@implementation FNmerDiscussEvaluateTextCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    self.pleasedLB=[[UILabel alloc]init];
    [self addSubview:self.pleasedLB];
    
    self.consumeLB=[[UILabel alloc]init];
    [self addSubview:self.consumeLB];
    
    self.pleasedLB.font=[UIFont systemFontOfSize:13];
    self.pleasedLB.textColor=RGB(102, 102, 102);
    self.pleasedLB.textAlignment=NSTextAlignmentLeft;
    
    self.consumeLB.font=[UIFont systemFontOfSize:13];
    self.consumeLB.textColor=RGB(102, 102, 102);
    self.consumeLB.textAlignment=NSTextAlignmentLeft;
    
    self.gradeView=[[FNmerGradeView alloc]init];
    self.gradeView.frame=CGRectMake(107, 10, 70, 15);
    [self addSubview:self.gradeView];
    
    
    self.reviewLB=[[UILabel alloc]init]; 
    [self addSubview:self.reviewLB];
    
//    self.recommendLB=[[UILabel alloc]init];
//    [self addSubview:self.recommendLB];
    
    self.reviewLB.font=[UIFont systemFontOfSize:14];
    self.reviewLB.textColor=RGB(60, 60, 60);
    self.reviewLB.textAlignment=NSTextAlignmentLeft;
    self.reviewLB.numberOfLines=0;
    
//    self.recommendLB.font=[UIFont systemFontOfSize:13];
//    self.recommendLB.textColor=RGB(102, 102, 102);
//    self.recommendLB.textAlignment=NSTextAlignmentLeft;
    
    self.pleasedLB.sd_layout
    .leftSpaceToView(self, 67).topSpaceToView(self, 5).widthIs(42).heightIs(17);
    
    self.gradeView.sd_layout
    .leftSpaceToView(self.pleasedLB, 5).heightIs(15).centerYEqualToView(self.pleasedLB).widthIs(70);
    
    self.consumeLB.sd_layout
    .leftSpaceToView(self.gradeView, 13).centerYEqualToView(self.pleasedLB).heightIs(17).rightSpaceToView(self, 28);
    
    self.reviewLB.sd_layout
    .leftSpaceToView(self, 67).rightSpaceToView(self, 28).topSpaceToView(self, 27).heightIs(70);
    
//    self.recommendLB.sd_layout
//    .leftSpaceToView(self, 67).rightSpaceToView(self, 50).bottomSpaceToView(self, 10).heightIs(16);
    
}
-(void)setModel:(FNmerchentReviewModel *)model{
    _model=model;
    if(model){
        self.pleasedLB.text=@"评分：";
        self.reviewLB.text=model.content;
        self.consumeLB.text=model.average_price;
        CGFloat textheight=0;
        CGFloat textWidth=FNDeviceWidth-95;
        if([model.content kr_isNotEmpty]){
            textheight=[model.content kr_heightWithMaxWidth:textWidth attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        }
        self.reviewLB.sd_resetLayout
        .leftSpaceToView(self, 67).rightSpaceToView(self, 28).topSpaceToView(self, 30).heightIs(textheight);
        
        //self.recommendLB.text=@"推荐菜：面包";
        NSInteger starInt=[model.star integerValue];
        CGFloat gradeWidth=starInt*17;
        if([self.model.star kr_isNotEmpty]){
            NSMutableArray *arrM=[NSMutableArray arrayWithCapacity:0];
            NSInteger countInt=[model.star integerValue];
            for (NSInteger i=0; i<countInt; i++) {
                [arrM addObject:model.good_star];
            }
            self.gradeView.imgArr=arrM;
            self.gradeView.itemGap=2;
            self.gradeView.sd_resetLayout
            .leftSpaceToView(self.pleasedLB, 5).heightIs(15).centerYEqualToView(self.pleasedLB).widthIs(gradeWidth);
            self.consumeLB.sd_resetLayout
            .leftSpaceToView(self.gradeView, 13).centerYEqualToView(self.pleasedLB).heightIs(17).rightSpaceToView(self, 28);
        }
    }
}
@end
