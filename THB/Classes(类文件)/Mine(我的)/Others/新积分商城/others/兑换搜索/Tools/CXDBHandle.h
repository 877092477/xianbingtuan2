//
//  CXDBHandle.h
//
//
//
//
//

#import <Foundation/Foundation.h>

@interface CXDBHandle : NSObject

/**
 *  根据参数去取数据
 *
 *  @param params
 *
 */
+ (NSDictionary *)statusesWithParams:(NSDictionary *)params;

/**
 *  存储服务器数据到沙盒中
 *
 *  @param statuses 需要存储的数据
 */
+ (void)saveStatuses:(NSDictionary *)statuses andParam:(NSDictionary *)ParamDict;

@end
