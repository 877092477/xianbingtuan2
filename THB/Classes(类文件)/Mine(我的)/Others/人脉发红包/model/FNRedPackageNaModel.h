//
//  FNRedPackageNaModel.h
//  THB
//
//  Created by Jimmy on 2019/2/11.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNRedPackagePayModel : NSObject

@property(nonatomic, copy) NSString* pay_type;
@property(nonatomic, copy) NSString* img;
@property(nonatomic, copy) NSString* str;
@property(nonatomic, copy) NSString* str2;

@end

@interface FNRedPackageNaModel : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *unit;
@property(nonatomic,copy)NSString *remark;
@property(nonatomic,copy)NSString *img;
@property(nonatomic,copy)NSString *sum;
@property(nonatomic,copy)NSString *carry;
@property(nonatomic,copy)NSString *hint;
@property(nonatomic,copy)NSString *amend;
@property(nonatomic,copy)NSString *alert;
@property(nonatomic,copy)NSString *amendState;
@property(nonatomic,copy)NSString *num;
@property(nonatomic,copy)NSString *statePacket;


@end

@interface FNpackagePayNaModel : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *img;
@property(nonatomic,copy)NSString *sum;
@property(nonatomic,copy)NSString *payType;
@property(nonatomic,copy)NSString *money;
@property(nonatomic,assign)NSInteger state;
@property(nonatomic,assign)NSInteger payId;
@end

NS_ASSUME_NONNULL_END
