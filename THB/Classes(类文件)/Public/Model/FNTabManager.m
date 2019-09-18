//
//  FNTabManager.m
//  导购物语
//
//  Created by Weller on 2019/6/6.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNTabManager.h"

@interface FNTabManager()



@end


@implementation FNTabManager


static FNTabManager* _instance = nil;

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;
    
    return _instance ;
}

@end
