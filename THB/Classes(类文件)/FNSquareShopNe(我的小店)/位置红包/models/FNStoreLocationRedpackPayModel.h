//
//  FNStoreLocationRedpackPayModel.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/30.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNStoreLocationRedpackPayItemModel : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* val;

@end

@interface FNStoreLocationRedpackPayModel : NSObject

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* money;
@property (nonatomic, copy) NSString* info;
@property (nonatomic, strong) NSArray<FNStoreLocationRedpackPayItemModel*>* att_data;
@property (nonatomic, strong) NSArray* alipay_type;

@end

NS_ASSUME_NONNULL_END
