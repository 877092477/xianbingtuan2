//
//  FNLOLCardLayout.m
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/5/9.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNLOLCardLayout.h"

@implementation FNLOLCardLayout

#define GiveMeHeight(HEIGTH) (HEIGTH*[UIScreen mainScreen].bounds.size.height/736.0)
#define GiveMeWidth(WIDTH) (WIDTH*[UIScreen mainScreen].bounds.size.width/414.0)

//第一个要重写的方法 设置基本的大小
- (void)prepareLayout
{
//    //cell大小
//    self.itemSize = CGSizeMake(GiveMeWidth(300),GiveMeHeight(500));
//    //滑动方向
//    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    //组间四个方位间距
//    self.sectionInset = UIEdgeInsetsMake(200, 50.0, 200, 50.0);
//    //列间距
//    self.minimumLineSpacing = 0.0;
}
//允许更新位置
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}
//最大旋转角度
#define rotate 90.0*M_PI/180.0
#define ACTIVE_DISTANCE XYScreenWidth
//返回一个rect位置下所有cell的位置数组
- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    //得到所有的UICollectionViewLayoutAttributes
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes* attributes in array) {
        
        //cell中心离collectionview中心的位移
        //CGRectGetMidX表示得到一个frame中心点的X坐标
        CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
        
        //CGRectIntersectsRect 判断两个矩形是否相交
        //这里判断当前这个cell在不在rect矩形里
        if (CGRectIntersectsRect(attributes.frame, rect))
        {
            CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
            
            //ABS 绝对值
            //如果位移小于一个过程所需的位移
            if (ABS(distance) < ACTIVE_DISTANCE)
            {
                //normalizedDistance 当前位移比上完成一个过程所需位移 得到不完全过程的旋转角度
                CGFloat zoom = rotate*normalizedDistance;
                CATransform3D transfrom = CATransform3DIdentity;
                transfrom.m34 = 1.0 / 500;
                transfrom = CATransform3DRotate(transfrom, zoom, 0.0f, 1.0f, 0.0f);

                double scale = cos(zoom);
                scale = scale < 0.8 ? 0.8 : scale;
                transfrom = CATransform3DScale(transfrom, cos(zoom), cos(zoom), 1.0f);
                transfrom = CATransform3DTranslate(transfrom, distance / 2, 0, 0);
                
                attributes.transform3D = transfrom;
                attributes.zIndex = 1;
                
                
            }
            else
            {
                CATransform3D transfrom = CATransform3DIdentity;
                transfrom.m34 = 1.0 / 500;
                //向右滑
                if (distance>0)
                {
                    transfrom = CATransform3DRotate(transfrom, rotate, 0.0f, 1.0f, 0.0f);
                    
                }
                //向左滑
                else
                {
                    transfrom = CATransform3DRotate(transfrom, -rotate, 0.0f, 1.0f, 0.0f);
                }
//                transfrom = CATransform3DMakeTranslation(0, 0, 300 * sin(rotate));
                transfrom = CATransform3DScale(transfrom, 0.5f, 0.5f, 1.0f);
                
                attributes.transform3D = transfrom;
                attributes.zIndex = 1;
                
            }
            
        }
    }
    return array;
}

//类似于scrollview的scrollViewWillEndDragging
//proposedContentOffset是没有对齐到网格时本来应该停下的位置
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat offsetAdjustment = MAXFLOAT;
    
    //CGRectGetWidth: 返回矩形的宽度
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    
    //当前rect
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
    //对当前屏幕中的UICollectionViewLayoutAttributes逐个与屏幕中心进行比较，找出最接近中心的一个
    for (UICollectionViewLayoutAttributes* layoutAttributes in array)
    {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment))
        {
            //与中心的位移差
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    //返回修改后停下的位置
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}


@end
