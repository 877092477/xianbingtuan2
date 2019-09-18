//
//  FNRushStoreSiteNeCell.h
//  69橙子
//
//  Created by Jimmy on 2018/11/29.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FNrushPurchaseNeModel.h"

@interface FNRushStoreSiteNeCell : UITableViewCell
/**  图片 **/
@property(nonatomic, strong) UIImageView* iconView;
/**  名字 **/
@property(nonatomic, strong) UILabel *nameLab;
/**  line **/
@property(nonatomic, strong) UILabel *lineLb; 
/**  model **/
@property(nonatomic, strong) NSDictionary *model;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end

 
