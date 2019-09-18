//
//  FNStoreJoinCateModel.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/19.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNStoreJoinTagModel : NSObject

@property (nonatomic, copy) NSString* id;
@property (nonatomic, copy) NSString* name;

@property (nonatomic, assign) BOOL isSelected;

@end

@interface FNStoreJoinCateModel : NSObject

@property (nonatomic, copy) NSString* id;
@property (nonatomic, copy) NSString* catename;
@property (nonatomic, strong) NSArray<FNStoreJoinTagModel*>* label;

@property (nonatomic, assign) BOOL isSelected;

@end

NS_ASSUME_NONNULL_END
