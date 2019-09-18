//
//  FNPartnerApplyModel.h
//  SuperMode
//
//  Created by jimmy on 2017/10/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FAMintroduce;
@interface FNPartnerApplyModel : NSObject
/**
 *  客服电话
 */
@property (nonatomic, copy)NSString* ContactPhone;
/**
 *  视频封面图片
 */
@property (nonatomic, copy)NSString* apphhr_img;
/**
 *  视频链接
 */
@property (nonatomic, copy)NSString*apphhr_movie;
/**
 *  introduce
 */
@property (nonatomic, strong)NSArray<FAMintroduce *>* introduce;

@end
@interface FAMintroduce:NSObject
/**
 *  标题
 */
@property (nonatomic, copy)NSString* title;
/**
 *  内容
 */
@property (nonatomic, copy)NSString* content;
@end
