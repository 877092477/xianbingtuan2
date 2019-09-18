//
//  FNstoreInformationDaModel.m
//  69橙子
//
//  Created by Jimmy on 2018/11/27.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNstoreInformationDaModel.h"

@implementation FNstoreCouponeModel

@end

@implementation FNstoreInformationCateModel

@end

@implementation FNstoreInformationDaModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"banner":[NSString class],
             @"yhq_list":[FNstoreCouponeModel class],
             @"cates": [FNstoreInformationCateModel class]
             };
}

@end

@implementation FNstoreBtnItemModel

@end
