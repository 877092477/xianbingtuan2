//
//  FNNetCouponeReceiveCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/11.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FNNetCouponeReceiveCell;
@protocol FNNetCouponeReceiveCellDelegate <NSObject>

- (void)didRemindClick: (FNNetCouponeReceiveCell*) cell;

@end

@interface FNNetCouponeReceiveCell : UITableViewCell

@property (nonatomic, weak) id<FNNetCouponeReceiveCellDelegate> delegate;

@property (nonatomic, strong) UIView *vContent;
@property (nonatomic, strong) UILabel *lblPrice;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;
@property (nonatomic, strong) UILabel *lblCount;
@property (nonatomic, strong) UIProgressView *prgCount;

@property (nonatomic, strong) UILabel *lblReceive;
@property (nonatomic, strong) UIImageView *imgRight;

@property (nonatomic, strong) UIView *vRight;
@property (nonatomic, strong) UILabel *lblRightTitle;
@property (nonatomic, strong) UIView *vTime;
@property (nonatomic, strong) UIView *vHour;
@property (nonatomic, strong) UILabel *lblHour;
@property (nonatomic, strong) UIView *vMin;
@property (nonatomic, strong) UILabel *lblMin;
@property (nonatomic, strong) UIView *vSecond;
@property (nonatomic, strong) UILabel *lblSecond;
@property (nonatomic, strong) UILabel *lblSymbol1;
@property (nonatomic, strong) UILabel *lblSymbol2;

@property (nonatomic, strong) UIButton *btnRemind;

- (void)setTime: (NSDate *)startTime ;

@end

NS_ASSUME_NONNULL_END
