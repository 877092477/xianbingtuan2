//
//  FNTBRebateCell.h
//  THB
//
//  Created by jimmy on 2017/10/31.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "XYSuperTableViewCell.h"
@class FNTBRebateHotModel,XYTitleModel;
@interface FNTBRebateCell : XYSuperTableViewCell
@property (nonatomic, strong)NSIndexPath* indexPath;
@property (nonatomic, strong)NSArray<FNTBRebateHotModel *>* hotsearchs;
@property (nonatomic, strong)NSArray<XYTitleModel *>* categories;
@property (nonatomic, copy)void (^btnClicked)(NSString*title,NSString*cid,BOOL isCate);
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
@end
