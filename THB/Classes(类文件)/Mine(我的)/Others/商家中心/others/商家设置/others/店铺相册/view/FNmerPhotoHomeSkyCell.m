//
//  FNmerPhotoHomeSkyCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/1.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmerPhotoHomeSkyCell.h"

@implementation FNmerPhotoHomeSkyCell
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
    
    self.baseLB=[[UILabel alloc]init];
    [self addSubview:self.baseLB];
    
    self.addBtnView = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self addSubview:self.addBtnView];
    
    self.addBtnView.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.addBtnView.titleLabel.font=[UIFont systemFontOfSize:12];
    //[self.addBtnView setTitleColor:RGB(204, 204, 204) forState:UIControlStateNormal];
    
    self.titleLB.font=[UIFont systemFontOfSize:12];
    self.titleLB.textColor=RGB(204, 204, 204);
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    
    self.baseLB.font=[UIFont systemFontOfSize:12];
    self.baseLB.textColor=RGB(204, 204, 204);
    self.baseLB.textAlignment=NSTextAlignmentCenter;
    
    self.imgView.sd_layout
    .topSpaceToView(self, 108).centerXEqualToView(self).widthIs(150).heightIs(150);
    
    self.titleLB.sd_layout
    .topSpaceToView(self.imgView, 27).leftSpaceToView(self, 7).rightSpaceToView(self, 7).heightIs(16);
    
    self.baseLB.sd_layout
    .topSpaceToView(self.titleLB, 10).leftSpaceToView(self, 80).rightSpaceToView(self, 80).heightIs(16);
    
    self.addBtnView.sd_layout
    .topSpaceToView(self.titleLB, 10).leftSpaceToView(self, 80).rightSpaceToView(self, 80).heightIs(16);
    
    self.imgView.backgroundColor=RGB(250, 250, 250);
    
    //[self.deleteView addTarget:self action:@selector(rightDeleteBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.imgView.image=IMAGE(@"FN_XCskyimg");  
    self.titleLB.text=@"店铺相册空空如也";
    self.baseLB.text=@"点击这马上上传";
    [self.baseLB fn_changeColorWithTextColor:RGB(255, 120, 37) changeText:@"点击这"];
    
}
@end
