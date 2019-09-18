//
//  JMProductDetailModel.h
//  THB
//
//  Created by jimmy on 2017/4/20.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JMProductDetailRuleModel;
@interface JMProductDetailModel : NSObject
/**
 *  ID
 */
@property (nonatomic, copy)NSString* ID;

@property (nonatomic, copy)NSString* fnuo_url;

@property (nonatomic, copy)NSString* share_url;

@property (nonatomic, copy)NSString* fnuo_id;

@property (nonatomic, copy)NSString* str;

@property (nonatomic, copy)NSString* commission;

@property (nonatomic, copy)NSString* is_collect;

@property (nonatomic, strong)NSArray<JMProductDetailRuleModel *>* rule;

@end
@interface JMProductDetailRuleModel : NSObject
/**
 *  title
 */
@property (nonatomic, copy)NSString* title;
/**
 *  content
 */
@property (nonatomic, copy)NSString* content;
@property (nonatomic, assign)CGFloat height;
@end
