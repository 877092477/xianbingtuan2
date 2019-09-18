//
//  FNWaresTopChunkNaCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNWaresTopChunkNaCell.h"

@implementation FNWaresTopChunkNaCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNWaresTopChunkNaCellID";
    FNWaresTopChunkNaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath]; 
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
    self.bgImgView.cornerRadius=5;
    //self.bgImgView.backgroundColor=RGB(240, 240, 240);
    self.bgImgView.sd_layout
    .leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
}

-(void)setModel:(FNWaresMultiIcoItemModel *)model{
    _model=model;
    if(model){
        [self.bgImgView setUrlImg:model.img];
    }
}
@end
