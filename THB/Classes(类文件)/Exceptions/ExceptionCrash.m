//
//  ExceptionCrash.m
//  THB
//
//  Created by Weller Zhao on 2018/12/24.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "ExceptionCrash.h"

@implementation ExceptionCrash

static ExceptionCrash* _instance = nil;

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    });
    
    return _instance ;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [ExceptionCrash shareInstance] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [ExceptionCrash shareInstance] ;
}

- (void)config {
    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
    
    
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    BOOL isException = [settings boolForKey:ExceptionStatus];
    if (isException) {
        [XYNetworkCache.shareInstance clearCache];
        [settings setBool:NO forKey:ExceptionStatus];
        [settings synchronize];
    }
}

void UncaughtExceptionHandler(NSException *exception) {
    NSArray *arr = [exception callStackSymbols];//得到当前调用栈信息
    NSString *reason = [exception reason];//非常重要，就是崩溃的原因
    NSString *name = [exception name];//异常类型

    NSLog(@"exception type : %@ \n crash reason : %@ \n call stack info : %@", name, reason, arr);

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:ExceptionStatus];
    [userDefaults synchronize];
}

@end
