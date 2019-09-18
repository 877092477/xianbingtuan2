//
//  FNteIndentTextNeHeader.m
//  69橙子
//
//  Created by Jimmy on 2018/12/6.
//  Copyright © 2018 方诺科技. All rights reserved.
//
//订单信息 45
#import "FNteIndentTextNeHeader.h"

@implementation FNteIndentTextNeHeader

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
    
    UIView *whiteView=[[UIView alloc]init];
    whiteView.backgroundColor=[UIColor whiteColor];
    [bgView addSubview:whiteView];
    whiteView.sd_layout
    .topEqualToView(bgView).leftSpaceToView(bgView, 10).rightSpaceToView(bgView, 10).bottomSpaceToView(bgView, 0);
    
    self.lineLb= [[UILabel alloc]init];
    self.lineLb.backgroundColor=RGB(237, 237, 237);
    [self addSubview:self.lineLb];
    
    self.titleName = [[UILabel alloc]init];
    self.titleName.backgroundColor=[UIColor whiteColor];
    self.titleName.font=[UIFont boldSystemFontOfSize:15];
    [self addSubview:self.titleName];
    
    
    [self compositionFrame];
    self.backgroundColor=RGB(237, 237, 237);
}
-(void)compositionFrame{
    CGFloat space_20=20;
    self.titleName.sd_layout
    .leftSpaceToView(self, space_20).rightSpaceToView(self, space_20).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    self.lineLb.sd_layout
    .bottomEqualToView(self).leftSpaceToView(self, space_20).rightSpaceToView(self, space_20).heightIs(1);
    
}
-(void)setModel:(FNtendOrderDetailsDeModel *)model{
    _model=model;
    if(model){
        
    }
    
}
@end
