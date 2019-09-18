//
//  FNCommColumnItController.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/4/28.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
#import "MenuModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNCommColumnItController : SuperViewController
@property (nonatomic,strong)NSString *keyWord;
@property (nonatomic,strong)NSString *SkipUIIdentifier;
@property (nonatomic,strong)NSString *show_type_str;
@property (nonatomic,strong)NSDictionary *headModel;
@end

NS_ASSUME_NONNULL_END
