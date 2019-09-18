//
//  FNTabModel.m
//  THB
//
//  Created by jimmy on 2017/11/2.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNTabModel.h"

@implementation FNTabModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    unsigned int count = 0;
    
    Ivar *vars = class_copyIvarList([self class], &count);
    
    for (int i = 0; i < count; i++)
    {
        const char *varName = ivar_getName(vars[i]);
        
        NSString *varNameStr = [[NSString alloc ] initWithCString:varName encoding:NSUTF8StringEncoding];
        
        id value = [self valueForKey:varNameStr];
        
        [aCoder encodeObject:value forKey:varNameStr];
    }
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
        
    {
        unsigned int count = 0;
        
        Ivar *vars = class_copyIvarList([self class], &count);
        
        for (int i = 0; i < count; i++){
            const char *varName = ivar_getName(vars[i]);
            NSString *varNameStr = [[NSString alloc] initWithCString:varName encoding:NSUTF8StringEncoding];
            
            id value = [aDecoder decodeObjectForKey:varNameStr];
            [self setValue:value forKey:varNameStr];
        }
        
    }
    
    return self;
    
}
@end
