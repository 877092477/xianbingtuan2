//
//  FNHuntTallyNeCell.h
//  THB
//
//  Created by Jimmy on 2019/1/9.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNHuntTallyNeCell : UICollectionViewCell
/** 标题 **/
@property (nonatomic, strong)UILabel* titleLB;
+ (CGSize) getSizeWithText:(NSString*)text;
@end

NS_ASSUME_NONNULL_END
