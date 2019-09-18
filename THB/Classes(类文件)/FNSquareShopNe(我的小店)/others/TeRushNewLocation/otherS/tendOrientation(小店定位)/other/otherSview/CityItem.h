//
//  CityItem.h
//  69橙子
//
//  Created by 李显 on 2018/12/9.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CityItem : NSObject
@property (nonatomic, assign) NSInteger key;
@property (nonatomic, copy) NSString *titleName;

- (instancetype)initWithTitleName:(NSString *)titleName;
+ (instancetype)initWithTitleName:(NSString *)titleName;

@end


