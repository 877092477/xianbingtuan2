//
//  Foundation+Extension.m
//  05-runtime
//
//  Created by samlee on 15-7-11.
//  Copyright (c) 2015年 samlee. All rights reserved.
//

#import <objc/runtime.h>

@implementation NSObject(Extension)
+ (void)swizzleClassMethod:(Class)class originSelector:(SEL)originSelector otherSelector:(SEL)otherSelector
{
    
    Method otherMehtod = class_getClassMethod(class, otherSelector);
    Method originMehtod = class_getClassMethod(class, originSelector);
    // 交换2个方法的实现
    method_exchangeImplementations(otherMehtod, originMehtod);
}

+ (void)swizzleInstanceMethod:(Class)class originSelector:(SEL)originSelector otherSelector:(SEL)otherSelector
{
    Method otherMehtod = class_getInstanceMethod(class, otherSelector);
    Method originMehtod = class_getInstanceMethod(class, originSelector);
    // 交换2个方法的实现
    method_exchangeImplementations(otherMehtod, originMehtod);
}
@end

@implementation NSArray(Extension)
+ (void)load
{
    [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayI") originSelector:@selector(objectAtIndex:) otherSelector:@selector(sam_objectAtIndex:)];
}

- (id)sam_objectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self sam_objectAtIndex:index];
    } else {
        return nil;
    }
}

@end

@implementation NSMutableArray(Extension)
+ (void)load
{
    [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(addObject:) otherSelector:@selector(sam_addObject:)];
    [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(objectAtIndex:) otherSelector:@selector(sam_objectAtIndex:)];
}

- (void)sam_addObject:(id)object
{
    if (object != nil) {
        [self sam_addObject:object];
    }
}

- (id)sam_objectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self sam_objectAtIndex:index];
    } else {
        return nil;
    }
}
@end