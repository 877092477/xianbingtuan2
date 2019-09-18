//
//  FNtradeVideoDeTopCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/25.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
 
NS_ASSUME_NONNULL_BEGIN

@interface FNtradeVideoDeTopCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView   *headImgView;
@property (nonatomic, strong)UIImageView   *shoImgView;
@property (nonatomic, strong)UILabel   *shoLB;
@property (nonatomic, strong)UIView *bottomView;
@property (nonatomic, strong)UIImageView   *hotImgView;
@property (nonatomic, strong)UIImageView   *typeImgView;

@property (nonatomic, strong)UILabel    *nameLB;
@property (nonatomic, strong)UILabel    *titleLB;
@property (nonatomic, strong)UILabel    *dateLB;
@property (nonatomic, strong)UILabel    *countLB;
@property (nonatomic, strong)UIButton   *likeBtn;
@property (nonatomic, strong)UIButton   *shareBtn;
@property (nonatomic, strong)UIButton   *playBtn;
@end

NS_ASSUME_NONNULL_END
