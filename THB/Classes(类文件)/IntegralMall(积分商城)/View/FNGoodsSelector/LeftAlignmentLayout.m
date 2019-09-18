//
//  LeftAlignmentLayout.m
//  THB
//
//  Created by Weller Zhao on 2019/1/4.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "LeftAlignmentLayout.h"

@implementation LeftAlignmentLayout

- (void)prepareLayout {
    [super prepareLayout];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect {
    // 获取系统帮我们计算好的Attributes
    NSArray *answer = [super layoutAttributesForElementsInRect:rect];
    
    // 遍历结果
    for(int i = 1; i < [answer count]; ++i) {
        
        // 获取cell的Attribute，根据上一个cell获取最大的x，定义为origin
        UICollectionViewLayoutAttributes *currentLayoutAttributes = answer[i];
        UICollectionViewLayoutAttributes *prevLayoutAttributes = answer[i - 1];
        
        //此处根据个人需求，我的需求里面有head cell两类，我只需要调整cell，所以head直接过滤
//        if([currentLayoutAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]){
//            continue;
//        }
        
        NSLog(@"%f", currentLayoutAttributes.size.width);
        NSInteger preX = CGRectGetMaxX(prevLayoutAttributes.frame);
        NSInteger preY = CGRectGetMaxY(prevLayoutAttributes.frame);
        NSInteger curY = CGRectGetMaxY(currentLayoutAttributes.frame);
        
        // 设置cell最大间距
        NSInteger maximumSpacing = 0;
        
        // 如果当前cell和precell在同一行
        if(preY == curY){
            //满足则给当前cell的frame属性赋值
            //不满足的cell会根据系统布局换行
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = preX + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        }
    }
    return answer;
}

@end
