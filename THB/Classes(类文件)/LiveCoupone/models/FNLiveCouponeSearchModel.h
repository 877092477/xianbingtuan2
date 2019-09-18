//
//  FNLiveCouponeSearchModel.h
//  新版嗨如意
//
//  Created by Weller Zhao on 2019/4/29.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNLiveCouponeSearchHotModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *is_hot;

@end

@interface FNLiveCouponeSearchModel : NSObject

@property (nonatomic, copy) NSString *search_img;
@property (nonatomic, copy) NSString *search_btnimg;
@property (nonatomic, copy) NSString *search_copyimg;
@property (nonatomic, copy) NSString *search_btnstr;
@property (nonatomic, copy) NSString *search_btncolor;
@property (nonatomic, copy) NSString *search_str;
@property (nonatomic, copy) NSString *str_copy;
@property (nonatomic, strong) NSArray<FNLiveCouponeSearchHotModel*> *search_list;
@property (nonatomic, copy) NSString *str;
@property (nonatomic, copy) NSString *his_str;

@end

NS_ASSUME_NONNULL_END
