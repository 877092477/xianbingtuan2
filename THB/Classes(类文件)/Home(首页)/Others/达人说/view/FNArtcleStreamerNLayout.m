//
//  FNArtcleStreamerNLayout.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/16.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNArtcleStreamerNLayout.h"
#define ACTIVE_DISTANCE 200
#define ZOOM_FACTOR 0.1
#define kScreen_Height      ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Width       ([UIScreen mainScreen].bounds.size.width)
@implementation FNArtcleStreamerNLayout
-(id)init
{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(kScreen_Width-130, 160);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 20;
        self.sectionInset = UIEdgeInsetsMake(40, 20, 0, 20);
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes* attributes in array) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
            
            distance = ABS(distance);
            
            if (distance < kScreen_Width / 2 + self.itemSize.width) {
                CGFloat zoom = 1 + ZOOM_FACTOR * (1 - distance / ACTIVE_DISTANCE);
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
                attributes.transform3D = CATransform3DTranslate(attributes.transform3D, 0 , -zoom * 25, 0);
                attributes.alpha = 1;//zoom - ZOOM_FACTOR;
            }
            
        }
    }
    
    return array;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
    
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}
@end
