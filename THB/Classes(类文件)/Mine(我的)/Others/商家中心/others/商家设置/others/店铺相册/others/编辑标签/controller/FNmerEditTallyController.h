//
//  FNmerEditTallyController.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/7/1.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "SuperViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol FNmerEditTallyControllerDelegate <NSObject>
// 编辑标签成功刷新
- (void)inDidMerEditTallyRefreshAction;
@end
@interface FNmerEditTallyController : SuperViewController
@property (nonatomic, strong)NSString *lableWord;
@property (nonatomic, strong)NSString *lableWordID;
@property (nonatomic, weak)id<FNmerEditTallyControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
