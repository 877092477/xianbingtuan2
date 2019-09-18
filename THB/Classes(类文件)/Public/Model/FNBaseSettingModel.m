//
//  FNBaseSettingModel.m
//  SuperMode
//
//  Created by jimmy on 2017/6/6.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNBaseSettingModel.h"

@implementation FNBaseSettingModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count = 0;
    Ivar *vars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++){
        const char *varName = ivar_getName(vars[i]);
        NSString *varNameStr = [[NSString alloc ] initWithCString:varName encoding:NSUTF8StringEncoding];
        
        id value = [self valueForKey:varNameStr];
        [aCoder encodeObject:value forKey:varNameStr];
    }
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]){
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

//model转化为字典
- (id)dicFromObject:(NSObject *)object {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([object class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:cName];
        NSObject *value = [object valueForKey:name];//valueForKey返回的数字和字符串都是对象
        if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
            //string , bool, int ,NSinteger
            [dic setObject:value forKey:name];
        } else if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
            //字典或数组
            [dic setObject:[self arrayOrDicWithObject:(NSArray*)value] forKey:name];
        } else if (value == nil) {
            //null
            [dic setObject:@"" forKey:name];
        } else {
            //model
            [dic setObject:[self dicFromObject:value] forKey:name];
        }
    }
    
    return [[object class] mj_objectWithKeyValues:dic];
}

//将可能存在model数组转化为普通数组
- (id)arrayOrDicWithObject:(id)origin {
    if ([origin isKindOfClass:[NSArray class]]) {
        //数组
        NSMutableArray *array = [NSMutableArray array];
        for (NSObject *object in origin) {
            if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) {
                //string , bool, int ,NSinteger
                [array addObject:object];
            } else if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]]) {
                //数组或字典
                [array addObject:[self arrayOrDicWithObject:(NSArray *)object]];
            } else {
                //model
                [array addObject:[self dicFromObject:object]];
            }
        }
        return [array copy];
    } else if ([origin isKindOfClass:[NSDictionary class]]) {
        //字典
        NSDictionary *originDic = (NSDictionary *)origin;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for (NSString *key in originDic.allKeys) {
            id object = [originDic objectForKey:key];
            if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) {
                //string , bool, int ,NSinteger
                [dic setObject:object forKey:key];
            } else if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]]) {
                //数组或字典
                [dic setObject:[self arrayOrDicWithObject:object] forKey:key];
            } else {
                //model
                [dic setObject:[self dicFromObject:object] forKey:key];
            }
        }
        return [dic copy];
    }
    return [NSNull null];
}

+ (void)saveSetting:(FNBaseSettingModel *)model{
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:model] forKey:@"homeCache"];
}
+ (FNBaseSettingModel *)settingInstance{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"homeCache"];
    FNBaseSettingModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (model == nil) {
        model = [FNBaseSettingModel new];
    }
    model=[model dicFromObject:model];
    return model;
}

- (void)refresh {
    
}

@end
