//
//  FNtendOrderItemDaNeCell.h
//  69橙子
//
//  Created by Jimmy on 2018/12/6.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNtendOderItemNeModel.h"
@protocol FNtendOrderItemDaNeCellDelegate <NSObject>
// 选择
- (void)InTendOrderItemAction:(NSIndexPath *)indexPath;
- (void)InTendOrderCancleAction:(NSIndexPath *)indexPath;
- (void)InTendOrderCommentAction:(NSIndexPath *)indexPath;
- (void)InTendOrderConfirmAction:(NSIndexPath *)indexPath;

@end

@interface FNtendOrderItemDaNeCell : UITableViewCell

/** BG **/
@property (nonatomic, strong)UIView *bgView;
/** 时间 **/
@property (nonatomic, strong)UILabel* dateLB;
/** 状态 **/
@property (nonatomic, strong)UILabel* stateLB;
/** 商品图片 **/
@property (nonatomic, strong)UIImageView* goodsImage;
/** 名字  **/
@property (nonatomic, strong)UILabel* nameLB;
/** 简介  **/
@property (nonatomic, strong)UILabel* messageLB;
/** 价格  **/
@property (nonatomic, strong)UILabel* priceLB;
/** 预计  **/
@property (nonatomic, strong)UILabel* predictLB;
/** 点击状态  **/
@property (nonatomic, strong)UIButton* seletedButton;
@property (nonatomic, strong)UIButton* cancleButton;
/** model **/
//@property (nonatomic, strong)NSDictionary* model;
/** model **/
@property (nonatomic, strong)FNtendOderItemNeModel* model;
/** other **/
@property (nonatomic, strong)NSIndexPath *indexPath;
/** delegate **/
@property(nonatomic ,weak) id<FNtendOrderItemDaNeCellDelegate> delegate;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end


