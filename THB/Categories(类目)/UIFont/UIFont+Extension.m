//
//  UIFont+Extension.m
// JYJInsurenceBroker
//
//  Created by JYJ on 16/2/23.
//  Copyright © 2016年 baobeikeji. All rights reserved.
//

#import "UIFont+Extension.h"
#import <CoreText/CoreText.h>
@implementation UIFont (Extension)
+ (UIFont *)fontWithDevice:(CGFloat)fontSize {
    if (XYScreenWidth > 375) {
        fontSize = fontSize + 3;
    }else if (XYScreenWidth == 375){
        fontSize = fontSize + 1.5;
    }else if (XYScreenWidth == 320){
        fontSize = fontSize;
    }
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    return font;
}

+ (UIFont *)navItemFontWithDevice:(CGFloat)fontSize {
    if (XYScreenWidth > 375) {
        fontSize = fontSize + 2;
    }else if (XYScreenWidth == 375){
        fontSize = fontSize + 1;
    }else if (XYScreenWidth == 320){
        fontSize = fontSize;
    }
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    return font;
}

+ (UIFont *)fontWithTwoLine:(CGFloat)fontSize {
    if (XYScreenWidth > 375) {
        fontSize = fontSize + 2;
    }else if (XYScreenWidth == 375){
        fontSize = fontSize + 1;
    }else if (XYScreenWidth == 320){
        fontSize = fontSize;
    }
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    return font;
}

+ (UIFont *)insuranceCellFont:(CGFloat)fontSize {
    if (XYScreenWidth > 375) {
        fontSize = fontSize + 3.5;
    }else if (XYScreenWidth == 375){
        fontSize = fontSize + 2;
    }else if (XYScreenWidth == 320){
        fontSize = fontSize;
    }
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    return font;
}

+(UIFont*)customFontWithPath:(NSString*)path size:(CGFloat)size
{
    NSURL *fontUrl = [NSURL fileURLWithPath:path];
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)fontUrl);
    CGFontRef fontRef = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    CTFontManagerRegisterGraphicsFont(fontRef, NULL);
    NSString *fontName = CFBridgingRelease(CGFontCopyPostScriptName(fontRef));
    UIFont *font = [UIFont fontWithName:fontName size:size];
    CGFontRelease(fontRef);
    return font;
}
@end
