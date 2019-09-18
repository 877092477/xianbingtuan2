//
//  FNCreaditCardTopModel.h
//  新版嗨如意
//
//  Created by Weller on 2019/6/21.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNCreaditCardTopIconModel : NSObject

@property (nonatomic, copy) NSString *b_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *ID;

@end

@interface FNCreaditCardTopModel : NSObject

@property (nonatomic, copy) NSString *bg;
@property (nonatomic, copy) NSString *bili;
@property (nonatomic, copy) NSString *recommend_icon;
@property (nonatomic, copy) NSString *recommend;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *extend;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *back;
@property (nonatomic, strong) NSArray<FNCreaditCardTopIconModel*> *list;

@end

NS_ASSUME_NONNULL_END
