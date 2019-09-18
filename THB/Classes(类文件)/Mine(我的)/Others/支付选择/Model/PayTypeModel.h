//
//  PayTypeModel.h
//  省钱诚舀金
//
//  Created by Fnuo-iOS on 2018/6/14.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayTypeModel : NSObject

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *str;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, assign) BOOL isSelected;

@end
