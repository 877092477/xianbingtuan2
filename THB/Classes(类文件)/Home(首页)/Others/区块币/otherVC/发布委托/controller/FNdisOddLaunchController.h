//
//  FNdisOddLaunchController.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "SuperViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol FNdisOddLaunchControllerDelegate <NSObject> 
//发布完成
- (void)didOddLaunchStateAction:(NSInteger)index;
@end
@interface FNdisOddLaunchController : SuperViewController
@property (nonatomic,strong)NSString *keyWord;
@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)NSString *jyType; 
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,weak) id<FNdisOddLaunchControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
