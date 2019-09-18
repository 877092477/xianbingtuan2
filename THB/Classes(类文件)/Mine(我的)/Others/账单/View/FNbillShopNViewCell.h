//
//  FNbillShopNViewCell.h
//  THB
//
//  Created by Jimmy on 2018/9/6.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FNBillDetailsModel;

@protocol FNbillShopNViewCellDelegate <NSObject>

//点击复制
-(void)ClickTocopy:(NSIndexPath*)sender;

@end
@interface FNbillShopNViewCell : UITableViewCell



/** 自购获得 **/
@property (nonatomic, strong)UILabel *purchaseTitle;
/** 获得金额 **/
@property (nonatomic, strong)UILabel *acquireTitle;
/** 预计到账时间 **/
@property (nonatomic, strong)UILabel *timeTitle;
/** 订单编号 **/
@property (nonatomic, strong)UILabel *orderTitle;
/** 复制 **/
@property (nonatomic, strong)UIButton *selectBtn;
/** 商品类型 例:拼多多 **/
@property (nonatomic, strong)UILabel *typeTitle;

@property (nonatomic, strong)FNBillDetailsModel *model;

@property (nonatomic, strong)NSIndexPath  *IndexPath;

@property(nonatomic ,weak) id<FNbillShopNViewCellDelegate> delegate;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
