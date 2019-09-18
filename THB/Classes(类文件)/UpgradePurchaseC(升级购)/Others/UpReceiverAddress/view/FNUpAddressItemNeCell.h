//
//  FNUpAddressItemNeCell.h
//  THB
//
//  Created by Jimmy on 2018/9/28.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNUpAddressNeModel.h"

@protocol FNUpAddressItemNeCellDelegate <NSObject>
// 编辑
- (void)InAddressItemCopyreaderAction:(NSIndexPath *)indexPath;

@end

@interface FNUpAddressItemNeCell : UITableViewCell


/** 姓 **/
@property (nonatomic, strong)UILabel* lastnameLB;

/** 名字 **/
@property (nonatomic, strong)UILabel* nameLabel;

/** 电话 **/
@property (nonatomic, strong)UILabel* numberLabel;

/** 地址 **/
@property (nonatomic, strong)UILabel* siteLabel;

/** rightLine **/
@property (nonatomic, strong)UILabel* rightLine;

/** 编辑 **/
@property (nonatomic, strong)UIButton *compileButton;

/** 默认地址 **/
@property (nonatomic, strong)UILabel* defaultLB;

/** Line **/
@property (nonatomic, strong)UILabel* LineLB;

/** model **/
@property (nonatomic, strong)FNUpAddressNeModel* model;

/** other **/
@property (nonatomic, strong)NSIndexPath *indexPath;

@property(nonatomic ,weak) id<FNUpAddressItemNeCellDelegate> delegate;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
