//
//  FNArticleHomepageDModel.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/18.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNArticleHomepageDModel : NSObject
@property (nonatomic , copy) NSString              * str;//    是    string    文字    600篇文章
@property (nonatomic , copy) NSString              * readtimes;//    是    string    浏览量
@property (nonatomic , copy) NSString              * talent_name;//    是    string    达人名号
@property (nonatomic , copy) NSString              * talent_id;//    是    string    达人id
@property (nonatomic , copy) NSString              * head_img;//    是    string    达人头像    达人头像
@property (nonatomic , copy) NSArray               * list;//    是    array    数组

@end

NS_ASSUME_NONNULL_END
