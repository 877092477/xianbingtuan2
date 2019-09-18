//
//  FNArticleNewTopSlideItemCCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/23.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNArticleNewTopSlideItemCCell.h"

@implementation FNArticleNewTopSlideItemCCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNArticleNewTopSlideItemCCellID";
    FNArticleNewTopSlideItemCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializedSubviews];
        
    }
    return self;
}

- (void)initializedSubviews{
    self.bgImgView=[[UIImageView alloc]init];
    self.showImg=[[UIImageView alloc]init];
    self.titleLB=[[UILabel alloc]init];
    self.contentLB=[[UILabel alloc]init];
    
    [self addSubview:self.bgImgView];
    [self addSubview:self.showImg];
    [self addSubview:self.titleLB];
    [self addSubview:self.contentLB];
    
    self.showImg.cornerRadius=5;
    
    self.titleLB.font=kFONT17;
    self.titleLB.textColor=RGB(51, 51, 51);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.contentLB.font=kFONT10;
    self.contentLB.textColor=RGB(153, 153, 153);
    self.contentLB.textAlignment=NSTextAlignmentLeft;
    self.bgImgView.cornerRadius=10;
    //self.bgImgView.backgroundColor=[UIColor whiteColor];
    
    [self incomposition];
}
-(void)incomposition{ 
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    self.showImg.sd_layout
    .leftSpaceToView(self, 18).bottomSpaceToView(self, 15).rightSpaceToView(self, 18).heightIs(80);
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 18).rightSpaceToView(self, 18).topSpaceToView(self, 17).heightIs(20);
    
    self.contentLB.sd_layout
    .leftSpaceToView(self, 18).topSpaceToView(self.titleLB, 10).rightSpaceToView(self, 18).heightIs(14);
    
}

-(void)setModel:(FNEssayItemDModel *)model{
    _model=model;
    if(model){
        [self.bgImgView setNoPlaceholderUrlImg:model.bg_img];
        [self.showImg setUrlImg:model.banner];
        self.titleLB.text=model.title;
        self.contentLB.text=model.list_str;
    }
}
@end
