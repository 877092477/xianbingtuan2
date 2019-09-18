//
//  FNAstrictDeliverysController.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/26.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "SuperViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol FNAstrictDeliverysControllerDelegate <NSObject>
// 编辑
- (void)didmerDeliverysAction:(NSIndexPath*)index withContent:(NSString*)content withType:(NSString*)keyType;
//配送时间
- (void)didmerDeliverysDateAction:(NSIndexPath*)index withStartTime:(NSString*)startTime withEndTime:(NSString*)endTime;
// 不限制
- (void)didmerDeliverysNoLimitAction:(NSIndexPath*)index withContent:(NSString*)content withType:(NSString*)keyType;
@end
@interface FNAstrictDeliverysController : SuperViewController
@property (nonatomic, strong)NSString *keyWord;
@property (nonatomic, strong)NSIndexPath  *backIndex;
@property (nonatomic, weak)id<FNAstrictDeliverysControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
