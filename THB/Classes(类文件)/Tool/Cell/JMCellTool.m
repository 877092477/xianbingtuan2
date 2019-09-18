//
//  JMCellTool.m
//  THB
//
//  Created by Jimmy on 2017/12/28.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMCellTool.h"
#import "HomeViewController.h"
#import "JMHomeProductCell.h"
#import "JMHomeProductTwoCell.h"
#import "FNHomeSpecialCell.h"
#if APP_XYJ == 1
#import "XYJHomeTCell.h"
#endif
@implementation JMCellTool
+ (UITableViewCell *)tableView:(UITableView *)tableview atIndexPath:(NSIndexPath *)indexPath superVC:(SuperViewController *)vc andModel:(id)model{
#if APP_XYJ == 1
    XYJHomeTCell *cell = [XYJHomeTCell cellWithTableView:tableview atIndexPath:indexPath];
    cell.model = model;
    return cell;
#else
//    if ([FNBaseSettingModel settingInstance].goods_flstyle.boolValue) {
//        FNHomeSpecialCell* cell = [FNHomeSpecialCell cellWithTableView:tableview atIndexPath:indexPath];
//        cell.model = model;
//        return cell;
//    }else{
        if ([vc isKindOfClass:[HomeViewController class]]) {
            JMHomeProductTwoCell* cell = [JMHomeProductTwoCell cellWithTableView:tableview atIndexPath:indexPath];
            cell.sharerightNow = ^(FNBaseProductModel *mod) {
                if (vc) {
                    [vc shareProductWithModel:mod];
                }
            };
            cell.model = model;
            return cell;
        }else{
            JMHomeProductCell* cell = [JMHomeProductCell cellWithTableView:tableview atIndexPath:indexPath];
            cell.sharerightNow = ^(FNBaseProductModel *mod) {
                if (vc) {
                    [vc shareProductWithModel:mod];
                }
            };
            cell.model = model;
            return cell;
//        }
    }
#endif
   
}
+ (CGFloat)cellHeightTableview:(UITableView *)tableview atIndexPath:(NSIndexPath*)indexPath andModel:(id)model{
    CGFloat height = JMHPCellImgHeight+20;
#if APP_XYJ == 1
    height += 10;
#endif
    return height;
}
@end
