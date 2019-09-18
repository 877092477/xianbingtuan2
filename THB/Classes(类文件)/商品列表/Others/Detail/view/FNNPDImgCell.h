//
//  FNNPDImgCell.h
//  嗨如意
//
//  Created by Jimmy on 2017/12/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMCollectionViewCell.h"

@interface FNNPDImgCell : JMCollectionViewCell
@property (nonatomic,strong)NSIndexPath* indexPath;
@property (nonatomic,strong)UIImageView* imgview;
@property (nonatomic,strong)NSLayoutConstraint* imgconh;
@property (nonatomic, copy)NSString* image;
@property (nonatomic, copy)void (^imageClicked)(UIImageView* imgview,NSIndexPath* sender);
//class method: get cell instance
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

- (void)configImage: (UIImage*)image;
@end
