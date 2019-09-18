//
//  FNLiveBroadcastGoodsModel.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNLiveBroadcastGoodsModel: NSObject

@property (nonatomic, copy)NSString *head_img;
@property (nonatomic, copy)NSString *lr;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *time;
@property (nonatomic, copy)NSString *key;

@property (nonatomic, copy)NSString *data;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) FNBaseProductModel *product;


@end

NS_ASSUME_NONNULL_END
