//
//  FNNewWelfareFlowDeCell.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/3/21.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FNNewWelfareFlowDeCellDelegate <NSObject>

- (void)didItemSelectedAt: (NSInteger)index;

@end

@interface FNNewWelfareFlowDeCell : UICollectionViewCell

@property (nonatomic, weak) id<FNNewWelfareFlowDeCellDelegate> delegate;

- (void)setBanners: (NSArray<UIImage*>*)images;
- (void)setTitle: (NSString*)titleUrl andImage: (NSString*)flowImage title2: (NSString*)titleUrl2;

@end

NS_ASSUME_NONNULL_END
