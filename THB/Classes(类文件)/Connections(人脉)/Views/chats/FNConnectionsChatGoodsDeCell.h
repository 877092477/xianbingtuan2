//
//  FNConnectionsChatGoodsDeCell.h
//  THB
//
//  Created by Jimmy on 2019/2/20.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNConnectionsChatTextCell.h"
#import "FNChatModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNConnectionsChatGoodsDeCell : UITableViewCell
@property (nonatomic, strong) UIImageView *imgHeader; 
/** bgView **/
@property (nonatomic, strong)UIImageView* bgView;
/** 选择按钮 **/
@property (nonatomic, strong)UIButton* choiceBtn;
/** 商品图片 **/
@property (nonatomic, strong)UIImageView* goodsImg;
/** 名字 **/
@property (nonatomic, strong)UILabel* nameLB;
/** 价格 **/
@property (nonatomic, strong)UILabel* sumLB;
/** 已售 **/
@property (nonatomic, strong)UILabel* soldLB;
/** 预估收益 **/
@property (nonatomic, strong)UILabel* estimateLB;
/** 券图片 **/
@property (nonatomic, strong)UIImageView* ticketImg;
/** 券金额 **/
@property (nonatomic, strong)UILabel* ticketLB;
/** 券图片 **/
@property (nonatomic, strong)FNChatGoodsModel *model;

-(void)setwithHeader:(NSString*)imgUrl isLeft:(BOOL)isLeft withStatus: (int)status ;

@property (nonatomic, weak) id<FNConnectionsChatCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
