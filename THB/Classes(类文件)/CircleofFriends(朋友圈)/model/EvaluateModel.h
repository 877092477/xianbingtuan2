//
//  EvaluateModel.h
//  THB
//
//  Created by Jimmy on 2018/8/31.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EvaluateModel : NSObject

@property(nonatomic, copy) NSString     *pj_nickname;
@property(nonatomic, copy) NSString     *pj_head_img;
@property(nonatomic, copy) NSString     *as_nickname;
@property(nonatomic, copy) NSString     *time;
@property(nonatomic, copy) NSString     *content;
@property(nonatomic, copy) NSString     *cir_id;
@property(nonatomic, copy) NSString     *uid;
@property(nonatomic, copy) NSString     *id;
@property(nonatomic, copy) NSString     *as_uid;

@end


@interface LikeHeadPortraitModel : NSObject

@property(nonatomic, copy) NSString     *id;
@property(nonatomic, copy) NSString     *nickname;
@property(nonatomic, copy) NSString     *head_img;
@property(nonatomic, copy) NSString     *cir_id;
@property(nonatomic, copy) NSString     *time;


@end
