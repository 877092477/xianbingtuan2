//
//  FNmerPhotoHomeItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/1.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNmerSetPhotoItemModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNmerPhotoHomeItemCellDelegate <NSObject>
// 点击删除
- (void)didMerdeletePhotoAlbumIndex:(NSIndexPath*)index;
@end
@interface FNmerPhotoHomeItemCell : UICollectionViewCell
@property (nonatomic, strong)UILabel     *titleLB;
@property (nonatomic, strong)UIImageView *imgView;
@property (nonatomic, strong)UIButton    *deleteView;
@property (nonatomic, strong)FNmerSetPhotoItemModel *model; 
@property (nonatomic, strong)NSIndexPath  *index;
@property (nonatomic, weak)id<FNmerPhotoHomeItemCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
