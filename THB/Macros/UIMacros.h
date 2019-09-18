//
//  UIMacros.h
//  FnuoApp
//
//  Created by zhongxueyu on 16/2/22.
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

#ifndef UIMacros_h
#define UIMacros_h
//获取颜色
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)                        RGBA(r, g, b, 1.0f)
#define navigationBarColor RGB(244, 62, 121)

#define RED RGB (244,62,121)
#define Green RGB (37,185,185)

#define Yellow RGB (245,199,28)

#define CommentTextColor RGB(43, 170, 226)
#define LineGrayColor RGB(240, 242, 241)
#define FXRedColor RGB(242, 21, 72)
#define GrayColor [UIColor colorWithRed:0.6941 green:0.6941 blue:0.6941 alpha:1.0]
#define TexGraytColor RGB(93, 93, 93)
#define FNGrayColor [UIColor grayColor]
//字体

#define kFONT17                  [UIFont systemFontOfSize:17]
#define kFONT16                  [UIFont systemFontOfSize:16]
#define kFONT15                  [UIFont systemFontOfSize:15]
#define kFONT14                  [UIFont systemFontOfSize:14]
#define kFONT13                  [UIFont systemFontOfSize:13]
#define kFONT12                  [UIFont systemFontOfSize:12]
#define kFONT11                  [UIFont systemFontOfSize:11]
#define kFONT10                  [UIFont systemFontOfSize:10]

#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define IOS11 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0 ? YES : NO)
#define XYStatusBarHeight (IOS7==YES ? 0 : 20)
#define BackHeight      (IOS7==YES ? 0 : 15)

#define XYNavBarHeigth (isIphoneX==YES ? 88 : 64)
#define JMNavBarHeigth (isIphoneX==YES ? 88 : 64)
//#define XYNavBarHeigth 64
#define isIphoneX FNKeyWindow.bounds.size.height>=812
#define isIphone5 FNKeyWindow.bounds.size.width <=320
//动画时间
#define IMGDuration 0.9
//界面相关
#define TABBAR_H self.tabBarController.tabBar.frame.size.height
//相对iphone6 屏幕比
#define KWidth_Scale    [UIScreen mainScreen].bounds.size.width/375.0f

#define FNDisplayName [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleDisplayName"]



#endif /* UIMacros_h */
