//
//  FNSomeTeItemModel.h
//  THB
//
//  Created by 李显 on 2019/1/23.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNSomeTeItemModel : NSObject

@end

@interface FNSomeGoodsCateModel : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *SkipUIIdentifier; 
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *category_name;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *addType;
@end

@interface FNSomeGoodsScreenModel : NSObject
@property(nonatomic,strong)NSString *is_up;
@property(nonatomic,strong)NSString *check_color;
@property(nonatomic,strong)NSString *color;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *name;

@end

NS_ASSUME_NONNULL_END
