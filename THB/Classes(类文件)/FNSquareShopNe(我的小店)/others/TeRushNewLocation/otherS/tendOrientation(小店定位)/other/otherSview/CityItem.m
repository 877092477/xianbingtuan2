//
//  CityItem.m
//  69橙子
//
//  Created by 李显 on 2018/12/9.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "CityItem.h"

@implementation CityItem
- (instancetype)initWithTitleName:(NSString *)titleName {
    if (self = [super init]) {
        self.titleName = [NSString stringWithFormat:@"%@",titleName];
    }
    return self;
}

+ (instancetype)initWithTitleName:(NSString *)titleName {
    
    return [[self alloc] initWithTitleName:titleName];
}
@end
