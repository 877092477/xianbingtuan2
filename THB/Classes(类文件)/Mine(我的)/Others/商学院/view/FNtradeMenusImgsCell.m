//
//  FNtradeMenusImgsCell.m
//  THB
//
//  Created by Jimmy on 2019/6/24.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNtradeMenusImgsCell.h"

@implementation FNtradeMenusImgsCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews{
    self.allImgView=[[UIImageView alloc]init];
    [self addSubview:self.allImgView];
    //self.allImgView.backgroundColor=[UIColor orangeColor];
    //self.allImgView.cornerRadius=5;
    //self.allImgView.sd_layout
    //.leftSpaceToView(self, 6).rightSpaceToView(self, 6).topSpaceToView(self, 6).bottomSpaceToView(self, 6);
}

-(void)setTypeInt:(NSInteger)typeInt{
    _typeInt=typeInt;
    if(typeInt==1){
        self.allImgView.sd_layout
        .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
    }
    if(typeInt==2){
        self.allImgView.sd_layout
        .leftSpaceToView(self, 6).rightSpaceToView(self, 6).topSpaceToView(self, 6).bottomSpaceToView(self, 6);
        self.allImgView.cornerRadius=5;
        self.allImgView.clipsToBounds = YES;
    }
}
@end
