//
//  FNOtherRebateController.h
//  THB
//
//  Created by Fnuo-iOS on 2018/5/5.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
#import "OtherRebateModel.h"
#import "JMTutorialController.h"
#import "FNTBRebateCell.h"
#import "ProductListViewController.h"
#import "FNOtherRebateHeader.h"
#import "FNGoodsListViewController.h"

@interface FNOtherRebateController : SuperViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)OtherRebateModel *Model;

@property(nonatomic,copy)NSString *SkipUIIdentifier;

@property (nonatomic,strong)FNOtherRebateHeader *header;

@end
