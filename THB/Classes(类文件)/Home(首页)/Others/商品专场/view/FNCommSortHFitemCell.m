//
//  FNCommSortHFitemCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNCommSortHFitemCell.h"

@implementation FNCommSortHFitemCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNCommSortHFitemCellID";
    FNCommSortHFitemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
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
    [self addSubview:self.bgImgView];
    
    self.stateImgView=[[UIImageView alloc]init];
    [self addSubview:self.stateImgView];
    
    self.nameLB=[[UILabel alloc]init];
    [self addSubview:self.nameLB];
    
    self.nameLB.font=[UIFont systemFontOfSize:15];
    self.nameLB.textColor=RGB(51, 51, 51);
    self.nameLB.textAlignment=NSTextAlignmentCenter;
    
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self,5).bottomSpaceToView(self, 8).rightSpaceToView(self, 0);
    
    self.stateImgView.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0).heightIs(32);
    
    self.nameLB.sd_layout
    .leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 11).heightIs(23);
}

-(void)setModel:(FNCommoditySortItemModel *)model{
    _model=model;
    if(model){
        [self.bgImgView setUrlImg:model.img];
        self.nameLB.text=model.catename;
        if(model.state==0){
            self.nameLB.textColor=[UIColor colorWithHexString:model.tip_fontcolor];
            [self.stateImgView setUrlImg:model.tip_img];
        }else{
            self.nameLB.textColor=[UIColor colorWithHexString:model.check_tip_fontcolor];
            [self.stateImgView setUrlImg:model.check_tip_img];
        }
    }
}
@end
