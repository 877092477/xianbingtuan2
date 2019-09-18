//
//  FNCategoryModel.h
//  SuperMode
//
//  Created by jimmy on 2017/6/21.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNCategoryModel : NSObject
/**
 *  功能页面标题
 */
@property (nonatomic, copy)NSString* title;
/**
 *  功能页面标识
 */
@property (nonatomic, copy)NSString* type;
/**
 *  默认选中 	0不选中 1选中
 */
@property (nonatomic, copy)NSString* is_check;
/**
 *  keyword
 */
@property (nonatomic, copy)NSString* keyword;

@property (nonatomic, copy)NSString* ID;

@property (nonatomic, copy)NSString* catename;

@property (nonatomic, copy)NSString* name;

/**
 *  highlight
 */
@property (nonatomic, copy)NSString* highlight;
/**
 *  miaoshu
 */
@property (nonatomic, copy)NSString* miaoshu;
/**
 *  img
 */
@property (nonatomic, copy)NSString* img;
@end
