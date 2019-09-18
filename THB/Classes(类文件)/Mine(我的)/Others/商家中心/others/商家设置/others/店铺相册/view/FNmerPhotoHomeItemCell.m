//
//  FNmerPhotoHomeItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/1.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerPhotoHomeItemCell.h"

@implementation FNmerPhotoHomeItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.imgView=[[UIImageView alloc]init];
    [self addSubview:self.imgView];
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.deleteView = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self addSubview:self.deleteView];
    
    self.titleLB.font=[UIFont systemFontOfSize:13];
    self.titleLB.textColor=[UIColor whiteColor];
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    
    self.imgView.sd_layout
    .topSpaceToView(self, 7).bottomSpaceToView(self, 7).leftSpaceToView(self, 7).rightSpaceToView(self, 7);
    
    self.titleLB.sd_layout
    .bottomSpaceToView(self, 7).leftSpaceToView(self, 7).rightSpaceToView(self, 7).heightIs(25);
    
    self.deleteView.sd_layout
    .rightSpaceToView(self, 0).topSpaceToView(self, 0).widthIs(23).heightIs(23);
    
    //self.imgView.backgroundColor=RGB(250, 250, 250);
    
    
    [self.deleteView addTarget:self action:@selector(rightDeleteBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    //self.titleLB.text=@"门店内景(3)";
    
    self.imgView.contentMode=UIViewContentModeScaleAspectFill;
    self.imgView.clipsToBounds = YES;
}

-(void)rightDeleteBtnAction{
    if ([self.delegate respondsToSelector:@selector(didMerdeletePhotoAlbumIndex:)]) {
        [self.delegate didMerdeletePhotoAlbumIndex:self.index];
    }
}
-(void)setModel:(FNmerSetPhotoItemModel *)model{
    _model=model;
    if(model){
        [self.imgView setUrlImg:model.img];
        if(model.state==1){
            [self.deleteView setImage:IMAGE(@"FN_merXC_scIcon") forState:UIControlStateNormal];
            self.deleteView.hidden=NO;
        }else{
            self.deleteView.hidden=YES;
        }
        if(model.type==0){
           self.titleLB.text=model.name;
           self.titleLB.backgroundColor=RGBA(0, 0, 0, 0.4);
        }
    }
}
@end
