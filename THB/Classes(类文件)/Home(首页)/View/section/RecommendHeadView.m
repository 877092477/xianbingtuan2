//
//  RecommendHeadView.m
//  DouYU
//
//  Created by Alesary on 15/11/2.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import "RecommendHeadView.h"

@interface RecommendHeadView ()



@property (strong, nonatomic)  UIImageView *LineView;

@end

@implementation RecommendHeadView

-(id)init
{
    self=[[[NSBundle mainBundle]loadNibNamed:@"RecommendHeadView" owner:nil options:nil] firstObject];
    
    if (self) {
        //添加下方分割线
        UIImageView *lineImg=[[UIImageView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, XYScreenWidth, 1)];
        
        lineImg.image = IMAGE(@"member_line1");
        [self addSubview:lineImg];
        
        lineImg.sd_layout
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .bottomSpaceToView(self,0)
        .widthIs(XYScreenWidth)
        .heightIs(1);
        
        lineImg.layer.cornerRadius=5;
        lineImg.layer.masksToBounds=YES;
        self.Title.text=@"发现好货";
    }
    
    return self;
}

@end
