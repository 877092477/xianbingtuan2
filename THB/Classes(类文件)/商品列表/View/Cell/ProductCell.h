//
//  ProductCell.h
//  THB
//
//  Created by zhongxueyu on 16/4/1.
//  Copyright © 2016年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYSuperTableViewCell.h"
#import "CatZanButton.h"
#import "FNBaseProductModel.h"
@interface ProductCell : XYSuperTableViewCell

/** 商品图片 */
@property (strong, nonatomic)  UIImageView *productImg;

/** 来自哪个网站 */
@property (strong, nonatomic)  UIImageView *shopImgView;

/** 标题 */
@property (strong, nonatomic)  UILabel *title;

/** 发货地 */
@property (strong, nonatomic)  UILabel *city;

/** 店铺名 */
@property (strong, nonatomic)  UILabel *shopName;

/** 价格 */
@property (strong, nonatomic)  UILabel *price;

/** 原价 */
@property (strong, nonatomic)  UILabel *oldPriceLabel;

/** 销量 */
@property (strong, nonatomic)  UILabel *sales;

/** 喜欢按钮 */
@property(nonatomic ,strong)CatZanButton *likeBtn;

@property (nonatomic,strong) FNBaseProductModel *model;
@property (nonatomic, strong)NSIndexPath* indexPath;
+ (instancetype)cellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;

@end
