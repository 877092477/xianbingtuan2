//
//  FNAccountReleatedModel.h
//  THB
//
//  Created by Jimmy on 2018/2/28.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface JM_ARM_list:NSObject
/**
 img
 */
@property (nonatomic, copy)NSString* img;
/**
 is_gl
 */
@property (nonatomic, copy)NSString* is_gl;
/**
 name
 */
@property (nonatomic, copy)NSString* name;
/**
 type
 */
@property (nonatomic, copy)NSString* type;
@end
@interface FNAccountReleatedModel : NSObject
/**
 content
 */
@property (nonatomic, copy)NSString* content;
/**
 array
 */
@property (nonatomic, copy)NSArray<JM_ARM_list *>* list;
@end
