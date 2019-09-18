//
//  FNRecommendFineItemXCell.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/17.
//  Copyright © 2019 方诺科技. All rights reserved.
//
//web
#import "FNRecommendFineItemXCell.h"

@implementation FNRecommendFineItemXCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = @"FNRecommendFineItemXCellID";
    FNRecommendFineItemXCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
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
    self.backgroundColor=RGB(250, 250, 250);
    
}
-(void)setUrl:(NSString *)url{
    _url=url;
    if([url kr_isNotEmpty]){
        
       
    }
}
 
@end
