//
//  FNtradePlayClassifyController.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/6/24.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "SuperViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNtradePlayClassifyController : SuperViewController
@property (nonatomic,strong)NSString *keyWord;
@property (nonatomic,strong)NSString *cateId;
@property (nonatomic,strong)NSString *is_video;//显示列表样式 (0文章  1代表视频) 注:具体跳转还要根据搜索结果的类型判断
@property (nonatomic,strong)NSString *kwString;//搜索内容
@end

NS_ASSUME_NONNULL_END
