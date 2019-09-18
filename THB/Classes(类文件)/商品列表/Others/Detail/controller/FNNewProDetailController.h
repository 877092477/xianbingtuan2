//
//  FNNewProDetailController.h
//  THB
//
//  Created by Jimmy on 2017/12/16.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "SuperViewController.h"

@interface FNNewProDetailController : SuperViewController
@property (nonatomic, copy)NSString* fnuo_id;
@property (nonatomic, copy)NSString* goods_title;
@property (nonatomic, copy)NSString* getGoodsType;
@property (nonatomic, copy)NSString* SkipUIIdentifier;
@property (nonatomic, assign)BOOL isSearch;
@property (nonatomic, copy)NSString* yhqUrl;
//@property (nonatomic, strong)id  dataDict;
@property (nonatomic, strong)NSDictionary *data;
@property (nonatomic, assign)BOOL isLive;


@end
