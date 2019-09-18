//
//  FNclockInZoModel.h
//  THB
//
//  Created by Jimmy on 2019/2/27.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNclockInZoModel : NSObject
@property(nonatomic,strong)NSString *str1;
@property(nonatomic,strong)NSString *str2;
@property(nonatomic,strong)NSString *str3;
@property(nonatomic,strong)NSString *str4;
@property(nonatomic,strong)NSArray *pay;

@property(nonatomic,strong)NSArray *paytype; 



@end


@interface FNclockInTypeItemModel : NSObject

@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *str;
@property(nonatomic,assign)NSInteger state;
@property(nonatomic,assign)NSInteger identifying;

@end


@interface FNclockInpayItemModel : NSObject

@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *money;
@property(nonatomic,strong)NSString *str;
@property(nonatomic,assign)NSInteger state;
@property(nonatomic,assign)NSInteger identifying;

@end

@interface FNclockDKDoingModel : NSObject

@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *str;
@property(nonatomic,strong)NSString *str2;
@property(nonatomic,strong)NSString *str3;


@end


NS_ASSUME_NONNULL_END
