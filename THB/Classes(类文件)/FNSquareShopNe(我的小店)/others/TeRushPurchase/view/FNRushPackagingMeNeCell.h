//
//  FNRushPackagingMeNeCell.h
//  69橙子
//
//  Created by Jimmy on 2018/11/29.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FNrushPurchaseNeModel.h"

@interface FNRushPackagingMeNeCell : UITableViewCell
/**  种类费用 **/
@property(nonatomic, strong) UILabel* packLb;
/**  名字  **/
@property(nonatomic, strong) UILabel *nameLb;
/**  价格  **/
@property(nonatomic, strong) UILabel *priceLb;
/**  line **/
@property(nonatomic, strong) UILabel *lineLb;
/**  model **/
@property(nonatomic, strong) FNrushPurchCartNeModel *model;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end


