//
//  FNmerMembersModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/16.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNmerMembersModel : NSObject
@property (nonatomic, copy)NSString* type;
@property (nonatomic, copy)NSString* hint;
@property (nonatomic, copy)NSString* name;
@property (nonatomic, copy)NSArray* list;
@property (nonatomic, copy)NSString* img;
@end

@interface FNmerMembersUserModel : NSObject
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* top_color;
@property (nonatomic, copy)NSString* top_bj;
@property (nonatomic, copy)NSArray* orders;
@property (nonatomic, copy)NSString* user_name;
@property (nonatomic, copy)NSString* head_img;
@end

@interface FNmerMembersOrderItemModel : NSObject
@property (nonatomic, copy)NSString* id;
@property (nonatomic, copy)NSString* img;
@property (nonatomic, copy)NSString* title;
@property (nonatomic, copy)NSString* title_color;
@property (nonatomic, copy)NSString* time;
@property (nonatomic, copy)NSString* time_color;
@property (nonatomic, copy)NSString* status;
@property (nonatomic, copy)NSString* status_color;


@end

NS_ASSUME_NONNULL_END
