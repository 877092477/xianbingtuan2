//
//  FNcandiesTextHintCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/15.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcandiesTextHintCell.h"

@implementation FNcandiesTextHintCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    self.bgImgView=[[UIImageView alloc]init];
    [self addSubview:self.bgImgView]; 
    
    self.dotView=[[UIView alloc]init];
    [self addSubview:self.dotView];
    
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    
    self.hintLB=[[UILabel alloc]init];
    [self addSubview:self.hintLB];
    
    self.hint2LB=[[UILabel alloc]init];
    [self addSubview:self.hint2LB];
    
    self.value2LB=[[UILabel alloc]init];
    [self addSubview:self.value2LB];
    
    self.hint2LB.hidden=YES;
    self.value2LB.hidden=YES;
    self.hint2LB.font=[UIFont systemFontOfSize:12];
    self.value2LB.font=[UIFont systemFontOfSize:17];
    
    self.dotView.cornerRadius=7/2;
    
    self.titleLB.font=[UIFont systemFontOfSize:12];
    self.titleLB.textColor=RGB(51, 51, 51);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.hintLB.font=[UIFont systemFontOfSize:10];
    self.hintLB.textColor=RGB(197, 196, 202);
    self.hintLB.textAlignment=NSTextAlignmentLeft;
    
    self.rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.rightBtn];
    
    self.imgTextBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.imgTextBtn];
    
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //self.rightBtn.backgroundColor=RGB(122, 94, 249);
    self.rightBtn.titleLabel.font=kFONT14;
    self.rightBtn.cornerRadius=25/2;
    self.imgTextBtn.titleLabel.font=kFONT14;
    [self.imgTextBtn setTitleColor:RGB(30, 31, 36) forState:UIControlStateNormal];
    self.imgTextBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    self.dotView.sd_layout
    .centerYEqualToView(self).leftSpaceToView(self, 17).widthIs(7).heightIs(7);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 38).topSpaceToView(self, 9).heightIs(22).rightSpaceToView(self, 135);
    
    self.hint2LB.sd_layout
    .leftSpaceToView(self.titleLB, 2).centerYEqualToView(self.titleLB).widthIs(50).heightIs(20);
    
    self.hintLB.sd_layout
    .leftSpaceToView(self, 38).topSpaceToView(self.dotView, 2).heightIs(16).rightSpaceToView(self, 135);
    
    self.value2LB.sd_layout
    .leftSpaceToView(self.titleLB, 2).centerYEqualToView(self.hintLB).widthIs(50).heightIs(20);
    
    self.imgTextBtn.sd_layout
    .leftSpaceToView(self.titleLB, 5).heightIs(24).widthIs(60).centerYEqualToView(self.titleLB);
    
    self.imgTextBtn.imageView.sd_layout
    .centerYEqualToView(self.imgTextBtn).widthIs(18).heightIs(22).leftSpaceToView(self.imgTextBtn, 0);
    
    self.imgTextBtn.titleLabel.sd_layout
    .centerYEqualToView(self.imgTextBtn).leftSpaceToView(self.imgTextBtn, 24).heightIs(20).rightSpaceToView(self.imgTextBtn, 0);
    
    self.rightBtn.sd_layout
    .rightSpaceToView(self, 24).heightIs(25).widthIs(95).centerYEqualToView(self);
    self.rightBtn.imageView.sd_layout
    .leftSpaceToView(self.rightBtn, 0).topSpaceToView(self.rightBtn, 0).rightSpaceToView(self.rightBtn, 0).bottomSpaceToView(self.rightBtn, 0);
    [self.rightBtn addTarget:self action:@selector(rightBtnClick)];
    //self.titleLB.text=@"待解冻结糖果";
    
    //self.hintLB.text=@"(交易成功后糖果解冻)";
    
    //[self.imgTextBtn setTitle:@"10 个" forState:UIControlStateNormal];
    //[self.rightBtn setTitle:@"兑换糖果" forState:UIControlStateNormal];
    //self.bgImgView.contentMode=UIViewContentModeScaleAspectFill;
}
-(void)rightBtnClick{
    if ([self.delegate respondsToSelector:@selector(inCandiesRtightAction:)]) {
        [self.delegate inCandiesRtightAction:self.index]; 
    }
}
-(void)setModel:(FNCandiesMyoperationItemModel *)model{
    _model=model;
    if(model){
        self.dotView.backgroundColor=RGB(216, 65, 68);
        self.hintLB.font=[UIFont systemFontOfSize:10];
        self.hintLB.textColor=RGB(197, 196, 202);
        self.titleLB.sd_resetLayout
        .leftSpaceToView(self, 38).topSpaceToView(self, 9).heightIs(22).rightSpaceToView(self, 135);
        self.hintLB.sd_resetLayout
        .leftSpaceToView(self, 38).topSpaceToView(self.dotView, 2).heightIs(16).rightSpaceToView(self, 135);
        self.titleLB.text=model.str;
        self.hintLB.text=model.tips;
        if([model.counts kr_isNotEmpty]){
           [self.titleLB fn_changeFontWithTextFont:[UIFont systemFontOfSize:15] changeText:model.counts];
        }
        if([model.btn kr_isNotEmpty]){
           [self.rightBtn sd_setImageWithURL:URL(model.btn) forState:UIControlStateNormal];
            self.rightBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
            self.rightBtn.hidden=NO;
        }else{
            self.rightBtn.hidden=YES;
        }
        self.hint2LB.hidden=YES;
        self.value2LB.hidden=YES;
    }
}

-(void)setBgImg:(NSString *)bgImg{
    _bgImg=bgImg;
    if(bgImg){
        [self.bgImgView setUrlImg:bgImg];
    }
}

-(void)setDaModel:(FNCandiesMyModel *)daModel{
    _daModel=daModel;
    if(daModel){
        self.dotView.backgroundColor=RGB(216, 65, 68);
        self.hintLB.font=[UIFont systemFontOfSize:17];
        self.titleLB.sd_resetLayout
        .leftSpaceToView(self, 38).topSpaceToView(self, 16).heightIs(16).widthIs(90);
        self.hint2LB.sd_resetLayout
        .leftSpaceToView(self.titleLB, 2).centerYEqualToView(self.titleLB).widthIs(50).heightIs(20);
        self.hintLB.sd_resetLayout
        .leftSpaceToView(self, 38).topSpaceToView(self.dotView, 2).heightIs(20).widthIs(90);
        self.value2LB.sd_resetLayout
        .leftSpaceToView(self.titleLB, 2).centerYEqualToView(self.hintLB).widthIs(50).heightIs(20);
        
        self.titleLB.text=daModel.dwqkb_my_growth_str;
        self.hintLB.text=daModel.growth;
        self.hint2LB.text=daModel.dwqkb_my_sxf_str;
        self.value2LB.text=daModel.sxf;
        self.hintLB.textColor=[UIColor colorWithHexString:daModel.dwqkb_index_page_color];
        self.titleLB.textColor=[UIColor colorWithHexString:daModel.dwqkb_index_page_color];
        self.hint2LB.textColor=[UIColor colorWithHexString:daModel.dwqkb_index_page_color];
        self.value2LB.textColor=[UIColor colorWithHexString:daModel.dwqkb_index_page_color];
        [self.rightBtn sd_setImageWithURL:URL(daModel.dwqkb_my_growth_btn) forState:UIControlStateNormal];
        self.rightBtn.imageView.contentMode=UIViewContentModeScaleAspectFit;
        self.hint2LB.hidden=NO;
        self.value2LB.hidden=NO;
        self.rightBtn.hidden=NO;
        //[self setNeedsLayout];
    }
}
-(void)setTgImg:(NSString *)tgImg{
    _tgImg=tgImg;
    if(tgImg){
//        if([self.model.str kr_isNotEmpty]&&[self.model.str containsString:@"待解冻"]){
//            @weakify(self);
//            [SDWebImageManager.sharedManager downloadImageWithURL:URL(tgImg) options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                    if (finished) {
//                        @strongify(self);
//                        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self.model.str];
//                        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
//                        textAttachment.bounds = CGRectMake(0, -6, 18, 22);
//                        textAttachment.image = image;
//                        NSAttributedString *textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
//                        NSInteger index=self.model.str.length;
//                        if([self.model.counts kr_isNotEmpty]){
//                            index=self.model.str.length-self.model.counts.length-1;
//                        }
//                        [string insertAttributedString:textAttachmentString atIndex:index];
//                        self.titleLB.attributedText = string;
//                    }
//            }];
//        }
    }
}
@end
