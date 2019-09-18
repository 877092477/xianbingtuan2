//
//  SaleMethod.h
//  TYM
//
//  Created by 郭永江 on 15/7/24.
//  Copyright (c) 2015年 com.TYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface SafeMethod:NSObject
+ (void)exchangeOriginalMethod:(Method)originalMethod withNewMethod:(Method)newMethod;
@end

@interface NSArray (Safe)
+ (Method)methodOfSelector:(SEL)selector;
- (id)objectAtIndexOrNil:(NSUInteger)index;
@end

@interface NSMutableArray (Safe)
+ (Method)methodOfSelector:(SEL)selector;
- (id)objectAtIndexOrNilM:(NSUInteger)index;
- (void)safe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
-(void)removeObjectAtIndexSafe:(NSUInteger)index;
@end


@interface NSMutableDictionary (Safe)
+ (Method)methodOfSelector:(SEL)selector;
- (void)safe_setObject:(id)anObject forKey:(id<NSCopying>)aKey;
@end

//@interface UIView (Safe)
//+ (Method)methodOfSelector:(SEL)selector;
//- (void)safe_addSubview:(UIView *)view;
//@end

@interface UIViewController (HideMB)
+(Method)methodOfSelector:(SEL)selector;
-(void)JWD_viewWillAppear:(BOOL)animated;

@end

