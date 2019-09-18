//
//  JMHomeProductTwoCell.h
//  嗨如意
//
//  Created by Fnuo-iOS on 2018/6/14.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#define JMHPCellImgHeight 120
@class FNBaseProductModel;
@interface JMHomeProductTwoCell : UITableViewCell

@property (nonatomic, strong)FNBaseProductModel* model;
@property (nonatomic, strong)void (^starBtnActionBlock)(NSIndexPath* sender);
@property (nonatomic, copy)void (^sharerightNow)(FNBaseProductModel * model);

@property (nonatomic, strong)NSIndexPath* indexPath;
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;
@end
