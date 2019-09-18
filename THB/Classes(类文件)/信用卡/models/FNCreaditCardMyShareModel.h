//
//  FNCreaditCardMyShareModel.h
//  新版嗨如意
//
//  Created by Weller on 2019/6/25.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNCreaditCardMyShareModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *commission;
@property (nonatomic, copy) NSString *tips;
@property (nonatomic, strong) NSArray *types;

@end

@interface FNCreaditCardMyShareItemModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *apply_str;
@property (nonatomic, copy) NSString *commission_str;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *state_icon;
@property (nonatomic, strong) NSArray<NSString*> *rights;
@property (nonatomic, copy) NSString *rights_color;
@property (nonatomic, copy) NSString *rights_bg;

@end

NS_ASSUME_NONNULL_END
