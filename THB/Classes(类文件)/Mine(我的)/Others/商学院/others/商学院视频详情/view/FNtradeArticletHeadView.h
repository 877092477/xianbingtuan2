//
//  FNtradeArticletHeadView.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNtradeArticletHeadView : UICollectionReusableView
@property (nonatomic, strong)UIImageView   *typeImgView;
@property (nonatomic, strong)UIImageView   *hotImgView;
@property (nonatomic, strong)UILabel    *titleLB;
@property (nonatomic, strong)UILabel    *hintLB;
@property (nonatomic, strong)UILabel    *countLB;

@end

NS_ASSUME_NONNULL_END
