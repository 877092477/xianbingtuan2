//
//  FNMaximumSpacingFlowLayout.m
//  SuperMode
//
//  Created by jimmy on 2017/6/23.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNMaximumSpacingFlowLayout.h"

@implementation FNMaximumSpacingFlowLayout
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *original = [super layoutAttributesForElementsInRect:rect];
    NSArray *answer   = [[NSArray alloc] initWithArray:original copyItems:YES];
    
    for(int i = 1; i < [answer count]; ++i) {
        
        UICollectionViewLayoutAttributes *currentLayoutAttributes = answer[i];
        UICollectionViewLayoutAttributes *prevLayoutAttributes    = answer[i - 1];
        
        NSInteger maximumSpacing = self.minimumInteritemSpacing;
        NSInteger rightMargin = self.sectionInset.right;
        NSInteger origin         = CGRectGetMaxX(prevLayoutAttributes.frame);
        NSInteger tmp = origin + maximumSpacing + currentLayoutAttributes.frame.size.width +rightMargin;
        CGFloat width = self.collectionViewContentSize.width;
        if ( tmp < width && prevLayoutAttributes.indexPath.section == currentLayoutAttributes.indexPath.section) {
            
            CGRect frame   = currentLayoutAttributes.frame;
            
            frame.origin.x = origin + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        }
    }
    
    return answer;
}
@end
