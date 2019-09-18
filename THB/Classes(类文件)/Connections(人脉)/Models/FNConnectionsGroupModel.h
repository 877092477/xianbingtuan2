//
//  FNConnectionsGroupModel.h
//  THB
//
//  Created by Weller Zhao on 2019/2/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNConnectionsGroupModel : NSObject

@property (nonatomic, copy) NSString* qid;
@property (nonatomic, copy) NSString* uid;
@property (nonatomic, copy) NSString* room;
@property (nonatomic, copy) NSString* nickname;
@property (nonatomic, copy) NSString* content;
@property (nonatomic, copy) NSString* head_img;
@property (nonatomic, copy) NSString* target;

@end

NS_ASSUME_NONNULL_END
