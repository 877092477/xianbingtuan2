//
//  FNtradeArticletFotterView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNtradeArticletFotterView.h"

@implementation FNtradeArticletFotterView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews{
    self.bottomView=[[UIView alloc]init];
    [self addSubview:self.bottomView];
    self.bottomView.backgroundColor=RGB(245, 245, 245);
    self.centreView=[[UIView alloc]init];
    [self addSubview:self.centreView];
    
    self.centreView.backgroundColor=RGB(245, 245, 245);
    
    self.shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.shareBtn];
    self.shareBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    self.shareBtn.titleLabel.textAlignment=NSTextAlignmentRight;
    [self.shareBtn setTitleColor:RGB(45, 45, 52) forState:UIControlStateNormal];
    
    self.likeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.likeBtn];
    self.likeBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    self.likeBtn.titleLabel.textAlignment=NSTextAlignmentRight;
    [self.likeBtn setTitleColor:RGB(45, 45, 52) forState:UIControlStateNormal];
    
    self.shareBtn.backgroundColor=RGB(212, 232, 252);
    self.likeBtn.backgroundColor=RGB(255, 218, 226);
    self.shareBtn.cornerRadius=35/2;
    self.likeBtn.cornerRadius=35/2;
    
    self.shareBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.likeBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    
    self.bottomView.sd_layout
    .leftSpaceToView(self, 0).bottomSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(9);
    
    self.centreView.sd_layout
    .centerYEqualToView(self).widthIs(1).heightIs(10).centerXEqualToView(self);
    
    self.shareBtn.sd_layout
    .leftSpaceToView(self.centreView, 39).bottomSpaceToView(self, 60).widthIs(111).heightIs(35);
    
    self.likeBtn.sd_layout
    .rightSpaceToView(self.centreView, 39).bottomSpaceToView(self, 60).widthIs(111).heightIs(35);
    
    NSString *shareStr=@"105";
    NSString *likeStr=@"82";
    [self.shareBtn setTitle:shareStr forState:UIControlStateNormal];
    [self.likeBtn setTitle:likeStr forState:UIControlStateNormal];
    [self.shareBtn setImage:IMAGE(@"FN_TrVfximg") forState:UIControlStateNormal];
    [self.likeBtn setImage:IMAGE(@"FN_TrVXHimg") forState:UIControlStateNormal];
    
    
    self.shareBtn.imageView.sd_layout
    .leftSpaceToView(self.shareBtn, 20).centerYEqualToView(self.shareBtn).widthIs(25).heightIs(25);
    
    self.shareBtn.titleLabel.sd_layout
    .leftSpaceToView(self.shareBtn.imageView, 2).rightSpaceToView(self.shareBtn, 2).heightIs(15).centerYEqualToView(self.shareBtn);
    
    self.likeBtn.imageView.sd_layout
    .leftSpaceToView(self.likeBtn, 20).centerYEqualToView(self.likeBtn).widthIs(25).heightIs(25);
    
    self.likeBtn.titleLabel.sd_layout
    .leftSpaceToView(self.likeBtn.imageView, 2).rightSpaceToView(self.likeBtn, 2).heightIs(15).centerYEqualToView(self.likeBtn);
    
}
@end
