//
//  FNPartnerCenterHeader.h
//  SuperMode
//
//  Created by jimmy on 2017/10/16.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
extern const CGFloat _pch_avatar_h;
@interface FNPartnerCenterHeader : UICollectionReusableView
@property (nonatomic, strong)UIImageView* avatarimgview;
@property (nonatomic, strong)UILabel* nameLabel;

/**
 member background
 */
@property (nonatomic, strong)UIView* bgview;
@property (nonatomic, strong)UILabel* memberLabel;
@property (nonatomic, strong)UIImageView*  membericon;

@property (nonatomic, strong)UIImageView* bgimgview;

@end
