//
//  FNCustomAnnotationsView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/21.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNCustomAnnotationsView.h"

@implementation FNCustomAnnotationsView

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier

{
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    
    if (self)
        
    {
        
        self.bounds = CGRectMake(0.f, 0.f, 25, 70);
        
        self.backgroundColor = [UIColor clearColor];
        
        self.tzImgView=[[UIImageView alloc]init];
        [self addSubview:self.tzImgView];
        self.tzImgView.frame=CGRectMake(0, 0, 25, 30);
        
    }
    
    return self;
    
}
@end
