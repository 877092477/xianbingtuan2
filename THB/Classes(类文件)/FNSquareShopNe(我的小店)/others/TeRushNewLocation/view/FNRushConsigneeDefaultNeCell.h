//
//  FNRushConsigneeDefaultNeCell.h
//  69橙子
//
//  Created by Jimmy on 2018/12/1.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FNRushConsigneeDefaultNeCellDelegate <NSObject>
// 默认
- (void)InConsigneeDefaultAction:(NSIndexPath *)indexPath withDefault:(NSString*)type;

@end

@interface FNRushConsigneeDefaultNeCell : UITableViewCell
/** 右边标题 **/
@property (nonatomic, strong)UILabel* leftLabel;
/** 默认按钮 **/
@property (nonatomic, strong)UIButton *defaultButton;
/** 默认按钮 **/
@property (nonatomic, strong)UISwitch * defaultSwitch;
/** other **/
@property (nonatomic, strong)NSIndexPath *indexPath;
/** model **/
@property (nonatomic, strong)NSDictionary* model;

@property(nonatomic ,weak) id<FNRushConsigneeDefaultNeCellDelegate> delegate;
@end


