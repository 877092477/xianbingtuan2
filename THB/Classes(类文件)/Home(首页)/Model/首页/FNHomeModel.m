//
//  FNHomeModel.m
//  THB
//
//  Created by zhongxueyu on 2018/8/17.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "FNHomeModel.h"

@implementation FNHomeModel
- (RACSubject *)kuaisurukouSubject{
    if (_kuaisurukouSubject == nil) {
        _kuaisurukouSubject = [RACSubject subject];
    }
    return _kuaisurukouSubject;
}

@end
