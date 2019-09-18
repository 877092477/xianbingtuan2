//
//  FNRushConsumeTextHeaderView.m
//  69橙子
//
//  Created by Jimmy on 2018/11/28.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//文本header
#import "FNRushConsumeTextHeaderView.h"

@implementation FNRushConsumeTextHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        //self.backgroundColor=FNWhiteColor;
        //self.backgroundColor=RGB(237, 237, 237);
        [self setCompositionView];
    }
    return self;
}

-(void)setCompositionView{
    UIView *bgView=[[UIView alloc]init];
    bgView.backgroundColor=RGB(237, 237, 237);
    [self addSubview:bgView];
    bgView.sd_layout
    .topEqualToView(self).leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    self.topLineLb= [[UILabel alloc]init];
    self.topLineLb.backgroundColor=RGB(237, 237, 237);
    [self addSubview:self.topLineLb];
    
    self.titleName = [[UILabel alloc]init];
    self.titleName.backgroundColor=[UIColor whiteColor];
    self.titleName.font=kFONT15;
    [self addSubview:self.titleName];
    
    self.lineLb = [[UILabel alloc]init];
    self.lineLb.backgroundColor=RGB(237, 237, 237);
    [self addSubview:self.lineLb];
    
    [self compositionFrame];
    self.backgroundColor=RGB(237, 237, 237);
}
-(void)compositionFrame{
    
    CGFloat space_10=10;
    CGFloat space_20=20;
    self.topLineLb.sd_layout
    .topEqualToView(self).leftSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(10);
    
    self.titleName.sd_layout
    .leftSpaceToView(self, space_10).rightSpaceToView(self, space_10).topSpaceToView(self.topLineLb, 0).bottomSpaceToView(self, 0);
    
    self.lineLb.sd_layout
    .bottomEqualToView(self).leftSpaceToView(self, space_20).rightSpaceToView(self, space_20).heightIs(1);
    
}

@end
