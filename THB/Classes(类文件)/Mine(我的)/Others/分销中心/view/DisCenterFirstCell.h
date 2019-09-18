//
//  DisCenterFirstCell.h
//  THB
//
//  Created by zhongxueyu on 16/7/28.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import <UIKit/UIKit.h>
#import "FXCenterInfoModel.h"

@protocol ButtonClickDelegate <NSObject>

-(void)ButtonClickMethod:(NSInteger )tag;

@end

@interface DisCenterFirstCell : UITableViewCell


/** 累计佣金 **/
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;

/** 可提佣金 **/
@property (weak, nonatomic) IBOutlet UILabel *usedMoneyLabel;

/** 用户名 **/
@property (weak, nonatomic) IBOutlet UILabel *nickName;

/** 加入时间 **/
@property (weak, nonatomic) IBOutlet UILabel *registerTime;

/** 查看明细 **/
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

/** 提现按钮 **/
@property (weak, nonatomic) IBOutlet UIButton *drawBtn;

/** 我的佣金 **/
@property (weak, nonatomic) IBOutlet UIButton *MyComssionCenter;

/** 头像 **/
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;

@property (nonatomic,strong) FXCenterInfoModel *model;

@property (nonatomic,assign) id<ButtonClickDelegate> delegate;



@end
