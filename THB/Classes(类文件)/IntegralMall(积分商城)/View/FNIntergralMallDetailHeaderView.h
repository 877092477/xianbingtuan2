//
//  FNIntergralMallDetailHeaderView.h
//  THB
//
//  Created by Weller Zhao on 2019/1/3.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNIntergralMallDetailHeaderView : UICollectionViewCell

@property (nonatomic, copy)void (^upgradeClicked) (void);

@property (nonatomic, copy)void (^shareClicked) (void);

@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblPrice;
@property (nonatomic, strong) UILabel *lblDesc;
@property (nonatomic, strong) UILabel *lblCount;

- (void)setHeader: (NSArray<NSString*>*) headerUrls;
- (void)setModel: (FNBaseProductModel*)model ;

@end

NS_ASSUME_NONNULL_END
