//
//  FNLiveBroadcastModel.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/19.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNLiveBroadcastButtonModel : NSObject

@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* img;
@property (nonatomic, copy) NSString* check_img;
@property (nonatomic, copy) NSString* str;
@property (nonatomic, copy) NSString* color;

@end

@interface FNLiveBroadcastNoticeModel : NSObject


@property (nonatomic, copy) NSString* is_show;
@property (nonatomic, copy) NSString* left_img;
@property (nonatomic, copy) NSString* right_img;
@property (nonatomic, copy) NSString* left_str;
@property (nonatomic, copy) NSString* right_str;
@property (nonatomic, copy) NSString* left_color;
@property (nonatomic, copy) NSString* right_color;

@end

@interface FNLiveBroadcastModel : NSObject

@property (nonatomic, copy) NSString* return_img;
@property (nonatomic, copy) NSString* top_img;
@property (nonatomic, copy) NSString* top_fontcolor;
@property (nonatomic, strong) NSArray<NSString*>* img_list;

@property (nonatomic, copy) NSString *live_send_time;
@property (nonatomic, copy) NSString *live_user_time;

@property (nonatomic, strong) FNLiveBroadcastNoticeModel* affiche;

@property (nonatomic, strong) NSArray<FNLiveBroadcastButtonModel*>* ico_list;

@end

NS_ASSUME_NONNULL_END
