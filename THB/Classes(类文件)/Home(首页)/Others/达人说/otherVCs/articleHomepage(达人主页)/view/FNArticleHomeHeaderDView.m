//
//  FNArticleHomeHeaderDView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/18.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNArticleHomeHeaderDView.h"

@implementation FNArticleHomeHeaderDView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializedSubviews];
    }
    return self;
}

- (void)initializedSubviews{
    self.backgroundColor=RGB(250, 250, 250);
    self.topbgImgView=[[UIImageView alloc]init];
    self.topDimImgView=[[UIImageView alloc]init];
    self.headImg=[[UIImageView alloc]init];
    self.nameLB=[[UILabel alloc]init];
    self.checkLB=[[UILabel alloc]init];
    self.articleCountLB=[[UILabel alloc]init];
    
    [self addSubview:self.topbgImgView];
    [self addSubview:self.topDimImgView];
    [self addSubview:self.headImg];
    [self addSubview:self.nameLB];
    [self addSubview:self.checkLB];
    [self addSubview:self.articleCountLB];
    
    self.headImg.cornerRadius=72/2;
    self.checkLB.font=[UIFont systemFontOfSize:12];
    self.checkLB.textColor=RGB(251, 155, 31);
    self.checkLB.textAlignment=NSTextAlignmentCenter;
    self.nameLB.font=[UIFont systemFontOfSize:18];
    self.nameLB.textColor=[UIColor whiteColor];
    self.nameLB.textAlignment=NSTextAlignmentCenter;
    self.articleCountLB.font=[UIFont systemFontOfSize:18];
    self.articleCountLB.textColor=RGB(153, 153, 153);
    self.articleCountLB.textAlignment=NSTextAlignmentLeft;
    
    [self incomposition];
}

-(void)incomposition{
    self.topbgImgView.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(192);
    
    self.topDimImgView.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(192);
   
    self.headImg.sd_layout
    .centerXEqualToView(self).topSpaceToView(self, 47).heightIs(72).widthIs(72);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self, 12).rightSpaceToView(self, 12).topSpaceToView(self.headImg, 10).heightIs(23);
    
    self.checkLB.sd_layout
    .leftSpaceToView(self, 12).rightSpaceToView(self, 12).topSpaceToView(self.nameLB, 4).heightIs(15);
    
    self.articleCountLB.sd_layout
    .leftSpaceToView(self, 16).rightSpaceToView(self, 16).topSpaceToView(self.topbgImgView, 0).heightIs(40);
    self.topbgImgView.contentMode=UIViewContentModeScaleAspectFill;
    
    self.topbgImgView.clipsToBounds=YES;
}
-(void)setDataModel:(FNArticleHomepageDModel *)dataModel{
    _dataModel=dataModel;
    if(dataModel){
        
        self.articleCountLB.text=dataModel.str;
    }
}

-(void)setTwoModel:(FNEssayItemDModel *)twoModel{
    _twoModel=twoModel;
    if(twoModel){
        [self.topbgImgView setUrlImg:twoModel.head_img];
        self.topDimImgView.image=IMAGE(@"FN_drHP_mhimg");
        [self.headImg setUrlImg:twoModel.head_img];
        self.nameLB.text=twoModel.talent_name;
        self.checkLB.text=[NSString stringWithFormat:@"点赞量：%@",twoModel.readtimes];
    }
}
@end
