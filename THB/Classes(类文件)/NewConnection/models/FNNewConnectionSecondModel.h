//
//  FNNewConnectionSecondModel.h
//  新版嗨如意
//
//  Created by Weller on 2019/6/14.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNNewConnectionMemModel.h"
#import "FNNewConnectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNNewConnectionSecondModel : NSObject

@property (nonatomic, copy) NSString *bj_img;
@property (nonatomic, strong) NSArray<FNNewConnectionMemModel*> *list;
@property (nonatomic, copy) NSString *top_title;
@property (nonatomic, strong) NSArray<FNNewConnectionCateListModel*> *search_data;

@end

NS_ASSUME_NONNULL_END
