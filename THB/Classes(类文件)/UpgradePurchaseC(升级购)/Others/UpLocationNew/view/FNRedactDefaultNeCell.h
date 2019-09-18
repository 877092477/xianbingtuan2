//
//  FNRedactDefaultNeCell.h
//  THB
//
//  Created by Jimmy on 2018/9/29.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNUpAddressNeModel.h"

@protocol FNRedactDefaultNeCellDelegate <NSObject>
// 默认
- (void)InRedactDefaultAction:(NSIndexPath *)indexPath withDefault:(NSString*)type;

@end
@interface FNRedactDefaultNeCell : UITableViewCell

/** 右边标题 **/
@property (nonatomic, strong)UILabel* leftLabel;

/** 默认按钮 **/
@property (nonatomic, strong)UIButton *defaultButton;

/** other **/
@property (nonatomic, strong)NSIndexPath *indexPath;
/** model **/
@property (nonatomic, strong)FNUpAddressNeModel* model;

@property(nonatomic ,weak) id<FNRedactDefaultNeCellDelegate> delegate;

@end
