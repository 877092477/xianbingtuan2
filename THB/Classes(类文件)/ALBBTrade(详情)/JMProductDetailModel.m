//
//  JMProductDetailModel.m
//  THB
//
//  Created by jimmy on 2017/4/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMProductDetailModel.h"

@implementation JMProductDetailModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return  @{@"ID":@"id"};
}
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"rule":[JMProductDetailRuleModel class]};
}
@end
@implementation JMProductDetailRuleModel

- (CGFloat)height{
    UIImage* image = IMAGE(@"good_detail_q");
    CGRect rect1 = [_title boundingRectWithSize:(CGSizeMake(FNDeviceWidth-20-image.size.width-5, CGFLOAT_MAX)) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:kFONT14} context:nil];
    CGRect rect2 = [_content  boundingRectWithSize:(CGSizeMake(FNDeviceWidth-20-image.size.width-5, CGFLOAT_MAX)) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:kFONT14} context:nil];
    _height = rect1.size.height + _jm_margin10*3 +rect2.size.height;
    return _height;
}

@end
