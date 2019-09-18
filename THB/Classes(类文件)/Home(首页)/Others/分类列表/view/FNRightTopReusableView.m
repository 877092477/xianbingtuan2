//
//  FNRightTopReusableView.m
//  THB
//
//  Created by Jimmy on 2018/9/5.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNRightTopReusableView.h"
#import "FNLeftclassifyModel.h"

@implementation FNRightTopReusableView

-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

-(void)initUI{
    //商品图片
    self.TypeLB=[UILabel new];
    self.TypeLB.font=FNFontDefault(12);
    [self addSubview:self.TypeLB];
    
    self.advertisingView=[UIImageView new];
    self.advertisingView.cornerRadius=5;
    [self addSubview:self.advertisingView];
    
    self.TypeLB.sd_layout
    .leftSpaceToView(self, 10).topSpaceToView(self, 10).rightSpaceToView(self, 10).heightIs(20);
    
    self.advertisingView.sd_layout
    .leftSpaceToView(self, 10).rightSpaceToView(self, 10).topSpaceToView(self, 40).bottomSpaceToView(self, 10);
}
-(void)setModel:(FNLeftclassifyModel *)model{
    _model = model;
    if (model) {
        //[self.advertisingView setUrlImg:model.banner_img];
        self.TypeLB.text=model.name;
        
        UIImage *placeholder = DEFAULT;
        [self.advertisingView sd_setImageWithURL:[NSURL URLWithString:model.banner_img] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            NSData *imageData=UIImageJPEGRepresentation(image, 1.0);
            NSInteger lent=imageData.length/1024;
            CGFloat height=0;
            if (error) {
                self.advertisingView.hidden=YES;
                height=0;
            } 
            else if(lent>0){
                self.advertisingView.hidden=NO;
                height=100;
            }
            else if(lent<0 ||lent==0 ){
                self.advertisingView.hidden=YES;
                height=0;
            }
            self.advertisingView.sd_layout
            .leftSpaceToView(self, 10).rightSpaceToView(self, 10).topSpaceToView(self, 40).heightIs(height);
        }];
        [self setNeedsLayout];
    }
}
@end
