//
//  FNRushCommodityMeNeCell.h
//  69橙子
//
//  Created by Jimmy on 2018/11/29.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FNrushPurchaseNeModel.h"

@interface FNRushCommodityMeNeCell : UITableViewCell
/**  商品图片 **/
@property(nonatomic, strong) UIImageView* goodsView;
/**  名字和其他 **/
@property(nonatomic, strong) UILabel *nameLb;
/**  价格和数量 **/
@property(nonatomic, strong) UILabel *quantityLb;
/**  line **/
@property(nonatomic, strong) UILabel *lineLb;
/**  model **/
@property(nonatomic, strong) FNrushPurchCartNeModel *model;


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end

