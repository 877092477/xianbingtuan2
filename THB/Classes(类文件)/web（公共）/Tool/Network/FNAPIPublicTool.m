//
//  FNAPIPublicTool.m
//  LikeKaGou
//
//  Created by jimmy on 16/10/10.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "FNAPIPublicTool.h"
#import <objc/runtime.h>
@implementation FNAPIPublicTool
- (void)startRequestSuccess:(SuccessRequest)success failure:(FailureRequest)failure{
    self.time = [NSString GetNowTimes];
    [[XYNetworkAPI sharedManager] postResultWithParameter:[self getParams] url:_apiURL successBlock:^(id responseBody) {
        XYLog(@"-------------------------response(JSON):%@-----------------------",responseBody);
        success(responseBody);
    } failureBlock:^(NSString *error) {
        XYLog(@"-------------------------error:%@-----------------------",error);
        failure(error);
    }];
}
/**
 *  使用runtime获取请求参数(空值或url不参与)
 *
 *  @return 请求参数
 */
- (NSMutableDictionary *)getParams {
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    unsigned int count = 0;
    
    //superclass property
    Ivar *vars = class_copyIvarList([self.superclass class], &count);
    
    for (int i = 0; i < count; i++)
    {
        const char *varName = ivar_getName(vars[i]);
        
        NSString *varNameStr = [[NSString alloc ] initWithCString:varName encoding:NSUTF8StringEncoding];
        
        id value = [self valueForKey:varNameStr];
        if (value != nil && ![varNameStr isEqualToString:@"_apiURL"]) {
            if ([varNameStr isEqualToString:@"_ID"]) {
                varNameStr = @"_id";
            }
            [params setObject:value forKey:[varNameStr substringFromIndex:1]];
        }
        NSLog(@"name:%@,value;%@",varNameStr,value);
    }

    count = 0;
    //self property
    Ivar *vars2 = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++)
    {
        const char *varName = ivar_getName(vars2[i]);
        
        NSString *varNameStr = [[NSString alloc ] initWithCString:varName encoding:NSUTF8StringEncoding];
        
        id value = [self valueForKey:varNameStr];
        if (value != nil && ![varNameStr isEqualToString:@"_apiURL"]) {
            if ([varNameStr isEqualToString:@"_ID"]) {
                varNameStr = @"_id";
            }
            [params setObject:value forKey:[varNameStr substringFromIndex:1]];
        }
        NSLog(@"name:%@,value;%@",varNameStr,value);
    }
    params[SignKey] = [NSString getSignStringWithDictionary:params];
    return params;
}

#pragma mark - undefined key
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    XYLog(@"========UndefinedKey:%@,value:%@=========",key,value);
}
@end
