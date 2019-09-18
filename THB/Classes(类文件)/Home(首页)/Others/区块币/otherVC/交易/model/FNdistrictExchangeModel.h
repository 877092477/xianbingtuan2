//
//  FNdistrictExchangeModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/7.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNdistrictExchangeModel : NSObject

@end

@interface FNdisExchangeSortModel : NSObject
@property (nonatomic , copy) NSString              *dominant_color;
@property (nonatomic , copy) NSArray               *list;
@end

@interface FNdisExchangeSortItemModel : NSObject
@property (nonatomic , copy) NSString              *title;
@property (nonatomic , copy) NSString              *type;
@end

@interface FNdisExchangeOddItemModel : NSObject
@property (nonatomic , copy) NSString              *id;
@property (nonatomic , copy) NSString              *type;
@property (nonatomic , copy) NSArray               *bottom;
@property (nonatomic , copy) NSString              *username;
@property (nonatomic , copy) NSString              *transaction_number;
@property (nonatomic , copy) NSString              *time;
@property (nonatomic , copy) NSString              *icon;
@property (nonatomic , copy) NSString              *btn_text;
@property (nonatomic , copy) NSString              *type_text;
@property (nonatomic , copy) NSString              *status;
@end

@interface FNdisExchangeAcrossItemModel : NSObject
@property (nonatomic , copy) NSString              *number;
@property (nonatomic , copy) NSString              *tips;
@property (nonatomic , assign) NSInteger              showInt;
@end

NS_ASSUME_NONNULL_END
