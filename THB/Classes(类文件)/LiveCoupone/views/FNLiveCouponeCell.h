//
//  FNLiveCouponeCell.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/26.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNLiveCouponeCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imgHeader;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;
@property (nonatomic, strong) UILabel *lblCount;
@property (nonatomic, strong) UIImageView *btnAccept;

@end

NS_ASSUME_NONNULL_END
