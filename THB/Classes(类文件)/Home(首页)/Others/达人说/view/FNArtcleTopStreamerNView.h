//
//  FNArtcleTopStreamerNView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/16.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNArtcleStreamerNLayout.h"
#import "FNArtcleStreamerTwoLayout.h"
#import "FNArtcleStreamerItemCell.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FNArtcleTopStreamerNViewDelegate <NSObject>
// 点击横幅文章
- (void)didStreamerItemAction:(NSInteger)sender;
// 点击头像或者名字
- (void)didTopStreamerNHeadItemAction:(id)dictry;
@end

@interface FNArtcleTopStreamerNView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,FNArtcleStreamerItemCellDelegate>
{
    CGFloat _dragEndX;
    CGFloat _dragStartX;
}
@property(nonatomic,strong)UICollectionView* collectionview;
@property(nonatomic,strong)NSArray* dataArr;
@property(nonatomic,strong)NSString* title;
@property(nonatomic,strong)UILabel   *titleLB;
@property(nonatomic,strong)UIImageView   *bgImgView;
@property(nonatomic, weak) id<FNArtcleTopStreamerNViewDelegate> delegate;
 
/**
 当前选中位置
 */
@property (nonatomic, assign, readwrite) NSInteger selectedIndex;
@end

NS_ASSUME_NONNULL_END
