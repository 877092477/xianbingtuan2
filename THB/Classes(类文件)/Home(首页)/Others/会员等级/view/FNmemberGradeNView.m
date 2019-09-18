//
//  FNmemberGradeNView.m
//  THB
//
//  Created by 李显 on 2018/9/8.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNmemberGradeNView.h"
#import "FNGradeItemNView.h"

@implementation FNmemberGradeNView

 
- (instancetype)initWithFrame:(CGRect)frame {
    
    self=[super initWithFrame:frame];
    if (self) {
       [self initialize];
        
    }
    return self;
}

-(void)initialize{
    self.todayGradeLB=[UIButton new];
    [self addSubview:self.todayGradeLB];
    self.todayGradeLB.frame=CGRectMake(10, 5, 60, 25); 
    self.todayGradeLB.titleLabel.font=[UIFont fontWithDevice:9];
    [self.todayGradeLB setBackgroundImage:IMAGE(@"level_here") forState:UIControlStateNormal];
    [self.todayGradeLB setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.todayGradeLB.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.todayGradeLB.titleLabel.sd_layout
    .leftSpaceToView(self.todayGradeLB, 2).rightSpaceToView(self.todayGradeLB, 2).topEqualToView(self.todayGradeLB).heightIs(15);
    
}
-(void)setModel:(NSString *)model{
    NSLog(@"model::%@",model);
    
    [self.todayGradeLB setTitle:@"当前等级" forState:UIControlStateNormal];
    NSInteger Gradenumber=[model integerValue]+1;
    CGFloat Gradewidth=(FNDeviceWidth-80)/Gradenumber;
    self.todayGradeLB.frame=CGRectMake(Gradewidth*(Gradenumber-1)-40, 5, 60, 20);
    for (NSInteger i = 0 ; i<Gradenumber; i++) {
        NSInteger loc = i % Gradenumber ;
        NSInteger x = Gradewidth * loc ;
        FNGradeItemNView *ligryItemView=[FNGradeItemNView new];
        ligryItemView.frame=CGRectMake(x,25, Gradewidth, 30);
        ligryItemView.lineView.image=[UIImage imageNamed:@"sop_off"];
        
        if(i==0){
           ligryItemView.gradeImage.image=[UIImage imageNamed:@"level1_off"];
        }
        if(i==1){
            ligryItemView.gradeImage.image=[UIImage imageNamed:@"level2_off"];
        }
        if(i==2){
            ligryItemView.gradeImage.image=[UIImage imageNamed:@"level3_off"];
        }
        if(i==3){
            ligryItemView.gradeImage.image=[UIImage imageNamed:@"level4_off"];
        }
        if(i==4){
            ligryItemView.gradeImage.image=[UIImage imageNamed:@"level5_off"];
        }
        if(i==5){
            ligryItemView.gradeImage.image=[UIImage imageNamed:@"level6_off"];
        }
        ligryItemView.lineView.frame=CGRectMake(0,12.5, Gradewidth, 5);
        ligryItemView.gradeImage.frame=CGRectMake(Gradewidth-19,5, 20, 20);
        [self addSubview:ligryItemView];
    }
    for (NSInteger i = 0 ; i<Gradenumber-1; i++) {
        NSInteger loc = i % Gradenumber ;
        NSInteger x = Gradewidth * loc ;
        FNGradeItemNView *ligryItemView=[FNGradeItemNView new];
        ligryItemView.frame=CGRectMake(x,25, Gradewidth, 30);
        ligryItemView.lineView.image=[UIImage imageNamed:@"levelbar_on"];
        
        if(i==0){
            ligryItemView.gradeImage.image=[UIImage imageNamed:@"level1_on"];
        }
        if(i==1){
            ligryItemView.gradeImage.image=[UIImage imageNamed:@"level2_on"];
        }
        if(i==2){
            ligryItemView.gradeImage.image=[UIImage imageNamed:@"level3_on"];
        }
        if(i==3){
            ligryItemView.gradeImage.image=[UIImage imageNamed:@"level4_on"];
        }
        if(i==4){
            ligryItemView.gradeImage.image=[UIImage imageNamed:@"level5_on"];
        }
        if(i==5){
            ligryItemView.gradeImage.image=[UIImage imageNamed:@"level6_on"];
        }
        ligryItemView.lineView.frame=CGRectMake(0,12.5, Gradewidth, 5);
        ligryItemView.gradeImage.frame=CGRectMake(Gradewidth-19,5, 20, 20);
        [self addSubview:ligryItemView];
    }
}

@end




 
