//
//  FNUpOrderSiteNeHeaderView.h
//  THB
//
//  Created by Jimmy on 2018/9/28.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FNUpOrderinformationNModel.h"

@protocol FNUpOrderSiteNeHeaderViewDelegate <NSObject>

/** 选择地址 **/
- (void)OrderSelectAddressAction;

@end

@interface FNUpOrderSiteNeHeaderView : UITableViewHeaderFooterView

/** BGview **/
@property (nonatomic, strong)UIView *siteBGview;

/** 图片 **/
@property (nonatomic, strong)UIImageView* siteImage;

/** 方向图片 **/
@property (nonatomic, strong)UIImageView* directionImage;

/** 底部图片 **/
@property (nonatomic, strong)UIImageView* bottomImage;

/** 名字 **/
@property (nonatomic, strong)UILabel* nameLabel;

/** 电话 **/
@property (nonatomic, strong)UILabel* numberLabel;

/** 地址 **/
@property (nonatomic, strong)UILabel* siteLabel;

/** 无地址地址 **/
@property (nonatomic, strong)UILabel* zeroAddress;

/** other **/
@property(nonatomic ,weak) id<FNUpOrderSiteNeHeaderViewDelegate> delegate;

/** model **/
@property (nonatomic, strong)NSDictionary* model;
 
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
