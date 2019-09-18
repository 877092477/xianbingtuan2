//
//  SaleMethod.m
//  TYM
//
//  Created by 郭永江 on 15/7/24.
//  Copyright (c) 2015年 com.TYM. All rights reserved.
//

#import "SaleMethod.h"
#import "AppDelegate.h"
@implementation SafeMethod

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //NSArray
        [self exchangeOriginalMethod:[NSArray methodOfSelector:@selector(objectAtIndex:)] withNewMethod:[NSArray methodOfSelector:@selector(objectAtIndexOrNil:)]];
        
        //NSMutableArray
        [self exchangeOriginalMethod:[NSMutableArray methodOfSelector:@selector(objectAtIndex:)] withNewMethod:[NSMutableArray methodOfSelector:@selector(objectAtIndexOrNilM:)]];
        [self exchangeOriginalMethod:[NSMutableArray methodOfSelector:@selector(replaceObjectAtIndex:withObject:)] withNewMethod:[NSMutableArray methodOfSelector:@selector(safe_replaceObjectAtIndex:withObject:)]];
        [self exchangeOriginalMethod:[NSMutableArray methodOfSelector:@selector(removeObjectAtIndex:)] withNewMethod:[NSMutableArray methodOfSelector:@selector(removeObjectAtIndexSafe:)]];
        
        //NSMutableDictionary
        [self exchangeOriginalMethod:[NSMutableDictionary methodOfSelector:@selector(setObject:forKey:)] withNewMethod:[NSMutableDictionary methodOfSelector:@selector(safe_setObject:forKey:)]];
        
        //viewWillAppear
        [self exchangeOriginalMethod:[UIViewController methodOfSelector:@selector(viewWillAppear:)] withNewMethod:[UIViewController methodOfSelector:@selector(JWD_viewWillAppear:)]];
    });
}

+ (void)exchangeOriginalMethod:(Method)originalMethod withNewMethod:(Method)newMethod
{
    method_exchangeImplementations(originalMethod, newMethod);
}

@end

@implementation NSArray (Safe)

#pragma mark - NSArray
+ (Method)methodOfSelector:(SEL)selector
{
    @autoreleasepool{
        return class_getInstanceMethod(NSClassFromString(@"__NSArrayI"),selector);
    }
}


- (id)objectAtIndexOrNil:(NSUInteger)index
{    @autoreleasepool{
    return (index < [self count]) ? [self objectAtIndexOrNil:index] : nil;
}
}
@end


@implementation NSMutableArray (Safe)


#pragma mark - NSMutableArray
+ (Method)methodOfSelector:(SEL)selector
{ @autoreleasepool{
    return class_getInstanceMethod(NSClassFromString(@"__NSArrayM"),selector);
}
    
    
}

- (id)objectAtIndexOrNilM:(NSUInteger)index
{
    @autoreleasepool{
        return (index < [self count]) ? [self objectAtIndexOrNilM:index] : nil;
    }
    
    
}

- (void)safe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    @autoreleasepool {
        if ((index < [self count])&&anObject) {
            [self safe_replaceObjectAtIndex:index withObject:anObject];
        }
        
    }
}

-(void)removeObjectAtIndexSafe:(NSUInteger)index{
    @autoreleasepool {
        if (index < [self count]) {
            [self removeObjectAtIndexSafe:index];
        }
    }
    
}
@end


#pragma mark - NSMutableDictionary
@implementation NSMutableDictionary (Safe)

+ (Method)methodOfSelector:(SEL)selector
{
    @autoreleasepool{
        return class_getInstanceMethod(NSClassFromString(@"__NSDictionaryM"),selector);
    }
    
}

- (void)safe_setObject:(id)anObject forKey:(id<NSCopying>)aKey
{  @autoreleasepool{
    if (anObject) {
        [self safe_setObject:anObject forKey:aKey];
    }
    else
    {
        [self removeObjectForKey:aKey];
    }
}
    
}

@end

#pragma mark - UIViewCon
@implementation UIViewController (HideMB)

+(Method)methodOfSelector:(SEL)selector{
    @autoreleasepool {
        return class_getInstanceMethod(NSClassFromString(@"UIViewController"), selector);
    }
    
}

-(void)JWD_viewWillAppear:(BOOL)animated{
    @autoreleasepool {
        [self JWD_viewWillAppear:animated];
        
        NSLog(@"出自----%@----类",NSStringFromClass([self class]));
    }
}
@end

