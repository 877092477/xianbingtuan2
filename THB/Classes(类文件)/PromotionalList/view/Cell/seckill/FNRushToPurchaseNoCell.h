//
//  FNRushToPurchaseNoCell.h
//  THB
//
//  Created by Jimmy on 2018/9/14.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import "JMTableViewCell.h"

@interface FNRushToPurchaseNoCell : JMTableViewCell


@property (nonatomic, strong)FNBaseProductModel* model;
@property (nonatomic, strong)NSIndexPath* indexPath;
@property (nonatomic, copy)void (^ActionAdmonishNow)(FNBaseProductModel * model);
 
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
