//
//  UIColor+Hex.h
//  我的优选  页面
//
//  Created by 贾宸穆 on 15/9/1.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”、@“#12345678”
+ (UIColor *)colorWithHexString:(NSString *)color;

+ (NSArray*) getRGBWithHexString:(NSString *)color;

+ (UIColor*) calcColorfromColor: (UIColor*)color1 toColor: (UIColor*)color2 withPercent: (CGFloat)percent;
@end
