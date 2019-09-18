//
//  FNreckSetDeModel.h
//  THB
//
//  Created by Jimmy on 2018/12/25.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNreckSetDeModel : NSObject

@property (nonatomic, copy)NSString* str;

@property (nonatomic, copy)NSString* time_str;

@property (nonatomic, copy)NSString* sr_sum;

@property (nonatomic, copy)NSString* zc_sum;

@property (nonatomic, copy)NSArray* list;

@end


@interface FNreckSetCateDeModel : NSObject

@property (nonatomic, copy)NSString* name;

@property (nonatomic, copy)NSString* type;

@end


@interface FNreckSetScreenDeModel : NSObject

@property (nonatomic, copy)NSString* name;

@property (nonatomic, copy)NSArray* list;

@end


@interface FNreckScreenItemModel : NSObject

@property (nonatomic, copy)NSString* name;

@property (nonatomic, copy)NSString* screen_type;

@property (nonatomic, assign)NSInteger state;
@property (nonatomic, assign)NSInteger stateID; 

@property (nonatomic, assign)NSInteger typeInt; 
@property (nonatomic, copy)NSString*tg_type;//    是    string    类型    传到订单接口 tg_type
@property (nonatomic, copy)NSString*color;//    是    string    未选中文字颜色    未选中文字颜色
@property (nonatomic, copy)NSString*bj_color;//    是    string    未选中背景颜色    未选中背景颜色
@property (nonatomic, copy)NSString*check_color;//    是    string    选中文字颜色    选中文字颜色
@property (nonatomic, copy)NSString*check_bj_color;//    是    string    选中背景颜色    选中背景颜色

@end


@interface FNreckSetItemModel : NSObject

@property (nonatomic, copy)NSString* id;

@property (nonatomic, copy)NSString* label;

@property (nonatomic, copy)NSString* label_color;

@property (nonatomic, copy)NSString* str;

@property (nonatomic, copy)NSString* detail;

@property (nonatomic, copy)NSString* time;

@property (nonatomic, copy)NSString* type_str;

@property (nonatomic, copy)NSString* o_str;

@property (nonatomic, copy)NSString* type;

@property (nonatomic, copy)NSString* oid;

@end

NS_ASSUME_NONNULL_END
