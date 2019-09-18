//
//  Singleton.m
//  THB
//
//  Created by Weller Zhao on 2018/12/21.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

static Singleton* _instance = nil;

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
    return [Singleton shareInstance] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [Singleton shareInstance] ;
}

//- (void)

@end
