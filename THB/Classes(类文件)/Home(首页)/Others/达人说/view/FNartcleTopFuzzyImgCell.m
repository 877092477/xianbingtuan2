//
//  FNartcleTopFuzzyImgCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/16.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNartcleTopFuzzyImgCell.h"

@implementation FNartcleTopFuzzyImgCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"FNartcleTopFuzzyImgCell";
    FNartcleTopFuzzyImgCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self initializedSubviews];
    }
    return self;
}
- (void)initializedSubviews {
    self.imgView=[[UIImageView alloc]init];
    [self.contentView addSubview:self.imgView];
    self.imgView.sd_layout
    .leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0);
}
@end
