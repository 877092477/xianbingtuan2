//
//  FNNewProductDetailModel.m
//  THB
//
//  Created by Jimmy on 2017/12/16.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNNewProductDetailModel.h"

@implementation FNNewProductDetailModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[super mj_replacedKeyFromPropertyName]];
    
    dict[@"doc_copy_str"] = @"copy_doc_str";
    dict[@"doc_copy_color"] = @"copy_doc_color";
    dict[@"doc_copy_btncolor"] = @"copy_doc_btncolor";
    
    return dict;
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"xggoodsArr":[FNBaseProductModel class]};
}
- (NSMutableArray *)images{
    if (_images == nil) {
        _images = [NSMutableArray new];
    }
    return _images;
}
@end

@implementation FNNewProductCommentDataModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"images":[NSString class]};
}
@end

@implementation FNNewProductCommentModel
@end

@implementation JM_NPD_dpArr
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"fs":[JM_NPD_fs class]};
}
@end
@implementation JM_NPD_fs
@end

@implementation FNNewProductDetailCouponeModel
@end
