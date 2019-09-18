//
//  FNVideoModel.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/1.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNVideoLineModel: NSObject

@property (nonatomic, copy) NSString* check_img;
@property (nonatomic, copy) NSString* img;
@property (nonatomic, copy) NSString* str;
@property (nonatomic, copy) NSString* color;

@end

@interface FNVideoModel : NSObject

@property (nonatomic, copy) NSString* movie_url;
@property (nonatomic, copy) NSString* old_url;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* score_str;
@property (nonatomic, copy) NSString* hot_str;
@property (nonatomic, copy) NSString* info;
@property (nonatomic, copy) NSString* str;
@property (nonatomic, copy) NSString* hot_img;
@property (nonatomic, copy) NSString* btn_img;
@property (nonatomic, strong) NSArray<FNVideoLineModel*>* list;

@end

NS_ASSUME_NONNULL_END
