//
//  FNcandiesRanTopItemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNcandiesRanTopItemCell.h"

@implementation FNcandiesRanTopItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    self.bgImgView=[[UIImageView alloc]init];
    [self addSubview:self.bgImgView];
    
    self.baseView=[[UIView alloc]init];
    [self addSubview:self.baseView];
    self.baseView.backgroundColor=[UIColor whiteColor];
    self.bg1View=[[UIView alloc]init];
    [self addSubview:self.bg1View];
    self.bg2View=[[UIView alloc]init];
    [self addSubview:self.bg2View];
    self.bg3View=[[UIView alloc]init];
    [self addSubview:self.bg3View];
    
    self.headImg1View=[[UIImageView alloc]init];
    [self.bg1View addSubview:self.headImg1View];
    self.headCrownView=[[UIImageView alloc]init];
    [self.bg1View addSubview:self.headCrownView];
    self.name1LB=[[UILabel alloc]init];
    [self.bg1View addSubview:self.name1LB];
    self.designation1Btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.bg1View addSubview:self.designation1Btn];
    self.gain1LB=[[UILabel alloc]init];
    [self.bg1View addSubview:self.gain1LB];
    self.gainValue1LB=[[UILabel alloc]init];
    [self.bg1View addSubview:self.gainValue1LB];
    self.name1LB.font=[UIFont systemFontOfSize:12];
    self.name1LB.textColor=RGB(37, 37, 43);
    self.name1LB.textAlignment=NSTextAlignmentCenter;
    self.designation1Btn.titleLabel.font=[UIFont systemFontOfSize:9];
    [self.designation1Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.gain1LB.font=[UIFont systemFontOfSize:9];
    self.gain1LB.textColor=RGB(37, 37, 43);
    self.gain1LB.textAlignment=NSTextAlignmentCenter;
    self.gainValue1LB.font=[UIFont systemFontOfSize:18];
    self.gainValue1LB.textColor=RGB(254, 178, 31);
    self.gainValue1LB.textAlignment=NSTextAlignmentCenter;
    self.headImg1View.cornerRadius=59/2;
    self.headImg1View.borderWidth=1;
    self.headImg1View.borderColor=RGB(252, 211, 53);
    self.headImg1View.clipsToBounds = YES;
    self.designation1Btn.cornerRadius=2;
    
    
    self.headImg2View=[[UIImageView alloc]init];
    [self.bg2View addSubview:self.headImg2View];
    self.name2LB=[[UILabel alloc]init];
    [self.bg2View addSubview:self.name2LB];
    self.designation2Btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.bg2View addSubview:self.designation2Btn];
    self.gain2LB=[[UILabel alloc]init];
    [self.bg2View addSubview:self.gain2LB];
    self.gainValue2LB=[[UILabel alloc]init];
    [self.bg2View addSubview:self.gainValue2LB];
    self.name2LB.font=[UIFont systemFontOfSize:12];
    self.name2LB.textColor=RGB(37, 37, 43);
    self.name2LB.textAlignment=NSTextAlignmentCenter;
    self.designation2Btn.titleLabel.font=[UIFont systemFontOfSize:9];
    [self.designation2Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.gain2LB.font=[UIFont systemFontOfSize:9];
    self.gain2LB.textColor=RGB(37, 37, 43);
    self.gain2LB.textAlignment=NSTextAlignmentCenter;
    self.gainValue2LB.font=[UIFont systemFontOfSize:18];
    self.gainValue2LB.textColor=RGB(254, 178, 31);
    self.gainValue2LB.textAlignment=NSTextAlignmentCenter;
    self.headImg2View.cornerRadius=53/2;
    self.headImg2View.borderWidth=1;
    self.headImg2View.borderColor=RGB(252, 211, 53);
    self.headImg2View.clipsToBounds = YES;
    self.designation2Btn.cornerRadius=2;
    
    
    self.headImg3View=[[UIImageView alloc]init];
    [self.bg3View addSubview:self.headImg3View];
    self.name3LB=[[UILabel alloc]init];
    [self.bg3View addSubview:self.name3LB];
    self.designation3Btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.bg3View addSubview:self.designation3Btn];
    self.gain3LB=[[UILabel alloc]init];
    [self.bg3View addSubview:self.gain3LB];
    self.gainValue3LB=[[UILabel alloc]init];
    [self.bg3View addSubview:self.gainValue3LB];
    self.name3LB.font=[UIFont systemFontOfSize:12];
    self.name3LB.textColor=RGB(37, 37, 43);
    self.name3LB.textAlignment=NSTextAlignmentCenter;
    self.designation3Btn.titleLabel.font=[UIFont systemFontOfSize:9];
    [self.designation3Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.gain3LB.font=[UIFont systemFontOfSize:9];
    self.gain3LB.textColor=RGB(37, 37, 43);
    self.gain3LB.textAlignment=NSTextAlignmentCenter;
    self.gainValue3LB.font=[UIFont systemFontOfSize:18];
    self.gainValue3LB.textColor=RGB(254, 178, 31);
    self.gainValue3LB.textAlignment=NSTextAlignmentCenter;
    self.headImg3View.cornerRadius=53/2;
    self.headImg3View.borderWidth=1;
    self.headImg3View.borderColor=RGB(252, 211, 53);
    self.headImg3View.clipsToBounds = YES;
    self.designation3Btn.cornerRadius=2;
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 17).rightSpaceToView(self, 17).bottomSpaceToView(self, 13).heightIs(199);
    
    self.baseView.sd_layout
    .bottomSpaceToView(self, 0).leftSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(20);
    self.baseView.frame=CGRectMake(0, 261, FNDeviceWidth, 20);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.baseView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.baseView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.baseView.layer.mask = maskLayer;
    
    CGFloat meanW=(FNDeviceWidth-34)/3;
    self.bg1View.sd_layout
    .centerXEqualToView(self).bottomSpaceToView(self, 0).widthIs(meanW).heightIs(181);
    self.bg2View.sd_layout
    .rightSpaceToView(self.bg1View, 0).bottomSpaceToView(self, 0).widthIs(meanW).heightIs(148);
    self.bg3View.sd_layout
    .leftSpaceToView(self.bg1View, 0).bottomSpaceToView(self, 0).widthIs(meanW).heightIs(148);
    
    
    
    
    self.headImg1View.sd_layout
    .topSpaceToView(self.bg1View, 17).centerXEqualToView(self.bg1View).heightIs(59).widthIs(59); 
    [self.headCrownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.headImg1View.mas_right).offset(-20);
        make.bottom.equalTo(self.headImg1View.mas_bottom).offset(-33);
        make.height.equalTo(@38);
        make.width.equalTo(@45);
    }];
    self.designation1Btn.sd_layout
    .centerXEqualToView(self.bg1View).heightIs(12).widthIs(30).topSpaceToView(self.bg1View, 70);
    self.name1LB.sd_layout
    .leftSpaceToView(self.bg1View, 2).rightSpaceToView(self.bg1View, 2).heightIs(17).topSpaceToView(self.headImg1View, 21);
    self.gain1LB.sd_layout
    .leftSpaceToView(self.bg1View, 2).rightSpaceToView(self.bg1View, 2).heightIs(14).topSpaceToView(self.name1LB, 14);
    self.gainValue1LB.sd_layout
    .leftSpaceToView(self.bg1View, 2).rightSpaceToView(self.bg1View, 2).heightIs(16).topSpaceToView(self.gain1LB, 1);
    
    
    self.headImg2View.sd_layout
    .topSpaceToView(self.bg2View, 5).centerXEqualToView(self.bg2View).heightIs(53).widthIs(53);
    self.designation2Btn.sd_layout
    .centerXEqualToView(self.bg2View).heightIs(12).widthIs(30).topSpaceToView(self.bg2View, 50);
    self.name2LB.sd_layout
    .leftSpaceToView(self.bg2View, 2).rightSpaceToView(self.bg2View, 2).heightIs(17).topSpaceToView(self.headImg2View, 13);
    self.gain2LB.sd_layout
    .leftSpaceToView(self.bg2View, 2).rightSpaceToView(self.bg2View, 2).heightIs(14).topSpaceToView(self.name2LB, 10);
    self.gainValue2LB.sd_layout
    .leftSpaceToView(self.bg2View, 2).rightSpaceToView(self.bg2View, 2).heightIs(16).topSpaceToView(self.gain2LB, 1);
    
    
    self.headImg3View.sd_layout
    .topSpaceToView(self.bg3View, 5).centerXEqualToView(self.bg3View).heightIs(53).widthIs(53);
    self.designation3Btn.sd_layout
    .centerXEqualToView(self.bg3View).heightIs(12).widthIs(30).topSpaceToView(self.bg3View, 50);
    self.name3LB.sd_layout
    .leftSpaceToView(self.bg3View, 2).rightSpaceToView(self.bg3View, 2).heightIs(17).topSpaceToView(self.headImg3View, 13);
    self.gain3LB.sd_layout
    .leftSpaceToView(self.bg3View, 2).rightSpaceToView(self.bg3View, 2).heightIs(14).topSpaceToView(self.name3LB, 10);
    self.gainValue3LB.sd_layout
    .leftSpaceToView(self.bg3View, 2).rightSpaceToView(self.bg3View, 2).heightIs(16).topSpaceToView(self.gain3LB, 1);
    
}
-(void)setModel:(FNcandiesRankingModel *)model{
    _model=model;
    if(model){
        [self.bgImgView setUrlImg:model.dwqkb_rank_top_three_bj];
        NSArray *threeArr=model.top_three;
        if(threeArr.count>0){
            FNcandiesRankItemModel *model1=[FNcandiesRankItemModel mj_objectWithKeyValues:threeArr[0]];
            self.name1LB.text=model1.nickname;
            [self.designation1Btn setTitle:model1.vip_name forState:UIControlStateNormal];
            self.gain1LB.text=model1.str;
            self.gainValue1LB.text=model1.qkb_count;
            [self.headImg1View setUrlImg:model1.head_img];
            [self.designation1Btn  sd_setBackgroundImageWithURL:URL(model1.vip_img) forState:UIControlStateNormal];
            self.gainValue1LB.textColor=[UIColor colorWithHexString:model1.count_color];
            CGFloat designationW=[model1.vip_name kr_getWidthWithTextHeight:12 font:9];
            if(designationW>70){
                designationW=70;
            }
            self.designation1Btn.sd_layout
            .centerXEqualToView(self.bg1View).heightIs(12).widthIs(designationW+20).topSpaceToView(self.bg1View, 70);
            self.headCrownView.image=IMAGE(@"FN_tg_hgImg");
            self.designation1Btn.titleLabel.sd_resetLayout
            .rightSpaceToView(self.designation1Btn, 4).leftSpaceToView(self.designation1Btn, 16).centerYEqualToView(self.designation1Btn).heightIs(12);
        } 
        if(threeArr.count>1){
            FNcandiesRankItemModel *model2=[FNcandiesRankItemModel mj_objectWithKeyValues:threeArr[1]];
            self.name2LB.text=model2.nickname;
            [self.designation2Btn setTitle:model2.vip_name forState:UIControlStateNormal];
            self.gain2LB.text=model2.str;
            self.gainValue2LB.text=model2.qkb_count;
            [self.headImg2View setUrlImg:model2.head_img];
            [self.designation2Btn  sd_setBackgroundImageWithURL:URL(model2.vip_img) forState:UIControlStateNormal];
            self.gainValue2LB.textColor=[UIColor colorWithHexString:model2.count_color];
            CGFloat designation2W=[model2.vip_name kr_getWidthWithTextHeight:12 font:9];
            if(designation2W>70){
                designation2W=70;
            }
            self.designation2Btn.sd_resetLayout
            .centerXEqualToView(self.bg2View).heightIs(12).widthIs(designation2W+20).topSpaceToView(self.bg2View, 50);
            self.designation2Btn.titleLabel.sd_resetLayout
            .rightSpaceToView(self.designation2Btn, 4).leftSpaceToView(self.designation2Btn, 16).centerYEqualToView(self.designation2Btn).heightIs(12);
        }
        if(threeArr.count>2){
            FNcandiesRankItemModel *model3=[FNcandiesRankItemModel mj_objectWithKeyValues:threeArr[2]];
            self.name3LB.text=model3.nickname;
            [self.designation3Btn setTitle:model3.vip_name forState:UIControlStateNormal];
            self.gain3LB.text=model3.str;
            self.gainValue3LB.text=model3.qkb_count;
            [self.headImg3View setUrlImg:model3.head_img];
            [self.designation3Btn  sd_setBackgroundImageWithURL:URL(model3.vip_img) forState:UIControlStateNormal];
            self.gainValue3LB.textColor=[UIColor colorWithHexString:model3.count_color];
            CGFloat designation3W=[model3.vip_name kr_getWidthWithTextHeight:12 font:9];
            if(designation3W>70){
                designation3W=70;
            }
            self.designation3Btn.sd_resetLayout
            .centerXEqualToView(self.bg3View).heightIs(12).widthIs(designation3W+20).topSpaceToView(self.bg3View, 50);
            self.designation3Btn.titleLabel.sd_resetLayout
            .rightSpaceToView(self.designation3Btn, 4).leftSpaceToView(self.designation3Btn, 16).centerYEqualToView(self.designation3Btn).heightIs(12);
        }
    }
}
@end
