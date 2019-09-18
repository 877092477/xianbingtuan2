//
//  ProfileModel.m
//  THB
//
//  Created by zhongxueyu on 16/4/13.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有 2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "ProfileModel.h"

@implementation ProfileModel
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


+ (void)saveProfile:(ProfileModel *)model{
    if ([model isKindOfClass:[ProfileModel class]]) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:model] forKey:@"ProfileModel"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}
+ (ProfileModel *)profileInstance{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"ProfileModel"];
    ProfileModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (model == nil) {
        model = [ProfileModel new];
    }
    return model;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}
@end
