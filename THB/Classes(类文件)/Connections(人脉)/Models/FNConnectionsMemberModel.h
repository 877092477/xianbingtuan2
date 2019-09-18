//
//  FNConnectionsMemberModel.h
//  THB
//
//  Created by Weller Zhao on 2019/1/14.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNConnectionsMemberModel : NSObject

@property (nonatomic, copy) NSString* tg_lv;
@property (nonatomic, copy) NSString* lower_reg_time;
@property (nonatomic, copy) NSString* abc;
@property (nonatomic, copy) NSString* head_img;
@property (nonatomic, copy) NSString* nickname;
@property (nonatomic, copy) NSString* Vname;
@property (nonatomic, copy) NSString* commission;
@property (nonatomic, assign) int count;
@property (nonatomic, copy) NSString* reg_time;
@property (nonatomic, copy) NSString* commision_unit;
@property (nonatomic, copy) NSString* team_unit;
@property (nonatomic, copy) NSString* commision_str;
@property (nonatomic, copy) NSString* team_str;
@property (nonatomic, copy) NSString* online_str;
@property (nonatomic, copy) NSString* online_color;
@property (nonatomic, assign) BOOL is_online;
@property (nonatomic, copy) NSString* phone_str;
@property (nonatomic, assign) BOOL is_group;
@property (nonatomic, copy) NSString* uid;
@property (nonatomic, copy) NSString* tg_str;

@property (nonatomic, copy) NSString* room;

@property (nonatomic, copy) NSString* target;
@property (nonatomic, assign) BOOL is_ingroup;


@end

@interface FNConnectionsMemberGroupModel : NSObject

@property (nonatomic, copy) NSString* str;
@property (nonatomic, strong) NSArray<FNConnectionsMemberModel*>* list;
@property (nonatomic, copy) NSString* is_show;

@end

NS_ASSUME_NONNULL_END
