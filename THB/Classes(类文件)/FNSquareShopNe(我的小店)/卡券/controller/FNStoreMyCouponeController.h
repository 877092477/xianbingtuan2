//
//  FNStoreMyCouponeController.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/2.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStoreMyCouponeModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FNStoreMyCouponeController;
@protocol FNStoreMyCouponeControllerDelegate <NSObject>

- (void) couponeVc: (FNStoreMyCouponeController*)vc didSelected: (FNStoreMyCouponeModel*)coupone;

@end

@interface FNStoreMyCouponeController : SuperViewController

@property (nonatomic, weak) id<FNStoreMyCouponeControllerDelegate> delegate;


// 设置数据
- (void) setCoupones:(NSArray<FNStoreMyCouponeModel*>*) coupones;


// 如果设置了类型，就会请求网络
@property (nonatomic, copy) NSString* cate_type;

@end

NS_ASSUME_NONNULL_END
