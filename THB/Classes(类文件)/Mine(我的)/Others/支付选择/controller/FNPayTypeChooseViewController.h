//
//  FNPayTypeChooseViewController.h
//  THB
//
//  Created by Fnuo-iOS on 2018/6/15.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "SuperViewController.h"
#import "PayTypeModel.h"
#import "FNPayTypeChooseCell.h"

@interface FNPayTypeChooseViewController : SuperViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy)void (^successCheckBlock)(NSString *PayType);

@property (nonatomic,strong)NSArray<PayTypeModel *> *PayModel;

@end
