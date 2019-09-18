//
//  FNcandiesCountCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcandiesCountCell.h"

@implementation FNcandiesCountCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    self.imgTextBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.imgTextBtn];
    
    self.bottomBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.bottomBtn];
    
    //self.imgTextBtn.titleLabel.font=kFONT17;
    self.imgTextBtn.titleLabel.font=[UIFont systemFontOfSize:17 weight:2];
    [self.imgTextBtn setTitleColor:RGB(31, 32, 36) forState:UIControlStateNormal];
    self.imgTextBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    
    self.imgTextBtn.sd_layout
    .leftSpaceToView(self, 13).heightIs(24).rightSpaceToView(self, 13).topSpaceToView(self, 32);
    
    self.imgTextBtn.titleLabel.sd_layout
    .centerYEqualToView(self.imgTextBtn).centerXEqualToView(self.imgTextBtn).heightIs(22).widthIs(210);
    
    self.imgTextBtn.imageView.sd_layout
    .centerYEqualToView(self.imgTextBtn).widthIs(18).heightIs(22).rightSpaceToView(self.imgTextBtn.titleLabel, 4);
    
    self.bottomBtn.sd_layout
    .bottomSpaceToView(self, 10).centerXEqualToView(self).heightIs(27).widthIs(107); 
    
    CGFloat left1Gap=(FNDeviceWidth-220)/2;
    CGFloat leftGap=(FNDeviceWidth-190)/2;
    
    self.lineProgress = [[ZCCCircleProgressView alloc] initWithFrame:CGRectMake(left1Gap, 130, 220, 220)];
    [self addSubview:self.lineProgress];
    
    self.circleProgress = [[ZCCCircleProgressView alloc] initWithFrame:CGRectMake(leftGap, 140, 190, 190)];
    [self addSubview:self.circleProgress];
    
    self.circleProgress.sd_layout
    .centerXEqualToView(self).widthIs(190).heightIs(190).topSpaceToView(self, 116);
    
    self.lineProgress.sd_layout
    .centerXEqualToView(self).centerYEqualToView(self.circleProgress).widthIs(220).heightIs(220);
    
    self.lineProgress.backgroundColor=[UIColor clearColor];
    self.circleProgress.backgroundColor=[UIColor clearColor];
    
    self.titleLB=[[UILabel alloc]init];
    [self.circleProgress addSubview:self.titleLB];
    
    self.produceLB=[[UILabel alloc]init];
    [self.circleProgress addSubview:self.produceLB];
    
    self.residueLB=[[UILabel alloc]init];
    [self.circleProgress addSubview:self.residueLB];
    
    self.produceBiliLB=[[UILabel alloc]init];
    [self addSubview:self.produceBiliLB];
    
    self.residueBiliLB=[[UILabel alloc]init];
    [self addSubview:self.residueBiliLB];
    
    self.titleLB.font=[UIFont systemFontOfSize:12];
    self.titleLB.textColor=RGB(31, 32, 36);
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    
    self.produceLB.font=[UIFont systemFontOfSize:18];
    self.produceLB.textColor=RGB(248, 50, 192);
    self.produceLB.textAlignment=NSTextAlignmentCenter;
    
    self.residueLB.font=[UIFont systemFontOfSize:12];
    self.residueLB.textColor=RGB(31, 32, 36);
    self.residueLB.textAlignment=NSTextAlignmentCenter;
    self.residueLB.numberOfLines=2;
    
    self.produceBiliLB.font=[UIFont systemFontOfSize:12];
    self.produceBiliLB.textColor=RGB(31, 32, 36);
    self.produceBiliLB.textAlignment=NSTextAlignmentCenter;
    self.produceBiliLB.numberOfLines=2;
    
    self.residueBiliLB.font=[UIFont systemFontOfSize:12];
    self.residueBiliLB.textColor=RGB(31, 32, 36);
    self.residueBiliLB.textAlignment=NSTextAlignmentCenter;
    self.residueBiliLB.numberOfLines=2;
    
    self.produceBiliLB.sd_layout
    .leftSpaceToView(self.circleProgress, 5).topSpaceToView(self.imgTextBtn, 20).widthIs(60).heightIs(60);
    
    self.residueBiliLB.sd_layout
    .rightSpaceToView(self.circleProgress, 5).bottomEqualToView(self.lineProgress).widthIs(60).heightIs(60);
    
    self.produceLB.sd_layout
    .centerYEqualToView(self.circleProgress).leftSpaceToView(self.circleProgress, 5).rightSpaceToView(self.circleProgress, 5).heightIs(35);
    
    self.titleLB.sd_layout
    .centerXEqualToView(self.circleProgress).bottomSpaceToView(self.produceLB, 10).widthIs(100).heightIs(22);
    
    self.residueLB.sd_layout
    .centerXEqualToView(self.circleProgress).topSpaceToView(self.produceLB, 10).widthIs(100).heightIs(30);
    
    
}
-(void)setModel:(FNCandiesMyModel *)model{
    _model=model;
    if(model){
        //NSString *all_counts=[self separateNumberUseCommaWith:model.dwqkb_all_counts];
        NSString *jointStr=[NSString stringWithFormat:@"%@ %@",model.dwqkb_all_counts_str,model.dwqkb_all_counts1];
        CGFloat imgTextW=[self getWidthWithTextHeight:22 font:[UIFont systemFontOfSize:17 weight:2] withString:jointStr];//[jointStr kr_getWidthWithTextHeight:22 font:17];
        if(imgTextW>270){
           imgTextW=270;
        }
        self.imgTextBtn.titleLabel.sd_resetLayout
        .centerYEqualToView(self.imgTextBtn).centerXEqualToView(self.imgTextBtn).heightIs(22).widthIs(imgTextW);
        
        self.imgTextBtn.imageView.sd_resetLayout
        .centerYEqualToView(self.imgTextBtn).widthIs(18).heightIs(22).rightSpaceToView(self.imgTextBtn.titleLabel, 4);
        [self.imgTextBtn setTitle:jointStr forState:UIControlStateNormal];
        [self.imgTextBtn sd_setImageWithURL:URL(model.dwqkb_icon) forState:UIControlStateNormal];
        //[self.bottomBtn sd_setImageWithURL:URL(model.dwqkb_rank_list_btn) forState:UIControlStateNormal];
        [self.bottomBtn sd_setBackgroundImageWithURL:URL(model.dwqkb_rank_list_btn) forState:UIControlStateNormal];
        [self.lineProgress addimaginaryLineWithColor:RGBA(255, 77, 106, 1.0)];
        [self.circleProgress addCircleWithColor:RGBA(122, 84, 249, 1.0) withPlan:RGBA(251, 56, 160, 1.0) withEdge:RGBA(250, 187, 219, 0.5)];
        
        if([model.dwqkb_all_counts kr_isNotEmpty]&&[model.exitst_counts kr_isNotEmpty]){
            CGFloat allFloat=[model.dwqkb_all_counts floatValue];
            CGFloat exitstFloat=[model.exitst_counts floatValue];
            CGFloat remnantFloat=[model.remnant_counts floatValue];
            CGFloat biliFloaft=exitstFloat/allFloat;
            CGFloat syFloaft=remnantFloat/allFloat;
            [self.circleProgress animateToProgress:biliFloaft];
            CGFloat produceLv=biliFloaft*100;
            NSString *unitStr=@"%";
            CGFloat syLv=syFloaft*100;
            self.residueBiliLB.text=[NSString stringWithFormat:@"剩余 %.3f%@",syLv,unitStr];//@"剩余 29%"
            self.produceBiliLB.text=[NSString stringWithFormat:@"已产生 %.3f%@",produceLv,unitStr];//@"已产生 71%";
            self.residueBiliLB.textColor=RGBA(122, 84, 249, 1.0);
            self.produceBiliLB.textColor=RGBA(251, 56, 160, 1.0);
        } 
        self.produceLB.text=model.exitst_counts;//@"75422";
        self.titleLB.text=model.dwqkb_exitst_counts_str;//@"已产生";
        self.residueLB.text=[NSString stringWithFormat:@"%@: %@",model.dwqkb_remnant_counts_str,model.remnant_counts];//@"剩余: 254887";
        
        if([model.dwqkb_rank_is_show integerValue]==0){
            self.bottomBtn.hidden=YES;
        }
        else{
            self.bottomBtn.hidden=NO;
        }
    }
}

// 将数字转为每隔3位整数由逗号“,”分隔的字符串
- (NSString *)separateNumberUseCommaWith:(NSString *)number {
    // 前缀
    NSString *prefix = @"";//￥
    // 后缀
    NSString *suffix = @"";//元
    // 分隔符
    NSString *divide = @",";
    NSString *integer = @"";
    NSString *radixPoint = @"";
    BOOL contains = NO;
    if ([number containsString:@"."]) {
        contains = YES;
        // 若传入浮点数，则需要将小数点后的数字分离出来
        NSArray *comArray = [number componentsSeparatedByString:@"."];
        integer = [comArray firstObject];
        radixPoint = [comArray lastObject];
    } else {
        integer = number;
    }
    // 将整数按各个字符为一组拆分成数组
    NSMutableArray *integerArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < integer.length; i ++) {
        NSString *subString = [integer substringWithRange:NSMakeRange(i, 1)];
        [integerArray addObject:subString];
    }
    // 将整数数组倒序每隔3个字符添加一个逗号“,”
    NSString *newNumber = @"";
    for (NSInteger i = 0 ; i < integerArray.count ; i ++) {
        NSString *getString = @"";
        NSInteger index = (integerArray.count-1) - i;
        if (integerArray.count > index) {
            getString = [integerArray objectAtIndex:index];
        }
        BOOL result = YES;
        if (index == 0 && integerArray.count%3 == 0) {
            result = NO;
        }
        if ((i+1)%3 == 0 && result) {
            newNumber = [NSString stringWithFormat:@"%@%@%@",divide,getString,newNumber];
        } else {
            newNumber = [NSString stringWithFormat:@"%@%@",getString,newNumber];
        }
    }
    if (contains) {
        newNumber = [NSString stringWithFormat:@"%@.%@",newNumber,radixPoint];
    }
    if (![prefix isEqualToString:@""]) {
        newNumber = [NSString stringWithFormat:@"%@%@",prefix,newNumber];
    }
    if (![suffix isEqualToString:@""]) {
        newNumber = [NSString stringWithFormat:@"%@%@",newNumber,suffix];
    }
    return newNumber;
}

- (CGFloat)getWidthWithTextHeight:(CGFloat)height font:(UIFont*)font withString:(NSString*)string{
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil];
    return rect.size.width;
}
@end
