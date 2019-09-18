//
//  FNUpDetailsReferralNCell.h
//  THB
//
//  Created by Jimmy on 2018/9/26.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDSlideBar.h"

@protocol FNUpDetailsReferralNCellDelegate <NSObject>
// 点击
- (void)likeBtnClickAction:(NSInteger)sender;

@end
@interface FNUpDetailsReferralNCell : UITableViewCell

@property (nonatomic, assign)NSInteger printInt;
@property (nonatomic, strong)FDSlideBar *ReferralBar;//分栏

/** 介绍 **/
@property (nonatomic, strong)UIButton* referralBtn;

/** 参数 **/
@property (nonatomic, strong)UIButton* parameterBtn;

@property(nonatomic ,weak) id<FNUpDetailsReferralNCellDelegate> delegate;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
