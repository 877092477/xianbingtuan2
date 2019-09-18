//
//  FNmarketScreenItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/14.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNmarketScreenItemCell.h"

@implementation FNmarketScreenItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    self.titleLB.font=[UIFont systemFontOfSize:13];
    self.titleLB.textColor=RGB(140, 140, 140);
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    
    self.imgView=[[UIImageView alloc]init];
    [self addSubview:self.imgView];
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    self.imgView.sd_layout
    .rightSpaceToView(self, 0).centerYEqualToView(self).widthIs(6).heightIs(10);
    
}

-(void)setModel:(FNMarketCentreSelectItemModel *)model{
    _model=model;
    if(model){
        self.titleLB.text=model.str;
        if(model.seletedInt==0){
           self.titleLB.textColor=RGB(140, 140, 140);
            if([model.type1 kr_isNotEmpty]){
                self.imgView.image=IMAGE(model.img);
            }else{
                self.imgView.image=IMAGE(@"");
            }
        }
        else if(model.seletedInt==1){
           self.titleLB.textColor=[UIColor colorWithHexString:model.select_color];
            if([model.type1 kr_isNotEmpty]){
                self.imgView.image=IMAGE(model.imgOne);
            }else{
                self.imgView.image=IMAGE(@"");
            }
        }
        else if(model.seletedInt==2){
            self.titleLB.textColor=[UIColor colorWithHexString:model.select_color];
            if([model.type1 kr_isNotEmpty]){
                self.imgView.image=IMAGE(model.imgTwo);
            }else{
                self.imgView.image=IMAGE(@"");
            }
        }
        CGFloat with=FNDeviceWidth/4;
        CGFloat textWidh=[self.titleLB.text kr_getWidthWithTextHeight:36 font:13];
        if(textWidh>with){
           textWidh=with-26;
        }
        self.titleLB.sd_resetLayout
        .centerYEqualToView(self).heightIs(36).centerXEqualToView(self).widthIs(textWidh);
        self.imgView.sd_resetLayout
        .leftSpaceToView(self.titleLB, 3).centerYEqualToView(self).widthIs(6).heightIs(10);
        
        //self.imgView.backgroundColor=RGB(250, 250, 250);
    }
}
@end
