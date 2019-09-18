//
//  FNteIndentResultNeCell.h
//  69橙子
//
//  Created by Jimmy on 2018/12/6.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNtendOrderDetailsDeModel.h"
@protocol FNteIndentResultNeCellDelegate <NSObject>

// 再来一单
- (void)inTeIndentRecurAction;

- (void)inTeIndentCancleAction;

- (void)inTeIndentPayAction;


@end

@interface FNteIndentResultNeCell : UITableViewCell
/** 标题 **/
@property (nonatomic, strong)UILabel* titleLB;
/** 致语 **/
@property (nonatomic, strong)UILabel* sendLB;
/** line **/
@property (nonatomic, strong)UILabel* lineLB;
/** 金额 **/
@property (nonatomic, strong)UILabel* figureLB;
/** 再来一单 **/
@property (nonatomic, strong)UIButton* recurButton;
/** 取消订单**/
@property (nonatomic, strong)UIButton* cancleButton;
/**  delegate  **/
@property(nonatomic ,weak) id<FNteIndentResultNeCellDelegate> delegate;
@property(nonatomic , strong)FNtendOrderDetailsDeModel *model;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end


