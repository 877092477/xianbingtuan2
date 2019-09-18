//
//  FNNPDImgCell.m
//  嗨如意
//
//  Created by Jimmy on 2017/12/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNNPDImgCell.h"


@implementation FNNPDImgCell
- (UIImageView *)imgview{
    if (_imgview == nil) {
        _imgview = [UIImageView new];
        @weakify(self);
        [_imgview addJXTouchWithObject:^(id obj) {
            @strongify(self);
            if (self.imageClicked) {
                self.imageClicked(obj, self.indexPath);
            }
        }];
    }
    return _imgview;
}
- (void)jm_setupViews{
    [self.contentView addSubview:self.imgview];
    [self.imgview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
//    self.imgconh = [self.imgview autoSetDimension:(ALDimensionHeight) toSize:0];
//    [self setupAutoHeightWithBottomView:self.imgview bottomMargin:0];
}
//class method: get cell instance
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FNNPDImgCell";
    FNNPDImgCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    return cell;
}
- (void)setImage:(NSString *)image{
    _image = image;
    if (_image) {
        [self.imgview sd_setImageWithURL:[NSURL URLWithString:_image] placeholderImage:IMAGE(@"APP底图") completed:^(UIImage *ima, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (ima) {
                self.imgconh.constant = ima.size.height/ ima.size.width*JMScreenWidth;
            }
        }];
    }
}

- (void)configImage: (UIImage*)image {
    self.imgview.image = image;
    self.imgconh.constant = image.size.height/ image.size.width*JMScreenWidth;
}


@end
