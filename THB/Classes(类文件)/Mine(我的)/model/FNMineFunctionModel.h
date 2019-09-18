//
//  FNMineFunctionModel.h
//  THB
//
//  Created by jimmy on 2017/6/2.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuModel.h"
@interface FNMineFunctionModel : MenuModel
/**
 *  ID
 */
@property (nonatomic, copy)NSString* ID;
/**
 *  type
 */
@property (nonatomic, copy)NSString* type;
/**
 *  name
 */
@property (nonatomic, copy)NSString* name;
/**
 *  url
 */
@property (nonatomic, copy)NSString* url;
/**
 *  img
 */
@property (nonatomic, copy)NSString* img;

@end
