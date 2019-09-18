//
//  FNNewProductDetailHeader.h
//  THB
//
//  Created by Jimmy on 2017/12/16.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMView.h"
@class FNNewProductDetailModel;
@interface FNNewProductDetailHeader : JMView
@property (nonatomic, strong)FNNewProductDetailModel* model;
@property (nonatomic, copy)void (^shopClicked) (void);
@property (nonatomic, copy)void (^getCouponClicked) (void);
@property (nonatomic, copy)void (^shareClicked) (void);
@property (nonatomic, copy)void (^PlayClicked) (void);
@property (nonatomic, copy)void (^CopyClicked) (void);
@property (nonatomic, copy)void (^CommentClicked) (void);
@property (nonatomic, copy)void (^CommentImageClicked) (UIImageView *imageview, NSInteger index);
@property (nonatomic, copy)void (^productClicked)(FNBaseProductModel* model);
@property (nonatomic, copy)void (^bannerClicked)(UIImageView* imageview,NSInteger index);


@property (nonatomic, copy)void (^upgradeClicked) (void);

-(void)stopPlaying;
@end
