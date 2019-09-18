//
//  FNRushDeliveryLocationNeCell.h
//  69橙子
//
//  Created by Jimmy on 2018/11/29.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FNrushPurchaseNeModel.h"

@interface FNRushDeliveryLocationNeCell : UITableViewCell
/**  右边方向图片 **/
@property(nonatomic, strong) UIImageView* directionView;
/**  地址 **/
@property(nonatomic, strong) UILabel *locationLb;
/**  名字和电话 **/
@property(nonatomic, strong) UILabel *namejoLb;
/**  line **/
@property(nonatomic, strong) UILabel *lineLb; 
/**  model **/
@property(nonatomic, strong) NSDictionary *model;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end


