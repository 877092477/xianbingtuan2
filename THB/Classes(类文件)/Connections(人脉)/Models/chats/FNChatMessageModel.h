//
//  FNChatMessageModel.h
//  THB
//
//  Created by Weller Zhao on 2019/2/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNChatMessageModel : NSObject

@property (nonatomic, copy) NSString *target;
@property (nonatomic, copy) NSString *sendee_uid;
@property (nonatomic, copy) NSString *room;
@property (nonatomic, copy) NSString *unread;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *head_img;


@end

NS_ASSUME_NONNULL_END
