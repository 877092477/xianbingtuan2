//
//  FNmeMeEvaluatesModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/21.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNmeMeEvaluatesModel : NSObject
@property (nonatomic, copy)NSString* head_img;
@property (nonatomic, copy)NSString* nickname;
@property (nonatomic, copy)NSString* color;
@property (nonatomic, copy)NSString* btn_str;
@property (nonatomic, copy)NSArray* tab;
@property (nonatomic, copy)NSString* select_color;
@end


@interface FNmeMeEvaluatesTabItemModel : NSObject
@property (nonatomic, copy)NSString* str;
@property (nonatomic, copy)NSString* type;

@property (nonatomic, copy)NSString* id;
@property (nonatomic, copy)NSString* name;
@property (nonatomic, copy)NSString* img;
@end


NS_ASSUME_NONNULL_END
