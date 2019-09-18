//
//  FNmerSetPhotoItemModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNmerSetPhotoItemModel : NSObject
@property (nonatomic, assign)NSInteger type;
@property (nonatomic, assign)NSInteger state;
@property (nonatomic, copy)NSString* id;
@property (nonatomic, copy)NSString* img;
@property (nonatomic, copy)NSString* name;
@end

NS_ASSUME_NONNULL_END
