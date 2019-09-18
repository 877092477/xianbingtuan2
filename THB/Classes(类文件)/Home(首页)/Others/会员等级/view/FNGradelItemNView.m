//
//  FNGradelItemNView.m
//  THB
//
//  Created by 李显 on 2018/9/9.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNGradelItemNView.h"

#import "GradeMemberNModel.h"

@implementation FNGradelItemNView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self=[super initWithFrame:frame];
    if (self) {
        [self initUI];
        
    }
    return self;
}
-(void)initUI{
    CGFloat withZ=JMScreenWidth-130;
    CGFloat withLine=withZ/3;
    self.lineGrayView=[UIImageView new];
    self.lineGrayView.cornerRadius=5/2;
    self.lineGrayView.backgroundColor=FNColor(242, 242, 242);
    [self addSubview:self.lineGrayView];
    
    self.lineGrayView.frame=CGRectMake(0, 5, withZ, 5);
  
    //标题
    self.StrategytitleLB=[UILabel new];
    self.StrategytitleLB.frame=CGRectMake(0, 15, withLine*2, 15);
    self.StrategytitleLB.textAlignment=NSTextAlignmentLeft;
    [self addOneLabelWithLabView:self.StrategytitleLB TextColor:[UIColor grayColor] fontSize:10];
    
    //结果
    self.StrategypriceLB=[UILabel new];
    self.StrategypriceLB.frame=CGRectMake(withLine*2, 15, withLine, 15);
    self.StrategypriceLB.textAlignment=NSTextAlignmentRight;
    [self addOneLabelWithLabView:self.StrategypriceLB TextColor:[UIColor grayColor] fontSize:10 ];
    
}
//AddLB
-(void)addOneLabelWithLabView:(UILabel *)label TextColor:(UIColor *)textColor fontSize:(float)fontSize{
    label.textColor = textColor;
    label.font=[UIFont fontWithDevice:fontSize];
    [self addSubview:label];
}
- (void)setModel:(StrategyItemModel *)model{
    NSLog(@"str:%@",model.str);
    self.StrategytitleLB.text=model.str;
    NSString *jointString=[NSString stringWithFormat:@"%@ /%@%@",model.val,model.sum,model.unit];
    //self.StrategypriceLB.text=jointString;
    NSMutableAttributedString *valbutedString = [[NSMutableAttributedString alloc] initWithString: jointString];
    [valbutedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, model.val.length)];
    self.StrategypriceLB.attributedText=valbutedString;
    
}
@end
